String[] tetrominoes = new String[7];
int resX = 800;
int resY = 750;
int score = 0;
int secondsSinceStart = 0; // Segundos desde que se aplasta el botòn de start.
float secondCounter = 0;
float pushDownTimer = 0;
float pushDownDelay = 1000; // Tiempo de bajada de la pieza.
boolean gameOver = false;
boolean initialPause = true;


// Pshape objetos usados para mostrar cosas en la pantalla.
PShape boxShape;
PShape fillShape;
PShape mapFillerShape;
PShape pauseTextBgShape;
PShape scoreTextBgShape;
PShape pieceTextBgShape;
PShape timerTextBgShape;
PImage[] textures = new PImage[7];
PImage icon;
PImage spritesheet;
PImage vignette;
PFont font;

ArrayList<Integer> blocksToRemove = new ArrayList<Integer>();
float blockDissolveTimer = 0;


void settings()
{
    size(resX, resY, P3D);
    PJOGL.setIcon("icon.png"); //Establecemos un ícono
}

void setup()
{        
    // Se define la forma de las piezas
    // X es un cubito de la pieza
    tetrominoes[0] =  "--X-"; // La primera asignación debe ser "=" para reemplazar el valor nulo inicial
    tetrominoes[0] += "--X-";
    tetrominoes[0] += "--X-";
    tetrominoes[0] += "--X-";
    
    tetrominoes[1] =  "--X-";
    tetrominoes[1] += "-XX-";
    tetrominoes[1] += "-X--";
    tetrominoes[1] += "----";
    
    tetrominoes[2] =  "-X--";
    tetrominoes[2] += "-XX-";
    tetrominoes[2] += "--X-";
    tetrominoes[2] += "----";
    
    tetrominoes[3] =  "----";
    tetrominoes[3] += "-XX-";
    tetrominoes[3] += "-XX-";
    tetrominoes[3] += "----";
    
    tetrominoes[4] =  "--X-";
    tetrominoes[4] += "-XX-";
    tetrominoes[4] += "--X-";
    tetrominoes[4] += "----";
    
    tetrominoes[5] =  "----";
    tetrominoes[5] += "-XX-";
    tetrominoes[5] += "--X-";
    tetrominoes[5] += "--X-";
    
    tetrominoes[6] =  "----";
    tetrominoes[6] += "-XX-";
    tetrominoes[6] += "-X--";
    tetrominoes[6] += "-X--";

    frameRate(60);
    ((PGraphicsOpenGL)g).textureSampling(3);

    
    shapeMode(CORNER);
    boxShape = createShape(BOX, 32, 32, 1);
    fillShape = createShape(BOX, resX, resY, 1);
    mapFillerShape = createShape(BOX, 32, 32, 1);
    pauseTextBgShape = createShape(BOX, 800, 900, 1);
    scoreTextBgShape = createShape(BOX, 150, 40, 1);
    timerTextBgShape = createShape(BOX, 150, 40, 1);
    pieceTextBgShape = createShape(BOX, 150, 150, 1);
 
    
    boxShape.setSpecular(color(0, 0, 0));
    boxShape.setAmbient(color(255, 255, 255));
    boxShape.setShininess(0);
    boxShape.setEmissive(0);
    
    pauseTextBgShape.setFill(color(0, 0, 0,127));
    pauseTextBgShape.setSpecular(color(0, 0, 0));
    pauseTextBgShape.setAmbient(color(0, 0, 0));
    pauseTextBgShape.setStroke(color(0, 0, 0));
    
    scoreTextBgShape.setFill(color(0, 0, 0));
    scoreTextBgShape.setSpecular(color(0, 0, 0));
    scoreTextBgShape.setAmbient(color(0, 0, 0));
    scoreTextBgShape.setStroke(color(255, 255, 255));
    
    timerTextBgShape.setFill(color(0, 0, 0));
    timerTextBgShape.setSpecular(color(0, 0, 0));
    timerTextBgShape.setAmbient(color(0, 0, 0));
    timerTextBgShape.setStroke(color(255, 255, 255));
    
    pieceTextBgShape.setFill(color(0, 0, 0));
    pieceTextBgShape.setSpecular(color(0, 0, 0));
    pieceTextBgShape.setAmbient(color(0, 0, 0));
    pieceTextBgShape.setStroke(color(255, 255, 255));
    
    font = loadFont("Digital-7Mono-18.vlw");
    textFont(font);
    textAlign(CENTER, CENTER);
   
    spritesheet = loadImage("spritesheet.png");
    vignette = loadImage("vignette.png"); 
    
    for(int i = 0; i < 6; i++)
    {
        textures[i] = spritesheet.get(32 * i, 0, 32, 32);
    }
    
    textureMode(REPEAT);
    sphereDetail(15);
    
    createMap();
    getNewPiece();
    getNextPiece();
    
    myPort = new Serial(this, "COM5", 9600);

}

