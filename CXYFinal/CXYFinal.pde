import KinectPV2.*;
KinectPV2 kinect;

Platform boxes[] = new Platform[2700];

float zPos;
int counter = 0;

void setup(){
  size(2048, 848, P3D);
  fullScreen();
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
  for (int i = 16; i <= 2048-16; i+=32) {
    for (int j = 12; j <= 848-12; j+=24) {
      counter++;
      boxes[counter-1].position(i, j);
    }
  }
  
  //frameRate(10);
  
  
}

void draw(){
  background(0);
  spotLight(255, 255, 255, 480/2, 960/2, 1400, 0, 0, -1, PI/4, 2);
  PImage img = kinect.getDepthImage();
  int [] rawData = kinect.getRawDepthData();
  img.loadPixels();
  
  //for (int i = 0; i < boxes.length; i++) {
  //  boxes[i].update(mouseX, mouseY);
  //  boxes[i].display();
  //}

  
  for (int i = 0; i < boxes.length; i++) {
    float pos = rawData[int(boxes[i].index)];
    
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
    index = int(map(x,0,2048,0,512)) + int(512*(map(y,0,848,0,424)-1));
    an = 0;
  }
  


  void update(float uz) {

    float mdist = uz;

    float lift = map(mdist, 0, affect, PI, 0);
    
    float easing = map(mdist, 0, affect, .25, .01);
    
    if(easing < .01){
      easing = .01;
    }
    
    if(easing > 1){
      easing = 1;
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
    fill(0, map(an,0,PI,255,100), 0);
    pushMatrix();
    translate(x, y, z); 
    box(22);
    popMatrix();
  }

  float getAngle() {
    return(an);
  }
}
