import fisica.*;
import processing.sound.*;
import processing.video.*;
import gab.opencv.*;

// Cámara
Capture camara;
int anchoCam = 240;
int altoCam = (anchoCam * 9) / 16;

float translateOffsetX = anchoCam; // Para rastrear el desplazamiento de translate
float pantallaCompletaX;
float pantallaCompletaY;

// OpenCV
OpenCV opencv;
ArrayList <Contour> contornos;
boolean invertir = false;

// SONIDO
SoundFile sonido;

Principal principal;
int score = 0;

void setup() {
  size(1280, 720);

  // INICIALIZACION CAMARA
  camara = new Capture(this, anchoCam, altoCam);
  camara.start();

  // INICIALIZACION OPENCV
  opencv = new OpenCV(this, anchoCam, altoCam);
  
  // INICIALIZACION SONIDO
  sonido = new SoundFile(this, "breakstuff.mp3");
  sonido.play();
  sonido.loop();
  // INICIALIZACION FISICA
  Fisica.init(this);
  
  principal = new Principal();
}

void draw() {
  principal.display();
   principal.cambiarDeEstado();

println(pantallaCompletaY);
  int umbral = 213;

  noFill();

  // Cámara y detección de blobs
  if (camara.available()) {
    camara.read();
    opencv.loadImage(camara);
    if (invertir) opencv.invert(); // invertir colores
    opencv.threshold(umbral); // aplicar umbral
    contornos = opencv.findContours(); 
  }

  PImage salida = opencv.getOutput();

  pushMatrix();
  translate(0, 0); // Utiliza translateOffsetX
  scale(-1, 1); // Espeja la cámara
  image(salida, 0, 0);
  stroke(0, 255, 0);

  for (Contour blob: contornos) {
    // transforma el contorno en uno más simple
    Contour contornoAproximado = blob.getPolygonApproximation();
    // obtengo los puntos del nuevo contorno
    ArrayList<PVector> puntos = contornoAproximado.getPoints();

    // Calcula las dimensiones del blob
    float minX = Float.MAX_VALUE;
    float minY = Float.MAX_VALUE;
    float maxX = Float.MIN_VALUE;
    float maxY = Float.MIN_VALUE;

    for (PVector punto : puntos) {
      if (punto.x < minX) minX = punto.x;
      if (punto.x > maxX) maxX = punto.x;
      if (punto.y < minY) minY = punto.y;
      if (punto.y > maxY) maxY = punto.y;
    }

    // Calcula el centro y dimensiones de la elipse
    float ellipseX = (minX + maxX) / 2;
    float ellipseY = (minY + maxY) / 2;
    float ellipseWidth = maxX - minX;
    float ellipseHeight = maxY - minY;

    // Dibuja la elipse por encima del blob
    ellipse(ellipseX, ellipseY, ellipseWidth, ellipseHeight);
   pantallaCompletaX = map(ellipseX - translateOffsetX, 0, anchoCam, 0, width);
    // Calcula la posición correspondiente en pantalla completa
 
    pantallaCompletaY = map(ellipseY, 0, altoCam, 0, height);
    
    fill(20, 255, 60, 120);
    ellipse(pantallaCompletaX, pantallaCompletaY, 15, 15);
  }
  popMatrix();
}
