
int game(){
  frameRate(160);
  int cnt_banana = 0;

  background(255);
  image(BACK,0,0,600,400);
  
  fill(255); 
  image(Kill,450,20,120,70);
  textSize(18);
 
  text("SCORE:" + SCORE,500-20,50);
  text("HP:" + HERO_HP,500-20,70);
  
  
  
 for(BANANA b: BNN){
   b.display(); // display of dropped bananas
 } 
 
 for(Kouji i: k){
   if(millis() - i.ATTACKED < 1000){
     i.display(0);
     trigger = false; // While Trigger is false, You cannot attack any Gorilla 
     
   }else{
    i.Xmove(x);
    i.display(1);
    trigger = true;
    
    if(i.contact(x,y)==true){
        if(i.CONTACTING - i.CONTACTED == -100){
          int DAMAGE = (int)random(8,15);
          HERO_HP = HERO_HP -DAMAGE;
          println(DAMAGE);
          text(DAMAGE,i.xpos,i.ypos-20);
          
        }
    }
    CONTACT_flag = false;
    
 //   text(millis()-i.ATTACKED,i.xpos,i.ypos);
   }
  }
  
  if (trigger ==false){
    // image(fight[0+direct%5],int(x),int(y)-15,70,70);
     DISP = fight[0+direct%5];
     
  }else{
    //image(Stay[(int)(direct/6)],int(x),int(y)-15,70,70);
    DISP = Stay[(int)(direct/6)];
  }
 
 
  if (keyPressed && key == CODED) {
    if (keyCode == LEFT) {
      xSpeed = -0.5;
      x += xSpeed;
      direct = 6;
      DISP = walk[int(x/25)%6+direct];
    } else if (keyCode == RIGHT) {
      xSpeed = 0.5;
      x += xSpeed;
      direct = 0;
      DISP = walk[int(x/25)%6+direct];
    }
  }
  
   image(DISP,int(x),int(y)-75,120,120);
  
//  x += xSpeed;
  y += ySpeed; //加速していきますよ  

  if(x > width - 11) {
    x = width - 11;
  } else if (x < 2) {
    x = 2;
  }
  
  if(y<350) { 
    ySpeed += 0.2;
  } else { 
    ySpeed = 0;
    y = 350;
  }

  

  if (keyPressed && key == CODED) {
    if (keyCode == LEFT) {
      xSpeed = -1;
      x += xSpeed;
    } else if (keyCode == RIGHT) {
      xSpeed = 1;
      x += xSpeed;
    }
    else if (keyCode == DOWN && flag==false && trigger == true){
       
      flag = true;
      
      
      for(Iterator<Kouji> myIterator = k.iterator(); myIterator.hasNext();){
        Kouji currentItem = myIterator.next();
        
        if(currentItem.hit(x,y) == true){
          sel = currentItem;
          sel.HP -= random(1,10); 
          sel.ATTACKED = millis();
          sel.Act = true; // Trigger of Kouji's Anger
          
          player.play();
          player.rewind();
          
          
          if(sel.HP <=0){   
           sel.Act = false; 
           sel.SEL = loadImage("grdc2.png");
           myIterator.remove();
           
           if(random(0,1)>0.5){
             BNN.add(new BANANA(sel.xpos, 330));  
           }
           SCORE++;
           NUMBER_OF_KILL++;
          } 
          
        }else{
          DISP = fight[1];
          sel =null;
          gesture.play();
          gesture.rewind();
        }
      }   
      
    }
  }
  else{
 //   not_ATTACK = millis();
    flag=false;
  }
 
  for(Iterator<BANANA> myIterator = BNN.iterator(); myIterator.hasNext();){
        BANANA currentItem = myIterator.next();
        cnt_banana++;
        
        if(currentItem.hit(x,y) == true){
          sel_banana = currentItem;
          myIterator.remove();  
          eating.play();
          eating.rewind();
         
           HERO_HP += 5; 
         println("pick up:" + cnt_banana);
        }
  } 
  
    
   if(NUMBER_OF_KILL==4){
      k.add(new Kouji(random(0,150),320));
      k.add(new Kouji(random(200,300),320));
      k.add(new Kouji(random(350,470),320));
      k.add(new Kouji(random(520,590),320));
     
      for(Kouji i: k){
        i.HP=KOUJI_HP;
        i.Act =false;
      }
     NUMBER_OF_KILL= 0;
   } 

  if(t > 60){  // if ellapsed time is larger than 5 seconds
    return 3; // go to ending
  } 
  
  if(SCORE ==12){
    return 4; // go to boss fight;
  }
  return 2;
  
}

void keyPressed() {
  if(key == ' ' && y == 350) {
    ySpeed = -9;
  }
  
}

void keyReleased(){
  if(key == RIGHT || key == LEFT){
    xSpeed =0;
  }
}


int ending(){
  fill(255);
  text("Congratulation!! You Killed TNOK!", width * 0.5, height * 0.5);
  if(t > 3){
    text("You Killed " + SCORE+ " Gorrilas", width * 0.5, height * 0.7);
    if(keyPressed && key == 'z'){
        return 0;
    }
  }
  return 3; 
}
