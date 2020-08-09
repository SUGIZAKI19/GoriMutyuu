import ddf.minim.*;
import java.util.Arrays;
import java.util.List;
import java.util.Iterator;


float x = 10, y = 350;
float xSpeed = 0, ySpeed = 0;//ySpeed
int NUMBER_OF_KILL=0;

boolean flag=false;
boolean CONTACT_flag = false;

int click =0;

int state; //return the state number
long t_start;
float t;
int direct= 0;//when turing to left, it becomes 0, ohterwise, 3; 


/*Settings of MUR's Image */
PImage[] walk; //walking
PImage[] Stay;
PImage[] fight;
PImage[] K;

PImage DISP; //display Image
PImage BACK;


/*Initiation of Kouji's parameter*/
ArrayList<Kouji> k;
int KOUJI_HP=10;
int KOUJI_HP_MAX=10;

/*Hero's HP*/
int HERO_HP=50;

/*Initiation of TNOK's parameter*/
ArrayList<TNOK> tnok;

/*Recover Item*/
ArrayList<BANANA> BNN; 

PImage Kill;
PImage DIALOG_WINDOW;

int SCORE=0;
Kouji sel = null;
TNOK sel_tnok = null;
BANANA  sel_banana = null;

float attack_START = 114514;
boolean trigger=true; // initialization of trigger


Minim minim;
AudioPlayer player;
AudioPlayer gesture;
AudioPlayer eating;


void setup() {//initialization
  PImage banana = loadImage(sketchPath("src/img/other/banana.png"));
  size(600, 400);
  frameRate(150);
  background(0);
  textSize(32);
  textAlign(CENTER);
  fill(255);

  state = 0; //initialization of statement
  t_start = millis();
  k = new ArrayList<Kouji>();
  tnok = new ArrayList<TNOK>(); //Tanioka Class
  BNN = new ArrayList<BANANA>();


  minim = new Minim(this);
  player = minim.loadFile(sketchPath("src/sound/sword-slash3.mp3"));
  gesture = minim.loadFile(sketchPath("src/sound/sword-gesture2.mp3"));
  eating = minim.loadFile(sketchPath("src/sound/eating_banana.mp3"));

  Kill = loadImage(sketchPath("src/img/other/kill_number.png"));
  DIALOG_WINDOW = loadImage("Dialog.png");
  BACK = loadImage(sketchPath("src/img/other/background.png"));

  Stay = new PImage[2];
  walk = new PImage[12];
  fight = new PImage[2];

  for (int i=0; i<Stay.length; i++) {
    Stay[i] = loadImage(sketchPath("src/img/hero/c"+ (i+1) +"w.png"));
  }

  for (int i=0; i<walk.length; i++) {
    walk[i] = loadImage(sketchPath("src/img/hero/cwc"+ (i+1) +".png"));
  }
  
  for (int i=0; i<fight.length; i++) {
    fight[i] = loadImage(sketchPath("src/img/hero/cp" + (i+1) + ".png"));
  }


  DISP = Stay[0];


  k.add(new Kouji(random(0, 150), 320));
  k.add(new Kouji(random(200, 300), 320));
  k.add(new Kouji(random(350, 470), 320));
  k.add(new Kouji(random(520, 590), 320));

  for (Kouji i : k) { // intialization of each parameter
    i.HP = KOUJI_HP;
    i.ATTACKED = 0;
    i.AFTER_ATTACKED = 0;
    i.CONTACTED = 0;
    i.CONTACTING = 0;
    i.D = 0;

    i.WALK = new PImage[10];
    
    for (int j=0; j<i.WALK.length; j++) {
      i.WALK[j] = loadImage(sketchPath("src/img/gorilla/gr"+ j +".png"));
    }

    i.Act = false; // IF Koji has never been to attack, Variable "act" remain 0.
  }
  
  tnok.add(new TNOK(random(200, 300), 320));
  
   for (TNOK i : tnok) { // intialization of each parameter
    i.HP = KOUJI_HP;
    i.ATTACKED = 0;
    i.AFTER_ATTACKED = 0;
    i.CONTACTED = 0;
    i.CONTACTING = 0;
    
   i.Muki = new PImage[6]; 
    for (int j=0; j<i.Muki.length; j++) {
      i.Muki[j] = loadImage(sketchPath("src/img/tanioka/ewc"+ (j+1) +".png"));
    }
    i.Act = false; // IF Koji has never been to attack, Variable "act" remain 0.
  }
};

void draw() {
  
  t = (millis() - t_start) / 1000.0; 
 // text(nf(t, 1, 3)  + "sec.", width * 0.5, height * 0.9); // for debugging

  int nextState= 0;
  if (state == 0) { 
    nextState = title();
  } 
 /* else if (state ==1) {
    nextState = dialog();
  }*/
  else if (state == 2) { 
    nextState = game();
    
    
  } else if (state == 3) { 
    nextState = ending();
  }
  
  else if(state == 4){
    nextState = Boss_fight();
  }



  if (state != nextState) { 
    t_start = millis();
  } 
  state = nextState;
}

