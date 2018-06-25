package gameCommon.view.smallMap
{
   import flash.display.Graphics;
   import phy.object.SmallObject;
   
   public class SmallBox extends SmallObject
   {
       
      
      private var _movieTime:Number = 0.8;
      
      public function SmallBox()
      {
         super();
         _radius = 3;
         _color = 16777215;
      }
      
      override public function onFrame(frameRate:int) : void
      {
         _elapsed = _elapsed + frameRate;
         if(_elapsed >= _movieTime * 1000)
         {
            _elapsed = 0;
         }
         draw();
      }
      
      override protected function draw() : void
      {
         var pen:Graphics = graphics;
         pen.clear();
         var alpha:Number = _elapsed / (_movieTime * 1000);
         pen.beginFill(_color,alpha);
         pen.drawCircle(0,0,_radius);
         pen.endFill();
      }
   }
}
