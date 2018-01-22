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
      
      public function setColor(param1:int) : void
      {
         _color = param1;
         draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         _loc1_.beginGradientFill("radial",[_color,_color],_alphas,_ratios);
         _loc1_.drawCircle(0,0,_radius);
         _loc1_.endFill();
      }
      
      public function set radius(param1:int) : void
      {
         _radius = param1;
         draw();
      }
      
      public function set alphas(param1:String) : void
      {
         _alphas = param1.split(",");
         draw();
      }
      
      public function set ratios(param1:String) : void
      {
         _ratios = param1.split(",");
         draw();
      }
   }
}
