int Boss_fight(){
    frameRate(160);

  background(255);
  image(BACK,0,0,600,400);
  
  fill(255); 
  image(Kill,450,20,120,70);
  textSize(18);
 
  text("SCORE:" + SCORE,500-20,50);
  text("HP:" + HERO_HP,500-20,70);
  
 
 for(TNOK i: tnok){
   if(millis() - i.ATTACKED < 1000){
     i.display(0);
     trigger = false; // While Trigger is false, You cannot attack any Gorilla 
     
   }else{
    i.Xmove(x);
    i.display(1);
    trigger = true;
    
    if(i.contact(x,y)==true){
        if(i.CONTACTING - i.CONTACTED == -100){
          int DAMAGE = (int)random(0,10);
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
      xSpeed = -0.4;
      x += xSpeed;
      direct = 6;
      DISP = walk[int(x/25)%6+direct];
    } else if (keyCode == RIGHT) {
      xSpeed = 0.4;
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
      for(Iterator<TNOK> myIterator = tnok.iterator(); myIterator.hasNext();){
        TNOK currentItem = myIterator.next();
        
        if(currentItem.hit(x,y) == true){
          sel_tnok = currentItem;
          sel_tnok.HP -= random(0,6); 
          sel_tnok.ATTACKED = millis();
          sel_tnok.Act = true; // Trigger of Kouji's Anger
          
          player.play();
          player.rewind();
          
          
          if(sel_tnok.HP <=0){   
           sel_tnok.Act = false; 
           myIterator.remove();
           SCORE++;
           NUMBER_OF_KILL++;
      //     return 3;
          } 
          
        }else{
          DISP = fight[1];
          sel_tnok =null;
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
  if(t > 60) return 3;
  
  return 4;
}
