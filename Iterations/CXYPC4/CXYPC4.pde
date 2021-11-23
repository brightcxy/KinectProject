// Daniel Shiffman //<>//
// Thomas Sanchez Lengeling
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import java.nio.*;
import KinectPV2.*;

// Kinect Library object
KinectPV2 kinect;
float minThresh = 200;
float maxThresh = 1000;
PImage img;

void setup() {

  // Rendering in P3D
  size(512, 424);

  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  kinect.init();
  img = createImage(kinect.WIDTHDepth,kinect.HEIGHTDepth,RGB);
}


void draw() {
  background(0);
  
  img.loadPixels();
  
  minThresh = map(mouseX,0,width,0,4500);
  maxThresh = map(mouseY,0,height,0,4500);
  println(minThresh,maxThresh);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepthData();
  
  for (int x = 0; x < kinect.WIDTHDepth; x++) {
    for (int y = 0; y < kinect.HEIGHTDepth; y++) {
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(255,0,155);
      }else{
        img.pixels[offset] = color(0);
      }
    }
  }
  img.updatePixels();
  image(img,0,0);
  
  fill(255);
  textSize(32);
  text(minThresh + "" + maxThresh , 10, 64);
}
