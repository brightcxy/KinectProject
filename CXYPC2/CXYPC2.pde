import KinectPV2.*;
KinectPV2 kinect;

void setup(){
  size(512,424,P3D);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  //frameRate(10);
}

void draw(){
  background(0);
  PImage img = kinect.getDepthImage();
  //image(img,0,0);
  
  int skip = 20;
  for (int x = 0; x < img.width; x+=skip){
    for (int y = 0; y < img.height; y+=skip){
      int index = x + y * img.width;//"index" is the number of every pixel
      float b = brightness(img.pixels[index]);//"col" is the color of every pixel
      float z = map(b,0,255,250,-250);
      fill(255-b);
      pushMatrix();
      translate(x,y,z);
      rect(0,0,skip/2,skip/2);
      popMatrix();
    }
  }
}
