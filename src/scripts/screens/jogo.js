class Jogo {
  constructor() {
    this.indice = 0
    this.mapa = [
      {
        inimigo: 0,
        velocidade: 5
      },
      {
        inimigo: 1,
        velocidade: 8
      },
      {
        inimigo: 1,
        velocidade: 8
      },
      {
        inimigo: 2,
        velocidade: 10
      },
      {
        inimigo: 0,
        velocidade: 5
      },
      {
        inimigo: 0,
        velocidade: 3
      },
      {
        inimigo: 1,
        velocidade: 7
      },
      {
        inimigo: 2,
        velocidade: 10
      },
      {
        inimigo: 0,
        velocidade: 7
      },
      {
        inimigo: 2,
        velocidade: 12
      }
    ]
  }

  setup() {
    cenario = new Cenario(imagemCenario, 3);
    pontuacao = new Pontuacao()

    vida = new Vida(5,3)

    personagem = new Personagem(matrizPersonagem, imagemPersonagem, 0, 30, 110, 135, 220, 270);
    const inimigo = new Inimigo(matrizInimigo, imagemInimigo, width - 52, 30, 52, 52, 104, 104, 10);
    const inimigoVoador = new Inimigo(matrizInimigoVoador, imagemInimigoVoador, width - 52, 200, 100, 75, 200, 150, 10);
    const inimigoGrande = new Inimigo(matrizInimigoGrande, imagemInimigoGrande, width, 0, 200, 200, 400, 400, 10)

    inimigos.push(inimigo)
    inimigos.push(inimigoGrande)
    inimigos.push(inimigoVoador)
  }

  keyPressed(key) {
    if (key === 'ArrowUp') {
      personagem.pula()
      somDoPulo.play()
    }
  }

  draw() {
    const linhaAtual = this.mapa[this.indice]

    const inimigo = inimigos[linhaAtual.inimigo]
    const inimigoVisivel = inimigo.x < -inimigo.largura

    inimigo.alteraVelocidade(linhaAtual.velocidade)
    cenario.exibe();
    cenario.move();

    vida.draw();

    pontuacao.exibe()
    pontuacao.adicionarPonto()
    personagem.exibe();
    personagem.aplicaGravidade();

    inimigo.exibe()
    inimigo.move()
    
    if(inimigoVisivel) {
      this.indice++
      inimigo.aparecer()
      if(this.indice > this.mapa.length - 1) {
        this.indice = 0
      }
    }

    if (personagem.estaColidindo(inimigo)) {
      vida.perdeVida()
      personagem.tornaInvencivel()
      if(vida.vidas === 0){
        image(imagemGameOver, width/2 - 200, height/3)
        noLoop()
      }
    }
  }
}