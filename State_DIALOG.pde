
String[] DISPLAY_ARRAY ={};

String t1 = "S a v e   T h e   E a r t h";
String t2 = "K i l l   A l l   G o r i l l a";
String e = "じゃあね";
String[] s1;

int flag_disp = 0;    //フラグ

int line_h = 20;    //１行のサイズ
int line_w = 20;    //1行の文字数
int chara = 18;    //文字サイズ
int count = 0;    //文字数のカウント

int h = height;    //表示する高さ
int x_disp = 80;    //表示する位置（ｘ軸方向）
int f = 48; //flag(end)を除いた(50-flag最大値-1) 


int title(){
  HERO_HP = 50;
  SCORE =0;
  PImage gori= loadImage(sketchPath("src/img/gorilla/gr5.png"));
  
  text("Gorrila Hunter", width * 0.5, height * 0.3);
  text("Press 'z' key to start", width * 0.5, height * 0.7);
  
  image(Stay[0],15,200,200,200);
  image(gori,400,200,200,200);
  
  
  if(keyPressed && key == 'z'){ // if 'z' key is pressed
  background(0);
    return 2; // start game
  }
  return 0;
}


int dialog(){
  
  frameRate(20);
  
    
  fill(255);
  
  

  if(flag_disp == 0){
        s1 = splitTokens(t1);// トークンで分割
    }
    else if (flag_disp==1){
        s1 = splitTokens(t2);
        flag_disp +=f;
    }
   else if(flag_disp==50){ 
    s1=splitTokens(e);
    noLoop();
  }
    
    if(count < s1.length){
        fill(255);
        textAlign(LEFT);    //左揃え
        
        x_disp = chara * (count % line_w);
        if(count % line_w == 0 /*&& count != 0*/){
            h = line_h+300;//20文字出力したら改行
        }
       fill(255);
        text(s1[count],x_disp+80 ,h);
        println(h);
        
        count++;
    }
    else{ 
       
        if (mousePressed == true){
        background(0); //背景色
        flag_disp += 1;
        h=height/2;
    image(DIALOG_WINDOW,20,250,550,150);
        count = 0;}     
    }
  
  
  if(mousePressed == true && flag_disp == 50){
    return 2;  
  }
  return 1;
  
  
}

