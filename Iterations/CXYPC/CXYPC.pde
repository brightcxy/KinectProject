import KinectPV2.*;
KinectPV2 kinect;

void setup(){
  size(512,424);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  frameRate(10);
}

void draw(){
  background(0);

  PImage img = kinect.getDepthImage();
  img.loadPixels();
  int skip = 10;
  for(int x = 0; x < img.width; x+=skip){
    for(int y = 0; y < img.height; y += skip){
      int index = x + y * img.width;
      float d = brightness(img.pixels[index]);
      fill(d);
      rect(x,y,skip,skip);
    }
  }
}
