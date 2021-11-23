/*
Thomas Sanchez Lengeling.
http://codigogenerativo.com/

KinectPV2, Kinect for Windows v2 library for processing

Point Cloud example in a 2d Image, with threshold example
*/
import java.nio.*;
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

// Angle for rotation
float a = 3.1;

//change render mode between openGL and CPU
int renderMode = 1;

//openGL object and shader
PGL     pgl;
PShader sh;

//VBO buffer location in the GPU
int vertexVboId;

//Distance Threashold
int maxD = 4000; // 4m
int minD = 0;  //  0m

void setup() {

  // Rendering in P3D
  size(1280, 720, P3D);

  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);

  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);

  kinect.init();


  //load shaders
  sh = loadShader("frag.glsl", "vert.glsl");

  PGL pgl = beginPGL();

  IntBuffer intBuffer = IntBuffer.allocate(1);
  pgl.genBuffers(1, intBuffer);

  //memory location of the VBO
  vertexVboId = intBuffer.get(0);

  endPGL();

  smooth(16);
}


void draw() {
  background(0);

  // Translate and rotate
  pushMatrix();
  translate(width/2, height/2, 50);
  rotateY(a);

  if (renderMode == 1) {

    // We're just going to calculate and draw every 2nd pixel
    int skip = 2;

    // Get the raw depth as array of integers
    int[] depth = kinect.getRawDepthData();

    stroke(255);
    beginShape(POINTS);
    for (int x = 0; x < kinect.WIDTHDepth; x+=skip) {
      for (int y = 0; y < kinect.HEIGHTDepth; y+=skip) {
        int offset = x + y * kinect.WIDTHDepth;

        //calculte the x, y, z camera position based on the depth information
        PVector point = depthToPointCloudPos(x, y, depth[offset]);

        // Draw a point
        vertex(point.x, point.y, point.z);
      }
    }
    endShape();
  } 
  
  popMatrix();

  fill(255, 0, 0);
  text(frameRate, 50, 50);

  // Rotate
  //a += 0.0015f;
}



//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}
