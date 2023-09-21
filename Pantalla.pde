class Pantalla {
  Juego juego;
  
  PImage inicio, fondo, btnJugar, btnCreditos, btnVolver,ganaste,creditos,puntos;

  float btnX = width/2 - 125;
  int btnJugarY = 500;
  int btnCreditosY = 600;
  
  Pantalla() {
    inicio = loadImage("fondoInicio.png");
    fondo = loadImage("pared.png");
    btnJugar = loadImage("jugar.png");
    btnCreditos = loadImage("creditos.png");
    ganaste = loadImage("fondoGanar.png");
    creditos = loadImage("fondoCreditos.png");
    puntos = loadImage("score.png");
    btnVolver = loadImage("volver.png");
  }

  void displayInicio() {
    image(inicio, 0, 0, width, height);
    image(btnJugar, btnX, btnJugarY);
    image(btnCreditos, btnX, btnCreditosY);
  }
  
  void displayCreditos() {
    image (creditos, 0, 0, width, height);

    // Botón de volver
    rectMode(CENTER);
    fill(100);
    
    imageMode(CORNER);
    
    image (btnVolver,width/2, height/2 + 170, 200, 60);
  }
  
 void displayGanar() {
  image (ganaste, 0, 0, width, height);
  image(puntos, width/2-105, height*2/4+67);
  fill(255);
  textSize(25);
  text( score, width/2+20, height*2/4+100);
   // Botón de volver
    
    imageMode(CENTER);
  image (btnVolver,width*3/4, height/2+170, 200, 60);
  imageMode(CORNER);
   
    
}
  
  void displayPerder() {
   
    image (fondo, 0, 0, width, height);
  }
}
