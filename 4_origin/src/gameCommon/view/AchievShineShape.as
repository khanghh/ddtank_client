package gameCommon.view
{
   import flash.display.Graphics;
   import flash.display.Shape;
   
   public class AchievShineShape extends Shape
   {
       
      
      private var _color:int = 0;
      
      private var _radius:int;
      
      private var _alphas:Array;
      
      private var _ratios:Array;
      
      public function AchievShineShape()
      {
         super();
      }
      
      public function setColor(color:int) : void
      {
         _color = color;
         draw();
      }
      
      private function draw() : void
      {
         var pen:Graphics = graphics;
         pen.clear();
         pen.beginGradientFill("radial",[_color,_color],_alphas,_ratios);
         pen.drawCircle(0,0,_radius);
         pen.endFill();
      }
      
      public function set radius(val:int) : void
      {
         _radius = val;
         draw();
      }
      
      public function set alphas(val:String) : void
      {
         _alphas = val.split(",");
         draw();
      }
      
      public function set ratios(val:String) : void
      {
         _ratios = val.split(",");
         draw();
      }
   }
}
