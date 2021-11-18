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

ParticleSystem ps;

void setup() {

  // Rendering in P3D
  size(512, 424);
  ps = new ParticleSystem(new PVector(width/2, 50));
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
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for (int x = 0; x < kinect.WIDTHDepth; x++) {
    for (int y = 0; y < kinect.HEIGHTDepth; y++) {
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(255,0,155);
        
        sumX += x;
        sumY += y;
        totalPixels++;  //totalPixels+=1;
      }else{
        img.pixels[offset] = color(0);
      }
    }
  }
  img.updatePixels();
  image(img,0,0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150,0,255);
  ellipse(avgX,avgY,64,64);
  for (int i = 0;i<10;i++){
    ps.addParticle(avgX,avgY);
  }
  ps.run();
  
  fill(255);
  textSize(32);
  text("minThresh"+" "+minThresh , 10, 64);
  text( "maxThresh"+" "+maxThresh , 10, 120);
}