void draw() 
{        
    update();
    
    drawBackground();
    
    drawVignette();
    
    drawForeground();
    
    drawFallingPiece();
    
    drawNextPiece();
    
    drawInterface();
    
    if(initialPause)
    {
      drawPauseScreen();
    }
    
    if(gameOver)
    {
      drawGameOverScreen();
    }   
}

// 
void update()
{
    //println(frameRate);
    
    if(!gameOver) 
    {
      
        if(!initialPause) 
        {
        
            if(millis() - secondCounter >= 1000)
            {
                secondsSinceStart++;
                secondCounter = millis();
                myPort.write(nextPieceType);
            }
            

            if(blocksToRemove.size() > 0) 
            {
                dissolveBlocks();
                pushDownTimer = millis();
                return; // 
            }
            
            checkInputs();
            
            // Si la pieza no baja automáticamente, se baja con un delay del push down delay
            if(millis() - pushDownTimer > pushDownDelay) 
            {
                
                if(checkIfPieceFits(currPieceX, currPieceY + 1, rotationState))
                {
                    currPieceY++;
                }
                else
                {
                    lockCurrPieceToMap(); 
                }
                pushDownTimer = millis();
            }   
        }
    }
    else
    {
      myPort.write('F');
    }
}

// Checa que la fila esté completa
void checkForRows() 
{
    
    for(int y = 0; y < mapHeight - 1; y++)
    {
        int piecesInRow = 0;
        
        for(int x = 1; x < mapWidth - 1; x++)
        {
            
            if(map[y * mapWidth + x] != 0) piecesInRow++;
            
        }
        
        if(piecesInRow == 10) 
        {
            score += 100;
            
            for(int i = 1; i < mapWidth - 1; i++) 
            {
                blocksToRemove.add(y * mapWidth + i);
                blockDissolveTimer = millis();
            }
            
        }
        
    }

}


void dissolveBlocks() 
{
    int dissolveTime = 200; //Se considera el tiempo que toma remover la pieza para que sea justo para el jugador
    
    if(millis() - blockDissolveTimer > dissolveTime) 
    {
        int startHeight = (blocksToRemove.get(blocksToRemove.size() - 1) + 1) / mapWidth;  //se calcula la fila más baja del bloque a ser eliminado

        ArrayList<Integer> rowsToRemoveHeights = new ArrayList<Integer>(); //se guardan las alturas de las filas que se encuentran encima
        
        for(int i = 0; i < blocksToRemove.size() / 10; i++) 
        {
            rowsToRemoveHeights.add((blocksToRemove.get(10 * i) + 1) / mapWidth); //Aquí se calculan las alturas, cada 10 bloques se elimina una fila.
        }
        
        int numRowsToDisplace = 0; //Contador de filas a reemplazar
        
        for(int y = startHeight; y >= 0; y--)
        {
            boolean doDisplace = true; //Verifica si esta tiene que ser eliminada.
            
            for(int j = 0; j < rowsToRemoveHeights.size(); j++) 
            {

                if(y == rowsToRemoveHeights.get(j)) 
                {
                    numRowsToDisplace++;
                    doDisplace = false; //No necesita ser movida, porque será eliminada. 
                }
                
            }
            
            for(int x = 1; x < mapWidth - 1; x++)
            {
                
                if(doDisplace) 
                { 
                    map[(y + numRowsToDisplace) * mapWidth + x] = map[y * mapWidth + x]; //desplaza las filas y restablece el espacio de las celdas diciendo que se encuantran vacías.
                    tileColors[(y + numRowsToDisplace) * mapWidth + x] = tileColors[y * mapWidth + x];
                }
                
                map[y * mapWidth + x] = 0;
                tileColors[y * mapWidth + x] = color(0, 0, 0, 255);
            }
            
        }
        
        blocksToRemove.clear();
    }
    
}

