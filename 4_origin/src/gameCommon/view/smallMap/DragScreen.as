package gameCommon.view.smallMap
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class DragScreen extends Sprite
   {
       
      
      private var _w:int = 60;
      
      private var _h:int = 60;
      
      public function DragScreen(w:int, h:int)
      {
         super();
         _w = w < 1?1:w;
         _h = h < 1?1:h;
         buttonMode = true;
         drawBackground();
      }
      
      private function drawBackground() : void
      {
         var pen:Graphics = graphics;
         pen.clear();
         if(!GameControl.Instance.smallMapBorderEnable())
         {
            pen.lineStyle(1,10066329);
            pen.beginFill(16777215,0.4);
         }
         else
         {
            pen.lineStyle(2,Math.random() * 1048575);
            pen.beginFill(16777215,0);
         }
         pen.drawRect(0,0,_w,_h);
         pen.endFill();
      }
      
      override public function set width(value:Number) : void
      {
         if(_w != value)
         {
            _w = value < 1?1:Number(value);
            drawBackground();
         }
      }
      
      override public function set height(value:Number) : void
      {
         if(_h != value)
         {
            _h = value < 1?1:Number(value);
            drawBackground();
         }
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
