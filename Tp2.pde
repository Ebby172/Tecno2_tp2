import fisica.*;
import processing.sound.*;

SoundFile sonido;

FWorld mundo;
FBox michi;

FBox estante1;
FBox estante2;
FBox estante3;
FBox estante4;
FBox estanteInclinadoIzq;
FBox estanteInclinadoDer;
FCircle punteroLaser;
FBox objetoCajaFuerte;
FBox objeto2;
FBox objeto3;
FBox suelo;
FCircle pelota;

// Variable de estado
boolean pantallaDeInicio = true;
boolean jugando = false;
boolean mostrandoCreditos = false;
PImage pelotaIMG, fondo, cajaFuerte, inicio, michiIMG, estante100, estante150, estante300, peluche, btnJugar, btnCreditos, marco, botonJugar, botonCreditos;

// Botón de volver en la pantalla de créditos
boolean mostrarBotonVolver = false;

int score = 0;

boolean incrementarScore = true;
boolean incrementarScoreCajaFuerte= true;
boolean incrementarScoreObjeto2= true;
boolean incrementarScoreObjeto3= true;

float distanciaDeProximidad = 100; // Distancia para activar el salto

int tiempoAnterior = 0;
int intervalo = 3000; // Intervalo de tiempo en milisegundos (3 segundos)

void setup() {

  size(600, 600);

  Fisica.init(this);
  mundo = new FWorld();
  mundo.setEdges();
  
  sonido = new SoundFile(this, "breakstuff.mp3");
  sonido.play();

  pelotaIMG = loadImage("pelota.png");
  fondo = loadImage("pared.png");
  inicio = loadImage("inicio.png");
  cajaFuerte = loadImage("cajaFuerte.png");
  estante100 = loadImage("estante.png");
  estante150 = loadImage("estante.png");
  estante300 = loadImage("estanteGrande.png");
  peluche = loadImage("peluche.png");
  michiIMG = loadImage("michi.png");
  marco = loadImage("Marco.png");
  botonJugar = loadImage("jugar.png");
  botonCreditos = loadImage("creditos.png");
  
  btnJugar = loadImage("jugar.png");
  btnCreditos = loadImage("creditos.png");

  michi = new FBox(40, 40);
  michi.setPosition(width / 2, height / 2);
  michi.setFill(50);
  michi.setNoStroke();
  michi.setRotation(0);
  michi.attachImage(michiIMG);

  mundo.add(michi);
  michi.setGrabbable(false); // Evita que el personaje sea agarrado con el mouse


  pelota = new FCircle (50);
  pelota.setPosition(width * 3 / 4, height * 1 / 4);
  pelota.attachImage(pelotaIMG);
  pelota.setRestitution(1);
  mundo.add(pelota);

  objetoCajaFuerte = new FBox(59, 66);
  objetoCajaFuerte.setDensity(500);

  objetoCajaFuerte.setPosition(width / 4, height * 1 / 4 - 1);
  objetoCajaFuerte.attachImage(cajaFuerte);
  mundo.add(objetoCajaFuerte);

  objeto2 = new FBox(57, 67);
  objeto2.setPosition(width / 2, height * 3 / 4 - 1);
  objeto2.attachImage(peluche);
  mundo.add(objeto2);

  objeto3 = new FBox(40, 40);
  objeto3.setPosition(width / 2, height * 2 / 4 - 2);
  objeto3.attachImage(marco);
  mundo.add(objeto3);

  estante1 = new FBox(150, 10);
  estante1.setPosition(width / 4 + 20, height * 1 / 4);
  estante1.setStatic(true);
  estante1.attachImage(estante150);
  mundo.add(estante1);

  estanteInclinadoIzq = new FBox(150, 10);
  estanteInclinadoIzq.setPosition(51, height * 2 / 4);
  estanteInclinadoIzq.setRotation(60);
  estanteInclinadoIzq.attachImage(estante150);
  estanteInclinadoIzq.setStatic(true);
  mundo.add(estanteInclinadoIzq);

  estanteInclinadoDer = new FBox(100, 10);
  estanteInclinadoDer.setPosition(width - 51, height * 2 / 4);
  estanteInclinadoDer.setRotation(-60);
  estanteInclinadoDer.attachImage(estante100);
  estanteInclinadoDer.setStatic(true);
  mundo.add(estanteInclinadoDer);

  estante2 = new FBox(300, 10);
  estante2.setPosition(width / 2, height * 3 / 4);
  estante2.attachImage(estante300);
  estante2.setStatic(true);
  mundo.add(estante2);

  estante3 = new FBox(100, 10);
  estante3.setPosition(width / 2, height * 2 / 4);
  estante3.setStatic(true);
  estante3.attachImage(estante100);
  mundo.add(estante3);

  estante4 = new FBox(150, 10);
  estante4.setPosition(width * 3 / 4, height * 1 / 4);
  estante4.attachImage(estante150);
  estante4.setStatic(true);
  mundo.add(estante4);

  suelo = new FBox(150, 10);
  suelo.setPosition(width / 2, height);
  suelo.setStatic(true);
  mundo.add(suelo);
}

