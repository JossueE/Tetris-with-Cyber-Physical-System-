import processing.serial.*;
Serial myPort;
boolean w = false, a = false, s = false, d = false, esc = false, space = false;
float downHoldDelay = 70; // ms entre cada tic de movimiento hacia abajo mientras se mantiene presionada la tecla
float downPressTime = 0;
float strafeHoldDelay = 190;
float strafePressTime = -1;
int dx = 0, dy = 0; //Delta x, delta y
int dr = 0; // Delta rotate
char instruuccion;

void checkInputs() 
{
    
    // Checa si el boton de clavado suave sigue presionado
    if(millis() - downPressTime > downHoldDelay)
    {
        if(s)
        {
            dy = 1;
        }

        downPressTime = millis();
    }
    
    // Si el potenciometro sigue girado, la pieza sigue moviendose
    if(millis() - strafePressTime > strafeHoldDelay) 
    {
    
        if(a)
        {
            dx = -1;
        }
        
        if(d)
        {
            dx = 1;
        } 
        
        strafePressTime = millis();
    }
    
    // Checa si la pieza debe ser rotada
    // Y como debe comportarse la rotacion dependiendo del tipo de pieza
    if(dr != 0) 
    {
        
        int rotateTest = rotationState;
        int maxRotate = 3; // checa los estados de rotación que puede tener la pieza
        
        switch(currPieceType) 
        {
            case 0:
                maxRotate = 1;
                break;
            case 1:
                maxRotate = 1;
                break;
            case 2:
                maxRotate = 1;
                break;
            case 3:
                maxRotate = 1;
                break;
            case 4:
                maxRotate = 3;
                break;
            case 5:
                maxRotate = 3;
                break;
            case 6:
                maxRotate = 3;
                break;
        }
        
        if(rotateTest + dr == -1)
        {
            rotateTest = 3;
        }
        else if(rotateTest + dr > maxRotate)
        {
            rotateTest = 0;
        }
        else
        {
            rotateTest += dr;
        }
        
        if(checkIfPieceFits(currPieceX, currPieceY, rotateTest)) 
        {
            rotationState = rotateTest;
        }
        else if(checkIfPieceFits(currPieceX + 1, currPieceY, rotateTest))
        {
            rotationState = rotateTest;
            dx = 1;
        }
        else if(checkIfPieceFits(currPieceX - 1, currPieceY, rotateTest))
        {
            rotationState = rotateTest;
            dx = -1;
        }
        else if(checkIfPieceFits(currPieceX + 2, currPieceY, rotateTest))
        {
            rotationState = rotateTest;
            dx = 2;
        }
        else if(checkIfPieceFits(currPieceX - 2, currPieceY, rotateTest))
        {
            rotationState = rotateTest;
            dx = -2;
        }
        
    }
    
    // Revisa si se está intentando mover horizontalmente
    if(dx != 0) 
    {
 
        if(checkIfPieceFits(currPieceX + dx, currPieceY, rotationState)) 
        {
            currPieceX += dx;
        }
        
    }
    
    // Revisa si se está intentando mover verticalmente
    if(dy != 0)
    {
        
        if(checkIfPieceFits(currPieceX, currPieceY + dy, rotationState))
        {
            currPieceY += dy;
            pushDownTimer = millis();
        }
        else
        {
            lockCurrPieceToMap();
        }
        
    }
    
    dx = 0;
    dy = 0;
    dr = 0;
}

void serialEvent(Serial port) {
  while (port.available() > 0) { // Revisa si hay datos en el serial
    // Lee el serial recibido
    char val = port.readChar();    
    processSerialInput(val); // Remueve cualquier espacio en blanco
  }
}

void processSerialInput(char input) {
 // Procesa los valores seriales recibidos
 // Puedes adaptar este método para manejar tus entradas seriales
 // Por ahora, imprimimos el valor recibido
  switch (input) {
    case 'a':
      a = true;
      strafePressTime = millis();
      break;
    case 's':
      s = true;
      downPressTime = millis();
      break;
    case 'd':
      d = true;
      strafePressTime = millis();
      break;
    case ' ':
      if (initialPause) {
        initialPause = false;
        secondCounter = millis();
      } else if (gameOver) {
        resetGameState();
      } else {
        placePieceDownInstantly();
      }
      break;
    case 'I': // Izquierda
      dr = -1;
      break;
    case 'D': // Derecha
      dr = 1;
      break;
    default :
      a = false;
      s = false;
      d = false;
  }
}
