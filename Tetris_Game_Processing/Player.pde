int currPieceType = 0;
int nextPieceType = 0;
int currPieceX = mapWidth / 2;
int currPieceY = -1;
int rotationState = 0;
color currPieceColor;
color nextPieceColor;

// Dibuja la pieza que cae
void drawFallingPiece()
{
    if(initialPause) return;
    
    pushMatrix();
    translate(resX/1.7 - ((tileWidth * mapWidth) / 2), 0);
    translate(tileWidth / 1.7, tileHeight / 2);
    translate(tileWidth * currPieceX, tileHeight * currPieceY);
    
    for(int y = 0; y < 4; y++) 
    {
        
        for(int x = 0; x < 4; x++) 
        {

            if(tetrominoes[currPieceType].charAt(rotate(x, y, rotationState)) == 'X')
            {
                
                boxShape.setFill(currPieceType);
                boxShape.setStroke(color(180, 180, 180, 255));
                shape(boxShape);
            }
            
            translate(tileWidth, 0);
        }

        translate(0, tileHeight);
        translate(-(tileWidth * 4), 0);
    }
    
    popMatrix();
}

void getNewPiece()
{
    currPieceType = nextPieceType;
    rotationState = 0;
    currPieceX = mapWidth / 2 - 2;
    
    if(currPieceType == 0 || currPieceType == 5 || currPieceType == 6)
    {
        currPieceY = -5; 
    }
    else
    {
        currPieceY = -4;
    }
    
    currPieceColor = backgroundColor;
    pushDownTimer = millis();
}

void drawNextPiece() {
    if(initialPause) return;
    if(gameOver) return;
    pushMatrix();
    if (nextPieceType == 0 ) {
      translate(resX/2.37 - (tileWidth * 9), 308);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('0');
    }
    else if (nextPieceType == 1 ) {
      translate(resX/2.27 - (tileWidth * 9), 323);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('1');
    }
    else if (nextPieceType == 2 ) {
      translate(resX/2.27 - (tileWidth * 9), 323);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('2');
    }
    else if (nextPieceType == 3 ) {
      translate(resX/2.29 - (tileWidth * 9), 305);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('3');
    }
    else if (nextPieceType == 4 ) {
      translate(resX/2.3 - (tileWidth * 9), 323);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('4');
    }
    else if (nextPieceType == 5 ) {
      translate(resX/2.27 - (tileWidth * 9), 293);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('5');
    }
    else if (nextPieceType == 6 ) {
      translate(resX/2.27 - (tileWidth * 9), 293);
      translate(tileWidth/2, tileHeight/2);
      //myPort.write('6');
    }
     for(int y = 0; y < 4; y++) 
    {
        
        for(int x = 0; x < 4; x++) 
        {

            if(tetrominoes[nextPieceType].charAt(rotate(x, y, 0)) == 'X')
            {
                boxShape.setFill(nextPieceColor);
                boxShape.setStroke(color(180, 180, 180, 255));
                shape(boxShape);
            }
            
            translate(tileWidth, 0);
        }

        translate(0, tileHeight);
        translate(-(tileWidth * 4), 0);
    }
    
    popMatrix();
 }



void getNextPiece(){
     nextPieceType = int(random(0,7));
  }
