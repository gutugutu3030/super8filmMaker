import processing.pdf.*;

int speed=24;
float coma=4.2335;


int dpi=72;//72; //解像度
//float tpm=dpi/25.4;
float tpm=0.03937*dpi;
float width_mm=210;
float height_mm=297;
int width_px=int(px(width_mm));
int height_px=int(px(height_mm));

ArrayList<PImage> fsList;
File bgm=null;

void setup() {
  println(width_px+","+ height_px);
  size(width_px, height_px);
  scale(tpm); 
  drop_init();
  //initWave(dataPath("mix.wav"));
  fsList=new ArrayList<PImage>();
  //fsList.add(loadImage("D:/Dropbox/processing/Other/bou/1.png"));
  //create1(new File(sketchPath("mix.pdf")));
}

void fileSelected(List<File> fs) {
  println(fs.size()+"files");
  ArrayList<File> images=new ArrayList<File>();
  for (File f : fs) {
    String ext=f.getName().substring(f.getName().lastIndexOf('.')+1).toLowerCase();
    if (ext.equals("png")) {
      images.add(f);
    }
    if (ext.equals("jpg")) {
      images.add(f);
    }
    if (ext.equals("gif")) {
      images.add(f);
    }
    if (ext.equals("wav")) {
      bgm=f;
    }
  }
  Collections.sort(images, new Comparator<File>() {
    public int compare(File a, File b) {
      int x=Integer.parseInt(a.getName().substring(0, a.getName().lastIndexOf('.')));
      int y=Integer.parseInt(b.getName().substring(0, b.getName().lastIndexOf('.')));
      return x-y;
    }
  }
  );
  fsList=new ArrayList<PImage>();
  for (File f : images) {
    println(f.getName());
    PImage img=loadImage(f.getAbsolutePath());
    if (img!=null) {
      fsList.add(img);
    }
  }
  if (bgm!=null) {
    create(null);
    return;
  }
  selectOutput("Select a file to write to:", "create");
}


void create(File f) {
  if (bgm!=null) {
    initWave(bgm.getAbsolutePath());
  }
  String pdfPath=(bgm!=null)?(bgm.getAbsolutePath().substring(0, bgm.getAbsolutePath().lastIndexOf('.'))+".pdf"):f.getAbsolutePath();
  PGraphicsPDF pdf=(PGraphicsPDF)beginRecord(PDF, pdfPath);
  imageMode(CENTER);
  while (true) {
    background(255);
    scale(tpm); 
    createFilms(fsList);
    if (fsList==null||fsList.size()==0) {
      break;
    }
    pdf.nextPage();
  }
  endRecord();
  fsList=null;
  println("done.");
  exit();
}

void create1(File f) {
  PGraphicsPDF pdf=(PGraphicsPDF)beginRecord(PDF, f.getAbsolutePath());
  imageMode(CENTER);
  while (true) {
    background(255);
    scale(tpm); 
    createFilms1();
    if (fsList==null||fsList.size()==0) {
      break;
    }
    pdf.nextPage();
  }
  endRecord();
  fsList=null;
  println("done.");
}

void createFilms1() {
  PImage img[]=new PImage[184];
  for (int i=0; i<img.length; i++) {
    img[i]=loadImage("C:\\Users\\gutug_000\\Dropbox\\processing\\Other\\bou/"+(i+1)+".png");
  }
  ArrayList<PImage> fs=new ArrayList<PImage>();

  int length=67;
  float y=6;
  boolean flg=false;
  noFill();
  stroke(0);
  strokeWeight(0.01);
  rect(3, 3, 18*11+3, coma*length+6);
  for (int i=0; i<18; i++) {
    if (i%4==0) {
      for (PImage j : img) {
        //fs.add(j);
      }
    }
    float x=6+i*11;
    fill(0);
    line(x+8.1, y, x+8.1, y-1);
    line(x+8.1, y+coma*67, x+8.1, y+coma*67+1);
    rect(x+6.9, y, 2, coma*67);
    noFill();
    if (bgm!=null) {
      drawWave(x+7.5825, y+coma, y+coma*65);
    }
    textSize(2);
    createFilm(x, y, 67, coma, fs, i);
  }
}
void createFilms(ArrayList<PImage> fs) {
  int length=67;
  float y=6;
  boolean flg=false;
  noFill();
  stroke(0);
  strokeWeight(0.1);
  rect(3, 3, 18*11+3, coma*length+6);
  for (int i=0; i<18; i++) {
    float x=6+i*11;
    textSize(2);
    createFilm(x, y, 67, coma, fs, i);
    fill(0);
    line(x+8.05, y, x+8.1, y-1);
    line(x+8.05, y+coma*67, x+8.1, y+coma*67+1);
    //rect(x+6.9, y, 1, coma*67);
    rect(x+7, y, 1.9, coma*67);
    noFill();
    drawWave(x+7.5825, y+coma, y+coma*66);
  }
}
//void createFilm(float x, float y, int length, ArrayList<PImage> fs) {
//  createFilm(x, y, length, 4.2335, fs);
//}
void createFilm(float x, float y, int length, float coma, ArrayList<PImage> fs, int index) {
  noFill();
  stroke(0);
  strokeWeight(0.1);
  rect(x, y, 8, coma*length);
  for (int i=0; i<length; i++) {
    //rect(x+0.5, y+coma*(i+0.5), 1, 1);
    rect(x+0.8, y+coma*(i+0.5), 0.6, 1);
    if (i==0) {
      fill(0);
      text(index, x+4.5, y+coma*(i+0.5));
      noFill();
    } else if (i==length-1) {
      fill(0);
      text(index+1, x+4.32, y+coma*(i+0.5));
      noFill();
    } else if (fs!=null&&fs.size()>0) {
      PImage frame=fs.get(0);
      image(frame, x+4.32, y+coma*(i+0.5), 5.69, 4.14);
      fs.remove(0);
    }
  }
}

float px(float mm) {
  return tpm*mm;
}

