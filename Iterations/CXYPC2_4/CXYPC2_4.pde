Platform boxes[] = new Platform[272];

int counter = 0;

float zPos;

void setup() {
  size(512, 424, P3D);
  background(0);
  smooth();

  for (int i = 0; i < boxes.length; i++) {
    boxes[i] = new Platform();
  }

  for (int i = 16; i <= 512-16; i+=32) {
    for (int j = 12; j <= 424-12; j+=24) {

      counter++;

      boxes[counter-1].position(i, j);
    }
  }
}

void draw() {
  background(0);
 // lights();
//directionalLight(175, 175, 175, 0, 1, 0);
  spotLight(255, 255, 255, 480/2, 960/2, 1400, 0, 0, -1, PI/4, 2);

  for (int i = 0; i < boxes.length; i++) {
    int index = i*32;
    
    boxes[i].update(mouseX, mouseY);
    boxes[i].display();
  }
  
  if(mousePressed){
    zPos += (0 - zPos) * .1;
  }else{
    zPos += (-115 - zPos) * .1;
  }

  //println(boxes[63].getAngle());

}

class Platform {

  float x, y, z, an;

  float affect = 50;

  Platform() {

    x = 16;
    y = 12;
  }

  void position(float tx, float ty) {

    x = tx;
    y = ty;
    z = -100;

    an = 0;
  }

  void update(float ux, float uy) {

    float mdist = dist(ux, uy, x, y);

    float lift = map(mdist, 0, affect, PI, 0);
    
    float easing = map(mdist, 0, affect, .25, .01);
    
    if(easing < .01){
      easing = .01;
    }
    
    if(easing > 1){
      easing = 1;
    }

    if (mdist < affect) {
      //downwoard
      an += (lift - an) * easing;
    } else {
      //upward
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
