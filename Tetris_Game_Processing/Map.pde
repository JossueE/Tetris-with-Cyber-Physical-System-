int mapWidth = 12;
int mapHeight = 21;
int[] map = new int[mapWidth * mapHeight];
int tileWidth = 32;
int tileHeight = 32;

color targetBgColors = color(79, 79, 79);

color backgroundColor = targetBgColors;
color[] tileColors = new color[mapWidth * mapHeight]; // Set de Coloresr
int targetColorIndex = 0;
boolean changeTargetNextFrame = false;
boolean waitedSomeFrames = false;
int bgChangeFrameCounter = 0;


void createMap() 
{
    targetColorIndex = targetBgColors;
    
    //Crea el mapa
    for(int y = 0; y < mapHeight; y++) 
    {
        
        for(int x = 0; x < mapWidth; x++)
        {
                
            if(x == 0 || x == mapWidth - 1 || y == mapHeight - 1) 
            {
                map[y * mapWidth + x] = 1;
                continue;
            }
            
            map[y * mapWidth + x] = 0;
        }
        
    }
    
    //Establece el color
    for(int y = 0; y < mapHeight; y++) 
    {
        
        for(int x = 0; x < mapWidth; x++)
        {
            tileColors[y * mapWidth + x] = color(0, 0, 0, 255);
        }
        
    }
    
}

// Coloca la imagen vignnete para darle el efecto de inmmersión. 
void drawVignette()
{
    pushMatrix();
    translate(resX/2, resY/2);
    fillShape.setTexture(vignette);
    shape(fillShape);
    popMatrix();
}

// setea el color del fondo
void drawBackground()
{   
    background(backgroundColor);
}
    
// Dibuja las piezas no movibles
void drawForeground()
{
    pushMatrix();
    translate(resX/1.7 - ((tileWidth * mapWidth) / 2), 0);
    translate(tileWidth/1.7, tileHeight/2);
    
    for(int y = 0; y < mapHeight; y++) 
    {
        
        for(int x = 0; x < mapWidth; x++) 
        {
            
            if(map[y * mapWidth + x] == 0) 
            {
                mapFillerShape.setStroke(color(0, 0, 0, 127));
                mapFillerShape.setFill(color(180, 180, 180, 100));
                shape(mapFillerShape);
            } 
            else 
            {
                push();
                boxShape.setStroke(color(0, 0, 0, 127));
                boxShape.setStrokeWeight(4);
                
                if(map[y * mapWidth + x] == 1) 
                {
                    //boxShape.setFill(color(0, 0, 0, 255));
                    //boxShape.setFill(tileColors[y * mapWidth + x]);
                } 
                else
                {
                    boxShape.setFill(tileColors[y * mapWidth + x]);
                    //boxShape.setFill(color(0, 0, 0, 255));
                }
                
                if(blocksToRemove.size() > 0) 
                {
                    
                    for(int j = 0; j < blocksToRemove.size(); j++)
                    {
                        
                        if((y * mapWidth + x) == blocksToRemove.get(j)) 
                        {
                            color curTileColor = tileColors[y * mapWidth + x];
                            
                            // Formmula para disolver la linea
                            curTileColor = color(0,0,0); 

                            boxShape.setFill(curTileColor);
                            tileColors[y * mapWidth + x] = curTileColor;
                        }
                        
                    }
                    
                }
                // Texturas
                boxShape.setTexture(textures[map[y * mapWidth + x] - 1]);
                
                shape(boxShape);
                pop();
            }
            
            translate(tileWidth, 0);
        }
        
        translate(0, tileHeight);
        translate(-(tileWidth * mapWidth), 0);
    }
    
    popMatrix();
}

// Esto controla el cambio gradual a otro color para el fondo
// El fondo cambiará lentamente a un color objetivo específico mientras se desarrolla el juego.

void drawPauseScreen()
{
    pushMatrix();
    translate(resX/2 - ((tileWidth) / 2), resY / 2 - (tileHeight * 3), 52);
    translate(tileWidth/2, tileHeight/2);
    shape(pauseTextBgShape);
    push();
    fill(200, 0, 0);
    textSize(50);
    text("START!", 0, -10, 52);
    fill(255, 255, 255);
    textSize(15);
    text("Press the button to start", -2, 30, 52);
    pop();
    popMatrix();
}

void drawGameOverScreen()
{
    pushMatrix();
    translate(resX/2 - ((tileWidth) / 2), resY / 2 - (tileHeight * 3), 52);
    translate(tileWidth/2, tileHeight/2);
    shape(pauseTextBgShape);
    push();
    fill(200, 0, 0);
    textSize(50);
    text("GAME OVER!", 0, -10, 52);
    fill(255, 255, 255);
    textSize(15);
    text("Press the button to continue", -2, 30, 52);
    pop();
    popMatrix();
}

void drawInterface() 
{
    pushMatrix();
    
    translate(resX/2 - (tileWidth * 9), 100);
    translate(tileWidth/2, tileHeight/2);
    shape(scoreTextBgShape);
    
    push();
    text("Score", 20, -10, 51);
    textAlign(RIGHT);
    textSize(20);
    text("" + score, 80, 28, 51);
    pop();
    
    popMatrix();
    
    pushMatrix();
    
    translate(resX/2 - (tileWidth * 9), 200);
    translate(tileWidth/2, tileHeight/2);
    shape(timerTextBgShape);
    
    push();
    text("Time", 20, -17, 51);
    textSize(20);
    textAlign(RIGHT);
    text("" + secondsSinceStart, 80, 20, 51);
    pop();
    
    popMatrix();
    
    pushMatrix();
    
    translate(resX/2 - (tileWidth * 9), 355);
    translate(tileWidth/2, tileHeight/2);
    shape(pieceTextBgShape);
    
    push();
    text("Next Piece", 20, -80, 51);
    pop();
    
    popMatrix();
}
