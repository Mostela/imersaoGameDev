class Pontuacao {
  constructor() {
    this.pontos = 0
    this.pontosMil = 0
  }
  
  exibe() {
    textAlign(RIGHT)
    fill('#fff')
    textSize(50)
    text(parseInt(this.pontos), width - 30, 50)
  }
  
  adicionarPonto() {
    this.pontos = this.pontos + 0.2
    this.pontosMil = this.pontosMil + 0.2
    if(this.pontosMil >= 100){
      vida.ganhaVida()
      this.pontosMil = 0
    }
  }
}