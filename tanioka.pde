class TNOK extends Object{ // the instance of object


    PImage[] Muki;// external difined
    
    PImage Right = loadImage(sketchPath("src/img/tanioka/ewc1.png"));
    PImage Left = loadImage(sketchPath("src/img/tanioka/ewc3.png")); 
    PImage SEL =Right;       
    PImage Beauty= loadImage(sketchPath("src/img/tanioka/iwa.png")); 
    PImage Beauty2 = loadImage(sketchPath("src/img/tanioka/iwa.png"));
    float xpos;
    float ypos;
    int HP;
            
    
    float direction = 1; // Muki
    float ATTACKED;
    float AFTER_ATTACKED; // save the time;
    float CONTACTED;
    float CONTACTING;
    
    
    Boolean Act;
    
    
    long t_start = millis();
    float t=0;
   
    
    TNOK(float x, float y){
       this.xpos= x;
       this.ypos = y;
     //  this.direction = 0.5;
    }
    
    void Xmove(float x){ //if Koji is Attacked by Hero, variable turn into 1, other wise remain 0.
        
       if(this.Act == true){
         this.AFTER_ATTACKED = millis()-ATTACKED;
          this.xpos = this.xpos + direction;
          
          if(x < this.xpos){
            direction = -random(0.5,1.5);
            SEL = Muki[5-int(this.xpos/20)%6];
          }
          else if(x > this.xpos){
            direction = random(0.5,1.5);
            SEL = Muki[5-int(this.xpos/20)%6];
          }
          
          if(this.AFTER_ATTACKED !=0 && this.AFTER_ATTACKED > 7500){
            this.AFTER_ATTACKED = 0;
            this.Act = false;
          }
          
        }
       else if(this.Act == false){
           AFTER_ATTACKED = 0;
           this.xpos = this.xpos+ random(0,1) * direction;
           if(this.xpos > 590){
             this.xpos = 590;
             direction *= -1;
             SEL = Muki[5-int(this.xpos/20)%6];
           }
           else if(this.xpos < 0){
             this.xpos = 0;
             direction *= -1;
             SEL = Muki[5-int(this.xpos/20)%6];
           } 
        }
    }
    
    
    public void display(int o){
      
      if(o == 0){
       SEL = Beauty;
      }
      
      SEL = Muki[5-int(this.xpos/20)%6];
      
      fill(255);  
      image(SEL,int(this.xpos),int(ypos)-50,120,120);
      fill(127); 
      
     /*For debugging*/ 
    //  text(this.HP,this.xpos,this.ypos-150);
    //  text(this.AFTER_ATTACKED,this.xpos,this.ypos-200);
    //  text(this.ATTACKED,this.xpos,this.ypos-250); 
     /*debug END*/ 

      fill(255);  
   
    /*HP_GAUGE*/
      fill(0);
      rect(this.xpos,(this.ypos-20)-50,92,10);
      fill(0,0,255);
      rect(this.xpos,(this.ypos-19)-50,(this.HP*90)/KOUJI_HP_MAX,8); //visualize the Health Point
    /*HP_GAUGE END*/
      
    }
    
    
    public boolean contact(float x, float y){
       if(xpos - SEL.width/6 <= x && x<= xpos + SEL.width/6 && ypos -SEL.height/3 <=y && y <= ypos + SEL.height/3 ){
        //image(Beauty,int(this.xpos),int(ypos),50,50);
        this.CONTACTED = millis(); 
        return true;
      }
      else 
      {
        this.CONTACTING=millis();
        return false;
      }  
    }
    
    public boolean hit(float x,float y){
      if(xpos - SEL.width/2 <= x && x<= xpos + SEL.width/2 && ypos -SEL.height/2 <=y && y <= ypos + SEL.height/2 ){
        SEL = Beauty;
        return true;
      }
      else 
      {
        return false;
      }
    }
    
}

