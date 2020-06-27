function preload() {
  imagemCenario = loadImage('images/cenario/floresta.png');
  imagemTelaInicial = loadImage('images/assets/telaInicial.png');
  imagemGameOver = loadImage('images/assets/game-over.png');
  imagemPersonagem = loadImage('images/personagem/correndo.png');
  imagemInimigo = loadImage('images/inimigos/gotinha.png');
  imagemInimigoVoador = loadImage('images/inimigos/gotinha-voadora.png');
  imagemInimigoGrande = loadImage('images/inimigos/troll.png');
  imagemVida = loadImage('images/assets/coracao.png')

  fonteTelaInicial = loadFont('images/assets/fonteTelaInicial.otf');

  somDoJogo = loadSound('sons/trilha_jogo.mp3');
  somDoPulo = loadSound('sons/somPulo.mp3');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  telaInicial = new TelaInicial()
  jogo = new Jogo()
  cenas = {
    telaInicial,
    jogo
  }
  jogo.setup()
  botaoGerenciador = new BotaoGerenciador('Iniciar', width / 2, height / 2)

  frameRate(60)
  somDoJogo.loop();
}

function keyPressed() {
  jogo.keyPressed(key)
}

function draw() {
  // if(cenaAtual === 'jogo') {
  //   jogo.draw()
  // }
  cenas[cenaAtual].draw()
}