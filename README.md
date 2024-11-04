
# Sistema de GPS Flutuante para SA-MP
  Este é um sistema de GPS flutuante criado para o SA-MP (San Andreas Multiplayer) que permite aos jogadores selecionar destinos pré-configurados no mapa e seguir um indicador visual anexado ao veículo. O sistema é implementado em PAWN e foi desenvolvido para facilitar a navegação dos jogadores até locais específicos no jogo.

# Funcionalidades
  Seleção de Locais: O sistema exibe uma lista de destinos populares, como delegacias, bases de facções e pontos específicos, permitindo ao jogador selecionar o destino desejado.
  Distância até o Destino: A distância entre o jogador e o local selecionado é calculada e exibida na tela.
  Indicador Visual Flutuante: Um objeto é anexado ao veículo do jogador, mostrando a direção para o destino, com orientação atualizada a cada segundo.
  Destruição Automática do Objeto: Quando o jogador sai do veículo, o sistema destrói automaticamente o indicador para evitar problemas visuais.
# Como Funciona
  Comando /gps: Exibe um menu de navegação com a lista de locais disponíveis.
  Escolha do Destino: O jogador escolhe o destino no menu, e a posição do local é marcada.
  Atualização do Indicador: A cada segundo, o sistema atualiza a orientação do indicador em relação ao destino.
  Destruição do Objeto: Ao sair do veículo, o objeto do GPS é destruído automaticamente.
  Requisitos
  YSI: O sistema usa a biblioteca YSI para hooks, garantindo maior controle e organização do código.
  
$ Notas
Timer Recomendado: Embora o sistema de atualização do GPS seja implementado no OnPlayerUpdate, recomenda-se o uso de uma timer para reduzir o impacto no desempenho.
Personalização: O script é fácil de personalizar, e novos locais podem ser adicionados na enumeração locaisGPS.

# Contato

discord <https://discord.gg/gh3GStXzHf>
