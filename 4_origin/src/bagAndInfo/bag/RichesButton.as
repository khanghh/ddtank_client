package bagAndInfo.bag
{
   import com.pickgliss.ui.core.TransformableComponent;
   import flash.display.Graphics;
   
   public class RichesButton extends TransformableComponent
   {
       
      
      public function RichesButton()
      {
         super();
      }
      
      override public function draw() : void
      {
         drawBackground();
         super.draw();
      }
      
      private function drawBackground() : void
      {
         var pen:Graphics = graphics;
         pen.clear();
         pen.beginFill(16777215,0);
         pen.drawRect(0,0,_width <= 0?1:Number(_width),_height <= 0?1:Number(_height));
         pen.endFill();
      }
   }
}
