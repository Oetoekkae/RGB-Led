#include <FastLED.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>


//Led strip pin and number of leds
#define LED_PIN 14
#define NUM_LEDS 164
//brightness, strip type, strip color order
#define BRIGHTNESS 64
#define LED_TYPE WS2811
#define COLOR_ORDER GRB
//led array
CRGB leds[NUM_LEDS];
#define UPDATES_PER_SECOND 100

//SSID and password
const char *ssid = "LED";
const char *password = "realityisalie";
bool effectOn = false;

ESP8266WebServer server(80);

//Server configuration
void setup() {
  //ledstrip init
  delay(500);
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  FastLED.setBrightness( BRIGHTNESS );
  leds[0].red = 50;
  leds[1].green = 100;
  leds[2].blue = 150;
  FastLED.show();
  delay(500);
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
  server.on("/random", randomColor);
 //Start server
  server.begin();
  Serial.println("HTTP server started");

}
void loop() {
  server.handleClient();
  FastLED.show();
  FastLED.delay(1000 / UPDATES_PER_SECOND);
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
    } else if (server.argName(i)=="G") {
      g_new = ((server.arg(i).substring(1,4)).toInt());
    } else if (server.argName(i)=="B") {
      b_new = ((server.arg(i).substring(1,4)).toInt());
    }
  }
   
  Serial.println(r_new);
  Serial.println(g_new);
  Serial.println(b_new);
  //set the led color
  CRGB color = CRGB( r_new, g_new, b_new );
  fill_solid(leds, NUM_LEDS, color);
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
  Serial.println("Random");
  effectOn = false;
  int red, green, blue;
  red = random(255);
  green = random(255);
  blue = random(255);
  fill_solid(leds, NUM_LEDS, CRGB(red, green, blue));
  server.send(200);
}