void draw() {
   
  if (pantallaDeInicio) {
    // Código de la pantalla de inicio...
    background(220);
    image (inicio, 0, 0, width, height);

    // Botón de jugar
    image(botonJugar, 182, 400);
    
    // Botón de créditos
    image(botonCreditos, 182, 500);
  } else if (jugando) {
    // Código para el estado "jugando"
    michi.setRotation(radians(0));
    noStroke();

    background(255);
    image (fondo, 0, 0, width, height);
    fill(255);
    text("Score:"+score+"", width/2, 50);
    fill(255, 60);
    float distanciaAlMouse = dist(michi.getX(), michi.getY(), mouseX, mouseY);

    // Si el mouse está lo suficientemente cerca, salta hacia el mouse
    if (distanciaAlMouse < distanciaDeProximidad) {
      float angulo = atan2(mouseY - michi.getY(), mouseX - michi.getX());
      float direccionX = cos(angulo);
      float direccionY = sin(angulo);
      michi.addForce(direccionX * 800, direccionY * 800); // Ajusta la fuerza según tu juego
      // Cambia la dirección y la fuerza del salto según tus necesidades


      // Obtén el tiempo actual en milisegundos
      int tiempoActual = millis();



      // Verifica si ha pasado el intervalo de 3 segundos
      if (tiempoActual - tiempoAnterior >= intervalo ) {
        // La parte del código que deseas ejecutar cada 3 segundos
        direccionX = 0; // Cambia esto para controlar la dirección del salto en el eje X
        direccionY = -1; // Cambia esto para controlar la dirección del salto en el eje Y
        michi.addForce(direccionX * 80000, direccionY * 60000); // Ajusta la fuerza según tu juego

        direccionX = 0; // Cambia esto para controlar la dirección del salto en el eje X
        direccionY = -1; // Cambia esto para controlar la dirección del salto en el eje Y
        michi.addForce(direccionX * 800, direccionY * 800); // Ajusta la fuerza según tu juego

        // Reinicia el tiempo anterior al tiempo actual
        tiempoAnterior = tiempoActual;
      }
    }

    if (pelota.getY() > 540 && incrementarScore) {
      score++; // Incrementar el score en 1
      incrementarScore = false; // Evitar incrementar varias veces
    }
    if (objetoCajaFuerte.getY() > 540 && incrementarScoreCajaFuerte) {
      score++; // Incrementar el score en 1
      incrementarScoreCajaFuerte = false; // Evitar incrementar varias veces
    }
    if (objeto2.getY() > 540 && incrementarScoreObjeto2) {
      score++; // Incrementar el score en 1
      incrementarScoreObjeto2 = false; // Evitar incrementar varias veces
    }
    if (objeto3.getY() > 540 && incrementarScoreObjeto3) {
      score++; // Incrementar el score en 1
      incrementarScoreObjeto3 = false; // Evitar incrementar varias veces
    }
    fill(20, 255, 60, 120);
    ellipse(mouseX, mouseY, 15, 15);


    mundo.step();
    mundo.draw();
  } else if (mostrandoCreditos) {
    // Código de la pantalla de créditos...
    background(220);
    image (fondo, 0, 0, width, height);
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(0);
    text("Créditos del juego", width/2, 100);
    textSize(24);
    text("Desarrollado por:\n Adorno Camila \n Alves Catalina \n Bogado Benuzzi Antonella \n Carugatti Martin", width/2, 230);
    text("Música por: 8bit Universe", width/2, 350);

    // Botón de volver
    rectMode(CENTER);
    fill(100);
    rect(width/2, height/2 + 170, 200, 60);
    fill(0);
    textSize(24);
    text("Volver", width/2, height/2 + 170);
    mostrarBotonVolver = true;
  }
}

void mousePressed() {
  if (pantallaDeInicio) {
    if (mouseX > 182 && mouseX < 418 && mouseY > 400 && mouseY < 460) {
      pantallaDeInicio = false;
      jugando = true;
    } else if (mouseX > 182 && mouseX < 418 && mouseY > 500 && mouseY < 560) {
      pantallaDeInicio = false;
      mostrandoCreditos = true;
    }
  } else if (mostrandoCreditos && mostrarBotonVolver) {
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && mouseY > height/2 + 140 && mouseY < height/2 + 200) {
      mostrandoCreditos = false;
      pantallaDeInicio = true;
      mostrarBotonVolver = false;
    }
  }
}
