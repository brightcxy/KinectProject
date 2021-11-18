import KinectPV2.*;
KinectPV2 kinect;

Platform boxes[] = new Platform[20000];

float zPos;
int counter = 0;
float minthreshold = 0;
float maxthreshold = 2500;
float adx = -40;
float ady = 10;
float sizex = 512*8;
float sizey = 424*6;



void setup(){
  //size(sizex, sizey, P3D);
  fullScreen(P3D);
  background(0);
  smooth();
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  
  //array of boxes
  for (int i = 0; i < boxes.length; i++) {
  boxes[i] = new Platform();
  }
  
  //define every box's position
  for (int i = 16; i <= sizex-16; i+=32) {
    for (int j = 12; j <= sizey-12; j+=24) {
      counter++;
      boxes[counter-1].position(i, j);
    }
  }
  
  //frameRate(10);
  
  
}

void draw(){
  background(0);
  spotLight(255, 255, 255, width/2, height/2, 2400, 0, 0, -1, PI/4, 2);
  PImage img = kinect.getDepthImage();
  int [] rawData = kinect.getRawDepthData();
  img.loadPixels();
  
  ////test
  //minthreshold = mouseX;
  //maxthreshold = mouseY;
    
  //fill(255);
  //textSize(32);
  //text("minThresh"+" "+minthreshold , 10, 64);
  //text( "maxThresh"+" "+maxthreshold , 10, 120);
    
    
  
  //for (int i = 0; i < boxes.length; i++) {
  //  boxes[i].update(mouseX, mouseY);
  //  boxes[i].display();
  //}
  
  for (int i = 0; i < boxes.length; i++) {
    float pos = rawData[int(boxes[i].index)];
    

    
    if(pos > minthreshold && pos < maxthreshold){
      pos = 0;
    }else{
      pos = 4500;
    };
    
    
    boxes[i].update(pos);
    boxes[i].display();
  }
    zPos += (-115 - zPos) * .1;
  
  //for(int x = 0; x < img.width; x+=skip){
  //  for(int y = 0; y < img.height; y += skip){
  //    int index = x + y * img.width;
  //    float d = brightness(img.pixels[index]);
  //    fill(d);
  //    rect(x,y,skip,skip);
  //  }
  //}
}

class Platform {

  float x, y, z, an;
  
  float index = 16;

  float affect = 75;

  Platform() {
    x = 32;
    y = 12;
  }

  void position(float tx, float ty) {

    x = tx;
    y = ty;
    z = -100;
    index = int(map(x,0,sizex,0,512)) + int(512*(map(y,0,sizey,0,424)-1));
    an = 0;
  }
  


  void update(float uz) {

    float mdist = uz;

    float lift = map(mdist, 0, affect, PI, 0);
    
    float easing = map(mdist, 0, affect, .25, .01);
    
    if(easing < .1){//was.01
      easing = .1;//was.01
    }
    
    if(easing > 2){//was1
      easing = 2;//was1
    }

    if (mdist < affect) {
      an += (lift - an) * easing;
    } else {
      an += (0 - an) * easing;
    }
    
    if(mousePressed){
      an += (0 - an) * .1;
    }


    z = -100 + ((50 * cos(an))*map(zPos,0,-115,0,1));
  }

  void display() {
    noStroke();
    fill(map(an,0,PI,200,50), map(an,0,PI,255,100), map(an,0,PI,300,100));
    pushMatrix();
    translate(x+adx, y+ady, z); 
    box(22);
    popMatrix();
  }

  float getAngle() {
    return(an);
  }
}
