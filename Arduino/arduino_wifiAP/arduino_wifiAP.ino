#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>

#define R 12
#define G 14
#define B 4

//SSID and password
const char *ssid = "LED";
const char *password = "realityisalie";

ESP8266WebServer server(80);

//Serve configuration
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
  checkMail(server.arg(0), server.arg(1), server.arg(2));
  int r_new=-1;
  int g_new=-1;
  int b_new=-1;

  //Extract values from POSTs request
  for (uint8_t i=0; i<server.args(); i++) {
    Serial.println(server.argName(i));
    if(server.argName(i)=="R") {
      r_new = ((server.arg(i).substring(1,4)).toInt() * 4) + 4;
    } else if (server.argName(i)=="G") {
      g_new = ((server.arg(i).substring(1,4)).toInt() * 4) + 4;
    } else if (server.argName(i)=="B") {
      b_new = ((server.arg(i).substring(1,4)).toInt() * 4) + 4;
    }
  }
  //print out extracted values
  Serial.println(r_new);
  Serial.println(g_new);
  Serial.println(b_new);
  //set the led color
  analogWrite(R, r_new);
  analogWrite(G, g_new);
  analogWrite(B, b_new);
  
}
//Print out values and send response
void checkMail(String r, String g, String b) {
  String red, green, blue;
  String received;
  red += r;
  green += g;
  blue += b;
  received += "Got these: " + red + ", " + green + ", " + blue;
  Serial.println(received);
  server.send(200, "text/plane", received);
}
