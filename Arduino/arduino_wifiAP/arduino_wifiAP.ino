#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>

/* Set these to your desired credentials. */
const char *ssid = "[REDACTED]";
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
  
}
