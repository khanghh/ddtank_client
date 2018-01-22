package gameCommon.view.smallMap
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   
   public class DragScreen extends Sprite
   {
       
      
      private var _w:int = 60;
      
      private var _h:int = 60;
      
      public function DragScreen(param1:int, param2:int)
      {
         super();
         _w = param1 < 1?1:param1;
         _h = param2 < 1?1:param2;
         buttonMode = true;
         drawBackground();
      }
      
      private function drawBackground() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         if(!GameControl.Instance.smallMapBorderEnable())
         {
            _loc1_.lineStyle(1,10066329);
            _loc1_.beginFill(16777215,0.4);
         }
         else
         {
            _loc1_.lineStyle(2,Math.random() * 1048575);
            _loc1_.beginFill(16777215,0);
         }
         _loc1_.drawRect(0,0,_w,_h);
         _loc1_.endFill();
      }
      
      override public function set width(param1:Number) : void
      {
         if(_w != param1)
         {
            _w = param1 < 1?1:Number(param1);
            drawBackground();
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_h != param1)
         {
            _h = param1 < 1?1:Number(param1);
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
