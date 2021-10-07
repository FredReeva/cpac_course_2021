import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i, cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
    
  }
  
}

void copy2img(Capture camera, PImage img) {
  img.loadPixels();
  for (int i=0; i<camera.width*camera.height; i++) {
    img.pixels[i]=camera.pixels[i];
  }
  img.updatePixels();
}

void changeColors(PImage img){
  img.loadPixels();
  float r, g, b;
  colorMode(RGB, 255);
  for(int loc=0; loc<img.width*img.height; loc++){
    r= red(img.pixels[loc]);
    g= green(img.pixels[loc]);
    b= blue(img.pixels[loc]);
    img.pixels[loc]=color(b,r,g);    
  }
  // your code here;
  img.updatePixels();  
}

void draw() {
  if (! cam.available()) {return;}
  cam.read();
  PImage img=createImage(cam.width,cam.height,RGB);
  copy2img(cam, img);
  changeColors(img);
  
  if(img.width>0){
    image(img, 0, 0);
  }

}
