char caracter;
char dato;

void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);
}

void loop() {
  while(Serial3.available() > 0){
    caracter = Serial3.read();
    Serial.print(caracter);
  }
  while(Serial.available() > 0){
    dato = Serial.read();
    Serial3.write(dato);
  }
}