#include <FastLED.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>


//Led strip pin and number of leds
#define LED_PIN 14
#define NUM_LEDS 164
//brightness, strip type, strip color order
#define BRIGHTNESS 200
#define LED_TYPE WS2811
#define COLOR_ORDER GRB
//led array
CRGB leds[NUM_LEDS];
#define UPDATES_PER_SECOND 100

//SSID and password
const char *ssid = "LED";
const char *password = "realityisalie";
bool effectOn;
bool fireEffectOn;

ESP8266WebServer server(80);

//custom gradient palettes
//fire palette
uint8_t fireIndex[NUM_LEDS];
DEFINE_GRADIENT_PALETTE( firecrackling_gp ){
  0, 255, 0, 0,
  55, 157, 46, 5,
  102, 255, 177, 0,
  120, 255, 118, 0,
  204, 186, 1, 10,
  255, 255, 0, 0
};

CRGBPalette16 currentPalette;
TBlendType currentBlending;

//Server configuration
void setup() {
  //ledstrip init
  delay(500);
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  FastLED.setBrightness( BRIGHTNESS );
  currentBlending = LINEARBLEND;
  leds[0].red = 50;
  leds[1].green = 100;
  leds[2].blue = 150;

  //fire palette setup --array filled with random  numbers
  for(int i=0; i < NUM_LEDS; i++) {
    fireIndex[i] = random8();
  }
  
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
  server.on("/Rainbow", rainbow);
  server.on("/LOOPRGB!", loopRGB);
 //Start server
  server.begin();
  Serial.println("HTTP server started");

}
void loop() {
  server.handleClient();

  if(effectOn){
    static uint8_t startIndex = 0;
    startIndex = startIndex + 1; //move speed
    FilledFromPalette( startIndex );
  }

  //dots plopping in and fading out
  /*if(effectOn) {
    EVERY_N_MILLISECONDS(1){
      leds[random8(0, NUM_LEDS -1 )] = ColorFromPalette(currentPalette, random8(), 255, currentBlending);
    }
    fadeToBlackBy(leds, NUM_LEDS, 2);
  }*/

  if(fireEffectOn) {
    for(int i = 0; i < NUM_LEDS; i++) {
      leds[i] = ColorFromPalette(currentPalette, fireIndex[i]);
    }

    EVERY_N_MILLISECONDS(1) {
      for(int i = 0; i < NUM_LEDS; i++) {
        fireIndex[i]++;
      }
    }
  }
  
  
  FastLED.show();
  FastLED.delay(1000 / UPDATES_PER_SECOND);
}
void handleRoot() {
  server.send(200, "text/html", "<h1>You are connected</h1>");
}

void receiveColors() {
  Serial.println("You've got mail ");
  effectOn = false;
  fireEffectOn = false;
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

void randomColor(){
  Serial.println("Random");
  effectOn = false;
  fireEffectOn = false;
  int red, green, blue;
  red = random(255);
  green = random(255);
  blue = random(255);
  fill_solid(leds, NUM_LEDS, CRGB(red, green, blue));
  server.send(200);
}


//Start rainbows with rainbow palette
void rainbow() {
  Serial.print("starting rainbows");
  fireEffectOn = false;
  effectOn = true;
  currentPalette = RainbowColors_p;
  server.send(200);
}

void loopRGB() {
  Serial.print("starting fire sequence");
  effectOn = false;
  fireEffectOn = true;
  currentPalette = firecrackling_gp;
  server.send(200);
}

void FilledFromPalette(uint8_t colorIndex) {

  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = ColorFromPalette(currentPalette, colorIndex, 255, currentBlending);
    colorIndex  += 3;
  }
}


//Debug method
void checkForBool() {
  server.handleClient();
  if(effectOn == true){
   Serial.println("Bool is true");
  } else {
   Serial.println("Bool is false");
  }
 
}
