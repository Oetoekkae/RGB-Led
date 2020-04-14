#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>

//led1
#define R 2
#define G 13
#define B 12
//led2
#define R2 5
#define G2 14
#define B2 16
//SSID and password
const char *ssid = "LED";
const char *password = "realityisalie";
bool effectOn = false;

ESP8266WebServer server(80);

//Server configuration
void setup() {
  delay(1000);
  Serial.begin(115200);
  Serial.println();
  Serial.print("Configuring access point...");
  WiFi.softAP(ssid, password);
  //Show address
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
 //Init routes
  server.on("/", handleRoot);
  server.on("/colors", receiveColors);
  server.on("/LOOPRGB!", loopRGB);
  server.on("/Rainbow", rainbow);
  server.on("/random", randomColor);
 //Start server
  server.begin();
  Serial.println("HTTP server started");
}
void loop() {
  server.handleClient();
}
void handleRoot() {
  server.send(200, "text/html", "<h1>You are connected</h1>");
}

void receiveColors() {
  Serial.println("You've got mail ");
  effectOn = false;
  //Check received values
  checkMail(server.arg(0), server.arg(1), server.arg(2), server.arg(3), server.arg(4));
  int r_new=-1;
  int g_new=-1;
  int b_new=-1;

  //Extract values from request
  for (uint8_t i=0; i<server.args(); i++) {
    //Serial.println(server.argName(i));
    if(server.argName(i)=="R") {
      r_new = ((server.arg(i).substring(1,4)).toInt());
      r_new = ((255 - r_new) * 4) + 4;
    } else if (server.argName(i)=="G") {
      g_new = ((server.arg(i).substring(1,4)).toInt());
      g_new = ((255 - g_new) * 4) + 4;
    } else if (server.argName(i)=="B") {
      b_new = ((server.arg(i).substring(1,4)).toInt());
      b_new = ((255 - b_new) * 4) + 4;
    }
  }
  //print out extracted values
  Serial.println(r_new);
  Serial.println(g_new);
  Serial.println(b_new);
  //set the led color
  if(server.arg(0) == "1" && server.arg(1) == "1") {
    Serial.print("Setting secondary");
    setColorTo(0, r_new, g_new, b_new);
  } else if(server.arg(0) == "0" && server.arg(1) == "1"){
    Serial.println("Setting primary");
    setColorTo(1, r_new, g_new, b_new);
  } else {
    setColorTo(1, r_new, g_new, b_new);
    setColorTo(0, r_new, g_new, b_new);
  }
}



//Print out values and send response
void checkMail(String led, String secondary, String r, String g, String b) {
  String red, green, blue;
  String received;
  red += r;
  green += g;
  blue += b;
  received += "Got these: " + red + ", " + green + ", " + blue + " and its " + led + ", is secondary? " + secondary;
  Serial.println(received);
  server.send(200);
}

void checkForBool() {
  server.handleClient();
  if(effectOn == true){
   Serial.println("Bool is true");
  } else {
   Serial.println("Bool is false");
  }
 
}

void randomColor(){
  int red, green, blue;
  red = random(1024);
  green = random(1024);
  blue = random(1024);
  setColorTo(1, red, green, blue);
  setColorTo(0, red, green, blue);
  server.send(200);
}


void loopRGB() {
  effectOn = true;
  server.send(200);
  setColorTo(0, 1024, 1024, 1024);
  setColorTo(1, 1024, 1024, 1024);
  while(effectOn){
    flashColor(R, R2);
    flashColor(G, G2);
    flashColor(B, B2);
  }
}


void rainbow() {
 Serial.print("comissing rainbows");
 float speed = 50;
 effectOn = true;
 server.send(200);
 while(effectOn){
   setColorTo(1, 4, 1024, 1024);//RED
   setColorTo(0, 72, 504, 75);//Violet
   server.handleClient();
   delay(speed);
   setColorTo(1, 4, 364, 1024);//Orange
   setColorTo(0, 4, 1024, 1024);//RED
   server.handleClient();
   delay(speed);
   setColorTo(1, 4, 4, 1024);//Yellow
   setColorTo(0, 4, 364, 1024);//Orange
   server.handleClient();
   delay(speed);
   setColorTo(1, 1024, 4, 1024);//Green
   setColorTo(0, 4, 4, 1024);//Yellow
   server.handleClient();
   delay(speed);
   setColorTo(1, 1024, 1024, 4);//Blue
   setColorTo(0, 1024, 4, 1024);//Green
   server.handleClient();
   delay(speed);
   setColorTo(1, 724, 1024, 504);//Indigo
   setColorTo(0, 1024, 1024, 4);//Blue
   server.handleClient();
   delay(speed);
   setColorTo(1, 72, 504, 75);//Violet
   setColorTo(0, 724, 1024, 504);//Indigo
   server.handleClient();
   delay(speed);
 }
}

void setColorTo(int led, int redPin, int greenPin, int bluePin){
    if(led == 0){
     analogWrite(R, redPin);
     analogWrite(G, greenPin);
     analogWrite(B, bluePin);
    }else{
     analogWrite(R2, redPin);
     analogWrite(G2, greenPin);
     analogWrite(B2, bluePin);
    }
    
}

void flashColor(int led, int led2){
    analogWrite(led, 1024);
    analogWrite(led2, 1024);
    Serial.println("1024 -> 0");
      for(int x=1024;x>2;x= x-2){
        if(effectOn){
          server.handleClient();
          analogWrite(led, x);
          analogWrite(led2, x);
          delay(5);
        }
        if(x<=4){
          Serial.println("0 -> 1024");
          for(int i=0;i<1024; i= i+2){
            if(effectOn){
              server.handleClient();
              analogWrite(led, i);
              analogWrite(led2, i);
              delay(5);
            }
          }
        }
      }
    analogWrite(led, 1024);
    analogWrite(led2, 1024);
}
