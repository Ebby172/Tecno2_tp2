class Juego {
  FWorld mundo;
  FBox gato, marco, cajaFuerte, peluche, suelo,estante1,estante2,estante3,estante4,estante5,estante6;
  FCircle pelota; 
  
  int tiempoEntreCambios = 100;  // Tiempo en milisegundos entre cada cambio de imagen
  int ultimoCambio = 0;  // Último momento en el que se cambió la imagen
  
  float rectX = 1280/2;  // Posición inicial en X del rectángulo
  float rectY = 720/2;  // Posición inicial en Y del rectángulo 
  
  // Cuenta regresiva
  int duracionTotalSegundos = 60;  // Duración total en segundos
  int cuentaRegresiva;  // Tiempo restante 
  int tiempoInicioCuentaRegresiva;  // Tiempo en que se inició 
  
  // Score
  boolean incrementarScorePeluche = true;
  boolean incrementarScoreCajaFuerte= true;
  boolean incrementarScorePelota= true;
  boolean incrementarScoreMarco= true;
  
  PImage[] imagenesGato;  // Arreglo para almacenar las imágenes del gato
  PImage[] imagenesGato1;  // Arreglo para almacenar las imágenes del gato
  PImage imgGato, imgPelota, imgMarco,gatoVolador,gatoVoladorEspejado, imgCajaFuerte, imgPeluche, imgEstante,imgEstanteGrandeInvertido, imgEstanteGrande,imgEstanteChico,imgEstanteMediano, fondo,imgGato1,time,puntos;
  
  int indiceImagenIzquierda = 0;  // Índice para la animación izquierda
  int indiceImagenDerecha = 0;    // Índice para la animación derecha

  Juego() {
    imgEstante = loadImage("estante.png");
    imgEstanteGrande = loadImage("estanteGrande.png");
    imgEstanteGrandeInvertido = loadImage("estanteGrandeInvertido.png");
    imgEstanteChico = loadImage("estanteChico.png");
    imgEstanteMediano = loadImage("estanteMediano.png");
    imgPelota = loadImage("pelota.png");
    imgMarco = loadImage("Marco.png");
    imgCajaFuerte = loadImage("cajaFuerte.png");
    imgPeluche = loadImage("peluche.png");
    gatoVolador = loadImage("gatoVolador.png");
    gatoVoladorEspejado = loadImage("gatoVoladorEspejado.png");
    fondo = loadImage("fondoJuego.png");
    imgGato1 = loadImage("michi1.png");
    imgGato = loadImage("michi.png");
    puntos = loadImage("score.png");
    time = loadImage("time.png");

   imagenesGato = new PImage[3];  // Reemplaza 3 con el número total de imágenes de tu animación
   for (int i = 0; i < imagenesGato.length; i++) {
    imagenesGato[i] = loadImage("gato" + i + ".png");  // Ajusta la nomenclatura de tus imágenes
   }
  imagenesGato1 = new PImage[3];  // Reemplaza 3 con el número total de imágenes de tu animación
  for (int i = 0; i < imagenesGato1.length; i++) {
    imagenesGato1[i] = loadImage("gatoEspejado" + i + ".png");  // Usa imagenesGato1 en lugar de imagenesGato
  }
 
    mundo = new FWorld();
    mundo.setEdges();
    mundo.setGravity(0, 1200);
   
    displayObjetos();
    displayEstantes();
    displayGato();   
    displaySuelo(); 
  }
  
 // FBox crearEstante(float ancho, float alto, float x, float y, PImage img) {
 //   FBox estante = new FBox(ancho, alto);
 //   estante.setPosition(x, y);
 //   estante.setStatic(true);
  //  estante.setGrabbable(false);
  //  estante.attachImage(img);
 //   estante.setName("estante");
 //   mundo.add(estante);
 //   return estante;
 // }
  
  FBox crearBox(float ancho, float alto, float d, float x, float y, PImage img) {
    FBox objetoBox = new FBox(ancho, alto);
    objetoBox.setDensity(d);
    objetoBox.setPosition(x, y);
    objetoBox.attachImage(img);
    mundo.add(objetoBox);
    return objetoBox;
  }
  
  FCircle crearCircle(float tam, float x, float y, PImage img) {
    FCircle objetoCircle = new FCircle(tam);
    objetoCircle.setPosition(x, y);
    objetoCircle.attachImage(img);
    mundo.add(objetoCircle);
     
    return objetoCircle;
  }
  
  void iniciarCuentaRegresiva() {
    tiempoInicioCuentaRegresiva = millis();
  }
  
  void actualizarCuentaRegresiva() {
    int tiempoTranscurrido = millis() - tiempoInicioCuentaRegresiva;
    int tiempoRestante = duracionTotalSegundos * 1000 - tiempoTranscurrido;
    cuentaRegresiva = max(0, tiempoRestante / 1000);  // Evita valores negativos
  }

  void displayEstantes() {
     estante1 = new FBox(250, 20);
    estante1.setPosition(width / 4 + 20, height * 1 / 4);
    estante1.attachImage(imgEstanteMediano);
    estante1.setGrabbable(false);
     estante1.setStatic(true);
    mundo.add(estante1);
     estante2 = new FBox(250, 20);
    estante2.setPosition(51, height * 2 / 4);
    estante2.attachImage(imgEstanteGrandeInvertido);
    estante2.setGrabbable(false);
     estante2.setStatic(true);
     estante2.setRotation(60);
    mundo.add(estante2);
        estante3 = new FBox(300, 20);
    estante3.setPosition(width - 51, height * 2 / 4);
    estante3.attachImage(imgEstanteGrandeInvertido);
    estante3.setGrabbable(false);
     estante3.setStatic(true);
     estante3.setRotation(-60);
    mundo.add(estante3);
      estante4 = new FBox(300, 20);
    estante4.setPosition(width/2, height * 3 / 4);
    estante4.attachImage(imgEstanteGrande);
    estante4.setGrabbable(false);
     estante4.setStatic(true);
    mundo.add(estante4);
          estante5 = new FBox(200, 20);
    estante5.setPosition(width/2, height * 2 / 4);
    estante5.attachImage(imgEstanteChico);
    estante5.setGrabbable(false);
     estante5.setStatic(true);
    mundo.add(estante5);
             estante6 = new FBox(250, 20);
    estante6.setPosition( width * 3 / 4, height * 1  / 4);
    estante6.attachImage(imgEstanteMediano);
    estante6.setGrabbable(false);
     estante6.setStatic(true);
    mundo.add(estante6);
  }
  
  void displayObjetos() {
    // Crear la pelota al lado del gato
    pelota = crearCircle(50, width / 4, height * 1 / 4, imgPelota);
    pelota.setRestitution(1);

    // Crear objetos en los estantes rectos
    cajaFuerte = crearBox(59, 66, 600, width / 2, height * 2 / 4 - 33, imgCajaFuerte);
    cajaFuerte.setDensity(1);
    marco = crearBox(40, 40, 3, width*3/4, height * 1 / 4 - 20, imgMarco);
    peluche = crearBox(57, 67, 2, width / 2, height * 3 / 4 - 34, imgPeluche);
    peluche.setDensity(0.2);
    peluche.setRestitution(0.1);
    
  }
  
  void displayGato() {
    gato = new FBox(40, 40);
    gato.setPosition(250,0);
    gato.attachImage(imgGato);
    gato.setRotatable(false);
    gato.setGrabbable(false);
    gato.setName("gato");
    mundo.add(gato);
  }

  void displaySuelo() {
    suelo = new FBox(width, 55);
    suelo.setPosition(width / 2, height);
    suelo.setFill(255, 0, 0, 0);
    suelo.setNoStroke();
    suelo.setGrabbable(false);
    suelo.setStatic(true);
    suelo.setName("suelo");
    mundo.add(suelo);
  }

void movimientoPlayer(){
  float triangleWidth = width / 2;
  float triangleHeight = height / 2;
  
   // Rectangulo arriba (arriba centro)
  boolean isOverRect = isMouseOverTriangle(0, 0, -height / 2, 0, 0, width / 2);
  
  // Triángulo 1 (arriba izquierda)
  boolean isOverTriangle1 = isMouseOverTriangle(0, 0, -(triangleWidth-100), 0, 0, triangleHeight);
  
  // Triángulo 2 (arriba derecha)
  boolean isOverTriangle2 = isMouseOverTriangle(-width, 0,-( width - triangleWidth+100), 0, -width, triangleHeight);
  
  // Triángulo 3 (abajo izquierda)
  boolean isOverTriangle3 = isMouseOverTriangle(0, height, 0, height - triangleHeight, -triangleWidth, height);
  
  // Triángulo 4 (abajo derecha)
  boolean isOverTriangle4 = isMouseOverTriangle(-width, height,- width, height - triangleHeight, -(width - triangleWidth), height);
  
  if (isOverTriangle1 && (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() < suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY()) ) {
    // El mouse está sobre el triángulo izquierdo superior, mueve el rectángulo a la izquierda
     gato.addForce(-30000, -90000);
  } else if (isOverTriangle2 && (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() < suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY()) ) {
    // El mouse está sobre el triángulo derecho superior, mueve el rectángulo a la derecha
    gato.addForce(30000, -90000);
  } else if (isOverTriangle3 &&(gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() < suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY()) ) {
    // El mouse está sobre el triángulo izquierdo inferior, mueve el rectángulo hacia arriba
    
   gato.addForce(-2000, 0);
  } else if (isOverTriangle4 && (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() < suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY()) )  {
    // El mouse está sobre el triángulo derecho inferior, mueve el rectángulo hacia abajo
    gato.addForce(4000, 0);
    
  
  }
 if (pantallaCompletaX >= 540 && pantallaCompletaX <= 740 && pantallaCompletaY < height / 2 && (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() <= suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY()) ){
  gato.addForce(0, -90000);
}
  
  

}

boolean isMouseOverTriangle(float x1, float y1, float x2, float y2, float x3, float y3) {
  float denominator = ((y2 - y3) * (x1 - x3) + (x3 - x2) * (y1 - y3));
  float a = ((y2 - y3) * (pantallaCompletaX - x3) + (x3 - x2) * (pantallaCompletaY - y3)) / denominator;
  float b = ((y3 - y1) * (pantallaCompletaX - x3) + (x1 - x3) * (pantallaCompletaY - y3)) / denominator;
  float c = 1 - a - b;
  return a >= 0 && a <= 1 && b >= 0 && b <= 1 && c >= 0 && c <= 1;
}

void score(){
if (pelota.getY() > 660 && incrementarScorePelota) {
      score++; // Incrementar el score en 1
      incrementarScorePelota = false; // Evitar incrementar varias veces
    }
 if (cajaFuerte.getY() > 650 && incrementarScoreCajaFuerte) {
      score++; // Incrementar el score en 1
      incrementarScoreCajaFuerte = false; // Evitar incrementar varias veces
    }
     if (peluche.getY() > 650 && incrementarScorePeluche) {
      score++; // Incrementar el score en 1
      incrementarScorePeluche = false; // Evitar incrementar varias veces
    }
        if (marco.getY() > 660 && incrementarScoreMarco) {
      score++; // Incrementar el score en 1
      incrementarScoreMarco = false; // Evitar incrementar varias veces
    }
  
}
void espejarGato() {
  int tiempoActual = millis();
   if (tiempoActual - ultimoCambio >= tiempoEntreCambios) {
  if (pantallaCompletaX < -gato.getX()&& (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() <= suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY())) {
    // Si el mouse está a la izquierda del gato, cambia la imagen a la izquierda
   gato.attachImage(imagenesGato[indiceImagenDerecha]);
    indiceImagenDerecha = (indiceImagenDerecha + 1) % imagenesGato.length;
  } else if( pantallaCompletaX >= -gato.getX() && (gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||gato.isTouchingBody(suelo)&& gato.getY() <= suelo.getY()|| gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY())) {
    gato.attachImage(imagenesGato1[indiceImagenIzquierda]);  // Usa imagenesGato1
    indiceImagenIzquierda = (indiceImagenIzquierda + 1) % imagenesGato1.length;  // Usa imagenesGato1.length
    // Si el mouse está a la derecha del gato, cambia la imagen a la derecha
    
  }
  else if( pantallaCompletaX >= -gato.getX() && (!gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||!gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||!gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||!gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||!gato.isTouchingBody(suelo)&& gato.getY() <= suelo.getY()|| !gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||!gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||!gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| !gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| !gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || !gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY())) {
    // Si el mouse está a la derecha del gato, cambia la imagen a la derecha
   gato.attachImage(gatoVoladorEspejado);
  }
  else if( pantallaCompletaX < -gato.getX() && (!gato.isTouchingBody(marco)&& gato.getY() < marco.getY()||!gato.isTouchingBody(pelota)&& gato.getY() < pelota.getY()||!gato.isTouchingBody(cajaFuerte)&& gato.getY() < cajaFuerte.getY()||!gato.isTouchingBody(peluche)&& gato.getY() < peluche.getY()||!gato.isTouchingBody(suelo)&& gato.getY() <= suelo.getY()|| !gato.isTouchingBody(estante1)&& gato.getY() < estante1.getY()||!gato.isTouchingBody(estante2)&& gato.getY() < estante2.getY()||!gato.isTouchingBody(estante3)&& gato.getY() < estante3.getY()|| !gato.isTouchingBody(estante4)&& gato.getY() < estante4.getY()|| !gato.isTouchingBody(estante5)&& gato.getY() < estante5.getY()
 || !gato.isTouchingBody(estante6)&& gato.getY() < estante6.getY())) {
    // Si el mouse está a la derecha del gato, cambia la imagen a la derecha
   gato.attachImage(gatoVoladorEspejado);
  }
   // Actualiza el tiempo del último cambio de imagen
    ultimoCambio = tiempoActual;
   }
}

  void jugar() {
    background(0);
    image (fondo, 0, 0, width, height);
    noStroke();
    fill(255);
    textSize(25);
    image(puntos, width/2-500, 30);
    text(score+"", width/2-375, 63);
    image(time, width/2+275, 30);
    text(cuentaRegresiva+"", width/2+375, 63);
    movimientoPlayer();
    espejarGato();
    score();

    mundo.step();
    mundo.draw();
  }
} 
