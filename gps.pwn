/*

        SISTEMA DE GPS FLUTUANTE

        https://discord.gg/gh3GStXzHf
        https://discord.gg/gh3GStXzHf
        https://discord.gg/gh3GStXzHf


*/


new ObjetoGPS[MAX_PLAYERS];  
new Float:gps_x[MAX_PLAYERS], Float:gps_y[MAX_PLAYERS], Float:gps_z[MAX_PLAYERS];

enum gps_Info{
    gps_local[45],
    Float: gps_X,
    Float: gps_Y,
    Float: gps_Z
}

#include <YSI_Coding\y_hooks>

new locaisGPS[][gps_Info] = {
    {"Polícia em Los Santos", 1537.1061,-1675.3307,13.3828}, 
    {"Polícia em San Fierro",  -1566.8518,661.8513,7.1875}, 
    {"Polícia em Las Venturas",  2303.0977,2424.8372,10.8203},
    {"MÁD",  -2431.0439,493.3086,29.9255}, 
    {"Rodovia, esquina 51", 134.8955,1962.0944,19.477}, 
    {"Radar",  1628.4852,-1707.4111,13.3599},
    {"Dona Maria",  -2807.8381,-330.8951,7.0313}, 
    {"La Cosa Nostra",  1520.2190,2772.9888,10.6719}, 
    {"Yakuza",  2500.8674,1608.3457,10.7388},
    {"Grove Street",  2463.2759,-1659.1388,13.3047},
    {"E.S Ballas",  2219.5703,-1451.5961,23.8203},
    {"The Rifa",  2420.8711,-2009.8099,13.4293},
    {"El Corona", 1806.3767,-2112.9570,13.3828},
    {"LS Vagos",  2418.3826,-1092.1191,40.6577}
};


CMD:gps(playerid){

    DisablePlayerRaceCheckpoint(playerid); 
    DestroyObject(ObjetoGPS[playerid]); 
    gps_x[playerid] = 0.0;
    gps_y[playerid] = 0.0;
    gps_z[playerid] = 0.0;

    return Dialog_Show(playerid, GPS, 2, "Navegador", "Locais", "Próximo", "Cancelar");
}

Dialog:GPS(playerid, response, listitem, inputtext[]){

    if (!response) return 1;

    new string[2 * 250]; 

    for(new i = 0; i < sizeof locaisGPS; i++){
        format(string, sizeof string, "{fffffff}%s%s\t{9a9a9a}%.1f {ffffff}metros\n", string, locaisGPS[i][gps_local], GetPlayerDistanceFromPoint(playerid, locaisGPS[i][gps_X], locaisGPS[i][gps_Y], locaisGPS[i][gps_Z]));
    }
    Dialog_Show(playerid, D_GPS, DIALOG_STYLE_TABLIST, "Locais GPS", string, "Selecionar", "Cancelar");
    return 1;
}

Dialog:D_GPS(playerid, response, listitem, inputtext[]){

    if (!response) return 1;

    SendClientMessage(playerid, -1, va_return("Local {9a9a9a}%s {ffffff}Distância: {9a9a9a}%.2f {ffffff}Metros", locaisGPS[listitem][gps_local], GetPlayerDistanceFromPoint(playerid, locaisGPS[listitem][gps_X], locaisGPS[listitem][gps_Y], locaisGPS[listitem][gps_Z])));

    gps_x[playerid] = locaisGPS[listitem][gps_X];
    gps_y[playerid] = locaisGPS[listitem][gps_Y];
    gps_z[playerid] = locaisGPS[listitem][gps_Z];
    SetPlayerCheckpoint(playerid, locaisGPS[listitem][gps_X], locaisGPS[listitem][gps_Y], locaisGPS[listitem][gps_Z], 6.0);

    ObjetoGPS[playerid] = CreateObject(19133, 0, 0, 0, 0.0, 0.0, 0); 
    return 1;
}

hook OnPlayerUpdate(playerid){
        //ideal usar uma timer, caso nao queira so remover e deixa fora
        //AtualizarGPS(playerid);
    static delay[MAX_PLAYERS];
    
    if(delay[playerid] < gettime()){
        AtualizarGPS(playerid);
        delay[playerid] = gettime()+1;
    }
    return 1;
}

static stock Float:PointAngle(playerid, Float:xa, Float:ya, Float:xb, Float:yb) { 

    new Float:carangle; 
    new Float:xc, Float:yc; 
    new Float:angle; 
    xc = floatabs(floatsub(xa,xb)); 
    yc = floatabs(floatsub(ya,yb)); 
    if (yc == 0.0 || xc == 0.0) { 
        if (yc == 0 && xc > 0) angle = 0.0; 
        else if (yc == 0 && xc < 0) angle = 180.0; 
        else if (yc > 0 && xc == 0) angle = 90.0; 
        else if (yc < 0 && xc == 0) angle = 270.0; 
        else if (yc == 0 && xc == 0) angle = 0.0; 
    } else { 
        angle = atan(xc/yc); 
        if (xb > xa && yb <= ya) angle += 90.0; 
        else if (xb <= xa && yb < ya) angle = floatsub(90.0, angle); 
        else if (xb < xa && yb >= ya) angle -= 90.0; 
        else if (xb >= xa && yb > ya) angle = floatsub(270.0, angle); 
    } 
    GetVehicleZAngle(GetPlayerVehicleID(playerid), carangle); 
    return floatadd(angle, -carangle); 
}  

AtualizarGPS(playerid){  
    if(!IsPlayerInAnyVehicle(playerid))
        return;

    new Float:x, Float:y, Float:z, Float:r;
    GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z); 
    r = PointAngle(playerid, x, y, gps_x[playerid], gps_y[playerid]); 
    AttachObjectToVehicle(ObjetoGPS[playerid], GetPlayerVehicleID(playerid), 0.0, 0.0, 1.0, 0.0, 90.0, r); 
}
/*



                CADA UM COM SUA SORTE!!
                FAÇAM O RESTO, COLOQUE PRA QUANDO DESCER DO VEICULO, DESTRUIR O OBJETO DO PONTO < 0 >



*/
