class Principal {
  Juego juego;
  Pantalla pantalla;
  
  int btnAncho = 237;
  int btnAlto = 60;
 
  int estado = 0;
  

  Principal() {
    juego = new Juego();
    pantalla = new Pantalla();
    println(pantallaCompletaX);
  }
  
  void display() {
    if (estado == 0) {
      pantalla.displayInicio();
      restart();

    } else if (estado == 1) {
      juego.jugar();
       juego.actualizarCuentaRegresiva();
       
      
 if (juego.cuentaRegresiva == 0) {
      estado = 3;  // Cambia al estado de fin si la cuenta regresiva llega a cero
     
      
    }
    } else if (estado == 2) {
      pantalla.displayCreditos();
    } else if (estado == 3) {
      pantalla.displayGanar();
    } else if (estado == 4) {
      pantalla.displayPerder();
    }
  }
  void restart(){
  score=0;
        juego.gato.setPosition(250,0);
        juego.gato.setForce(0,0);
        juego.gato.setVelocity(0,0);
         juego.cajaFuerte.setPosition(width / 2, height * 2 / 4 - 33);
         juego.marco.setPosition(width*3/4, height * 1 / 4 - 20);
         juego.peluche.setPosition( width / 2, height * 3 / 4 - 34);
         juego.pelota.setPosition(width / 4, height * 1 / 4);
          juego.cajaFuerte.setForce(0,0);
          juego.cajaFuerte.setVelocity(0,0);
            juego.cajaFuerte.setRotation(0);
        juego.pelota.setForce(0,0);
         juego.pelota.setVelocity(0,0);
           juego.pelota.setRotation(0);
        
          juego.peluche.setForce(0,0);
          juego.peluche.setVelocity(0,0);
            juego.peluche.setRotation(0);
          juego.marco.setForce(0,0);
          juego.marco.setVelocity(0,0);
          juego.marco.setRotation(0);
  }
  void cambiarDeEstado() {
    if (estado == 0) {
      // Si estamos en la pantalla de inicio
     
           if (pantallaCompletaX > -740 && pantallaCompletaX < -500 && pantallaCompletaY > 500 && pantallaCompletaY < 560) {
        estado = 1; // Cambiar al estado de juego
         juego.iniciarCuentaRegresiva();
      } else if (pantallaCompletaX > -700 && pantallaCompletaX < -500  && pantallaCompletaY > 600 && pantallaCompletaY < 700) {
        estado = 2; // Cambiar al estado de créditos
      } 
    } else if (estado == 2) {
      // Si estamos en la pantalla de créditos
      if (pantallaCompletaX > -740 && pantallaCompletaX <-500 && pantallaCompletaY >500 && pantallaCompletaY < 560) {
        estado = 0; // Volver al estado de inicio
      }
    }
    else if (estado == 3) {
    
     if (pantallaCompletaX <= -(width*3/4 - 100) && pantallaCompletaX >= -(width*3/4 + 100) &&
      pantallaCompletaY >= height/2 + 110 && pantallaCompletaY <= height/2 + 230) {
        estado = 0;
  }
    }

  }
}
