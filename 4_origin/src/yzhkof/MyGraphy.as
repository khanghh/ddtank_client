package yzhkof
{
   import flash.display.Sprite;
   
   public class MyGraphy
   {
       
      
      public function MyGraphy()
      {
         super();
         throw new Error("无法被实例化");
      }
      
      public static function drawRectangle(param1:Number = 100, param2:Number = 100, param3:Boolean = true, param4:uint = 0) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.lineStyle(1,param4);
         if(param3)
         {
            _loc5_.graphics.beginFill(param4);
         }
         _loc5_.graphics.drawRect(0,0,param1,param2);
         _loc5_.graphics.endFill();
         return _loc5_;
      }
   }
}
