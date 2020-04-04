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
  server.on("/RAINBOW!", rainbow);

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
  //Check received values
  checkMail(server.arg(0), server.arg(1), server.arg(2), server.arg(3));
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
  if(server.arg(0) == "1") {
    Serial.print("Setting secondary");
    analogWrite(R2, r_new);
    analogWrite(G2, g_new);
    analogWrite(B2, b_new);
  } else {
    Serial.println("Setting primary");
    analogWrite(R, r_new);
    analogWrite(G, g_new);
    analogWrite(B, b_new);
  }
  
  
  
}

void rainbow() {
  loopAllColors();  
}
//Print out values and send response
void checkMail(String led, String r, String g, String b) {
  String red, green, blue;
  String received;
  red += r;
  green += g;
  blue += b;
  received += "Got these: " + red + ", " + green + ", " + blue + " and its " + led;
  Serial.println(received);
  server.send(200);
}

void flashColor(int led){
  analogWrite(led, 1024);
  Serial.println("1024 -> 0");
  for(int x=1024;x>2;x= x-2){
    analogWrite(led, x);
    delay(5);
    if(x<=4){
      Serial.println("0 -> 1024");
      for(int i=0;i<1024; i= i+2){
        analogWrite(led, i);
        delay(5);
      }
    }
  }
  analogWrite(led, 1024);
}

void loopAllColors() {
  Serial.print("comissing rainbows");
  flashColor(R);
  flashColor(G);
  flashColor(B);
  server.send(200);
}
