import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

final int MAX_CIRCLE_CNT = 2500, MIN_CIRCLE_CNT = 100, 
  MAX_VERTEX_CNT = 30, MIN_VERTEX_CNT = 3;


int circleCnt, vertexCnt;
void setup() {
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  background(0);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  for (int i = 0; i < skeletonArray.size(); i++) {                    //no matter how many people there are, draw each of them
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {                                       //if people exist
      KJoint[] joints = skeleton.getJoints();                         //create an KJoint array called "joints"

      color col  = skeleton.getIndexColor();                          //define the color by default
      fill(col);
      stroke(col);
      drawBody(joints);                                               //call drawBody function using the array "joints"
    }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  
  translate(width / 2, height / 2);

  updateCntByHand();                                                  //this function updates returns theupdated "xoffset" "yoffset" "circleCnt" and "vertexCnt" according to the right hand position


  for (int ci = 0; ci < circleCnt; ci++) {                            //draw the shapes
    float time = float(frameCount) / 20;
    float thetaC = map(ci, 0, circleCnt, 0, TAU);
    float scale = 300;


    PVector circleCenter = getCenterByTheta(thetaC, time, scale);
    float circleSize = getSizeByTheta(thetaC, time, scale);
    color c = getColorByTheta(thetaC, time);


    stroke(c);
    noFill();
    beginShape();
    for (int vi = 0; vi < vertexCnt; vi++) {
      float thetaV = map(vi, 0, vertexCnt, 0, TAU);
      float x = circleCenter.x + cos(thetaV) * circleSize;
      float y = circleCenter.y + sin(thetaV) * circleSize;
      vertex(x, y);
    }
    endShape(CLOSE);
  }
  }
}

void updateCntByHand() {
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  KSkeleton skeleton = (KSkeleton) skeletonArray.get(0);
  KJoint[] joints = skeleton.getJoints();
  float xoffset = abs(joints[KinectPV2.JointType_HandRight].getX() - width / 2), yoffset = abs(joints[KinectPV2.JointType_HandRight].getY() - height / 2);
  circleCnt = int(map(xoffset, 0, width / 2, MAX_CIRCLE_CNT, MIN_CIRCLE_CNT));
  vertexCnt = int(map(yoffset, 0, height / 2, MAX_VERTEX_CNT, MIN_VERTEX_CNT));
}

PVector getCenterByTheta(float theta, float time, float scale) {
  PVector direction = new PVector(cos(theta), sin(theta));
  float distance = 0.6 + 0.2 * cos(theta * 6.0 + cos(theta * 8.0 + time));
  PVector circleCenter =PVector.mult(direction, distance * scale);
  return circleCenter;
}

float getSizeByTheta(float theta, float time, float scale) {
  float offset = 0.2 + 0.12 * cos(theta * 9.0 - time * 2.0);
  float circleSize = scale * offset;
  return circleSize;
}

color getColorByTheta(float theta, float time) {
  float th = 8.0 * theta + time * 2.0;
  float r = 0.6 + 0.4 * cos(th), 
    g = 0.6 + 0.4 * cos(th - PI / 3), 
    b = 0.6 + 0.4 * cos(th - PI * 2.0 / 3.0), 
    alpha = map(circleCnt, MIN_CIRCLE_CNT, MAX_CIRCLE_CNT, 150, 30);
  return color(r * 255, g * 255, b * 255, alpha);
}

void drawBody(KJoint[] joints) {

  // Right Arm

  drawBone(joints, KinectPV2.JointType_HandRight);



}

void drawBone(KJoint[] joints, int jointType1) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  println(joints[jointType1],joints[jointType1].getX() );
  ellipse(0, 0, 25, 25);
  popMatrix();
}
