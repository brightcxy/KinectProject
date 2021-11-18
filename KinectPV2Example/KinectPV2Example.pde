import KinectPV2.*;
KinectPV2 kinect;

void setup() {
  size(512, 424);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
}

void draw() {
  PImage imgD = kinect.getDepthImage();
  image(imgD, 0, 0);
}
