String filename = "../ImageToSort2.jpg";

int count = 0;

PImage photo;
float hues[][];
float saturations[][];
float brightnesses[][];

/*
  To define the size to a variable, the "settings" function is obligatory
*/
void settings(){
  photo = loadImage(filename);
  size(photo.width, photo.height);
}

void setup(){
  frameRate(15);
  colorMode(HSB);
  
  hues = new float[width][height];
  saturations = new float[width][height];
  brightnesses = new float[width][height];
  
  color c;
  
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      c = photo.pixels[j*width+i];
      hues[i][j] = hue(c);
      saturations[i][j] = saturation(c);
      brightnesses[i][j] = brightness(c);
    }
  }
  
  image(photo, 0, 0);
}

void draw(){
  parallelBubbleSort();
}

void parallelBubbleSort(){
  boolean modified = false;
  int len = hues.length;
  
  for(int i=0; i<len; i++){
    modified = modified || bubbleSort(i);
  }
  
  if(!modified){
    noLoop();
    println("Finished!");
  }
}

boolean bubbleSort(int col){
  boolean modified = false;
  int len = hues[col].length;
  
  for(int i=1; i<len; i++){
    if(hues[col][i-1] > hues[col][i]){
      exchange(col, i-1, i);
      modified = true;
    }
  }
  
  return modified;
}

void exchange(int col, int line1, int line2){
  float tempHue = hues[col][line1];
  float tempSat = saturations[col][line1];
  float tempBright = brightnesses[col][line1];
  hues[col][line1] = hues[col][line2];
  saturations[col][line1] = saturations[col][line2];
  brightnesses[col][line1] = brightnesses[col][line2];
  hues[col][line2] = tempHue;
  saturations[col][line2] = tempSat;
  brightnesses[col][line2] = tempBright;
  stroke(hues[col][line1], saturations[col][line1], brightnesses[col][line1]);
  point(col, line1);
  stroke(hues[col][line2], saturations[col][line2], brightnesses[col][line2]);
  point(col, line2);
}
