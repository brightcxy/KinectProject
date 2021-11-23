import KinectPV2.*;
KinectPV2 kinect;

void setup(){
  size(512,424);
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();
  //frameRate(10);
}

void draw(){
  background(0);
  PImage img = kinect.getDepthImage();
  //image(img,0,0);
  
  img.loadPixels();
  int[] depth = kinect.getRawDepthData();
  
  int skip = 15;
  for (int x = 0; x < img.width; x+=skip){
    for (int y = 0; y < img.height; y+=skip){
      int index = x + y * img.width;//"index" is the number of every pixel
//      float b = brightness(img.pixels[index]);//"col" is the color of every pixel
      float d = depth[index];
      float xd = 2000-d;
      float col = map(d,0,2000,0,255);
      float line = map(xd,0,2000,0,15);
      if(d>0){
        fill(255);
        pushMatrix();
        translate(x,y);
        rect(0,0,line,line);
        //fill(0,255,0);
        //textSize(8);
        //text(int(line),0,0);
        popMatrix();
      };
    }
  }
}
