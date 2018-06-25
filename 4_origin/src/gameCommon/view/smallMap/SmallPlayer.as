package gameCommon.view.smallMap
{
   import flash.display.Graphics;
   import gameCommon.GameControl;
   
   public class SmallPlayer extends SmallLiving
   {
      
      private static const AttackMaxOffset:int = 4;
      
      private static const triangleCoords:Vector.<Object> = Vector.<Object>([{
         "x":0,
         "y":-8
      },{
         "x":4,
         "y":-12
      },{
         "x":-4,
         "y":-12
      }]);
       
      
      public function SmallPlayer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var rate:Number = NaN;
         var offset:Number = NaN;
         var alpha:Number = NaN;
         if(GameControl.Instance.smallMapPoint())
         {
            return;
         }
         var pen:Graphics = graphics;
         if(onMap)
         {
            if(GameControl.Instance.smallMapShape())
            {
               drawCircle();
            }
            else
            {
               pen.clear();
               pen.beginFill(_color);
               pen.drawCircle(0,0,_radius);
            }
            if(_elapsed >= 300)
            {
               rate = (0.6 * 1000 - _elapsed) / 300;
            }
            else
            {
               rate = _elapsed / 300;
            }
            if(_isAttacking)
            {
               offset = 4 * rate;
               pen.moveTo(triangleCoords[0].x,triangleCoords[0].y - offset);
               pen.lineTo(triangleCoords[1].x,triangleCoords[1].y - offset);
               pen.lineTo(triangleCoords[2].x,triangleCoords[2].y - offset);
            }
            pen.endFill();
            if(isSelf)
            {
               pen.lineStyle(2,_color,rate);
               pen.beginFill(0,0);
               pen.drawCircle(0,0,_radius + 2 + 2 * rate);
               pen.endFill();
            }
         }
         else
         {
            pen.beginFill(_color);
            pen.drawCircle(0,0,_radius);
            pen.endFill();
         }
      }
      
      override public function onFrame(frameRate:int) : void
      {
         _elapsed = _elapsed + frameRate;
         if(_elapsed >= 0.6 * 1000)
         {
            _elapsed = 0;
         }
         draw();
      }
      
      override public function set isAttacking(val:Boolean) : void
      {
         .super.isAttacking = val;
         draw();
      }
      
      public function get isSelf() : Boolean
      {
         if(!_info)
         {
            return false;
         }
         return _info.isSelf;
      }
   }
}