// Bloquea la pieza actual como parte del mapa y verifica la condición de fin del juego
void lockCurrPieceToMap() 
{

    int blocksThatFit = 0;
    
    for(int y = 0; y < 4; y++) 
    {
    
        for(int x = 0; x < 4; x++) 
        {
            int pieceIndex = rotate(x, y, rotationState);
            
            if(tetrominoes[currPieceType].charAt(pieceIndex) == 'X') 
            {
                int mapIndex = (currPieceY + y) * mapWidth + (currPieceX + x);
                
                if(mapIndex >= 0) 
                {
                    map[mapIndex] = currPieceType + 1; //actualiza el valor en el mapa
                    tileColors[mapIndex] = currPieceColor;
                    blocksThatFit++;
                }
                
            }
    
        }
    
    }
    
    if(blocksThatFit != 4)
    {
        gameOver = true;
    }
    
    if(!gameOver) 
    {
        checkForRows();
        updateGameSpeed();
        getNewPiece();
        getNextPiece();
    }
    
}

// checa si la pieza cabe
boolean checkIfPieceFits(int movingToX, int movingToY, int rotation) 
{
    for(int y = 0; y < 4; y++) 
    {

        for(int x = 0; x < 4; x++) 
        {
            int pieceIndex = rotate(x, y, rotation);
            
            int mapIndex = (movingToY + y) * mapWidth + (movingToX + x);       
                  
            if(movingToX + x <= 0 || movingToX + x >= mapWidth - 1) 
            {  
                
                if(tetrominoes[currPieceType].charAt(pieceIndex) == 'X')
                {
                    return false;
                }
                
            }
               
            if(movingToX + x >= 0 && movingToX + x < mapWidth) 
            {
                
                if(movingToY + y >= 0 && movingToY + y < mapHeight) 
                {
    
                    if(tetrominoes[currPieceType].charAt(pieceIndex) == 'X' && map[mapIndex] != 0) 
                    {
                        return false;
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return true;
}


void placePieceDownInstantly() 
{
    int lastFitY = 0;
    
    for(int y = 0; y < mapHeight + 2; y++) 
    {
        
        if(checkIfPieceFits(currPieceX, currPieceY + y, rotationState))
        {
            lastFitY = currPieceY + y;
        }
        else
        {
            currPieceY = lastFitY;
            lockCurrPieceToMap();
            break;
        }
        
    }
    
}


void updateGameSpeed()
{
    
    if(secondsSinceStart >= 248) 
    {
        pushDownDelay = 300;
    }
    else if(secondsSinceStart >= 180)
    {
        pushDownDelay = 500;
    }
    else if(secondsSinceStart >= 120)
    {
        pushDownDelay = 700;
    }
    else if(secondsSinceStart >= 60) 
    {
        pushDownDelay = 800;
    }
    
}

// Algoritmo de  Javidx9 - https://www.youtube.com/watch?v=8OK8_tHeCIA
int rotate(int rx, int ry, int rState) 
{
    
    switch(rState)
    {
        case 0:
            return ry * 4 + rx;
        case 1:
            return 12 + ry - (rx * 4);
        case 2:
            return 15 - (ry * 4) - rx;
        case 3:
            return 3 - ry + (rx * 4);
    }
    
    return 0;
}

void resetGameState() 
{
    createMap();
    getNewPiece();
    getNextPiece();
    gameOver = false;
    initialPause = true;
    secondsSinceStart = 0;
    secondCounter = millis();
    pushDownDelay = 1000;
    score = 0;
}
