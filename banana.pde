class BANANA{
  PImage SEL = loadImage(sketchPath("src/img/other/banana.png"));
  float xpos;
  float ypos;
  
   BANANA(float x, float y){
       this.xpos= x;
       this.ypos = y;
       // display();
   }
  
  public void display(){
     image(SEL,this.xpos-100,this.ypos-10,70,70);
    
     
  }
  
  public boolean hit(float x,float y){
    if(this.xpos-120  <= x && x<= this.xpos-100 && this.ypos -50 <=y && y <= this.ypos +50 ){
      return true;
    }
    else 
    {
      return false;
    }
  }
}
