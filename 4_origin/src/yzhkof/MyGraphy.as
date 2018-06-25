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
      
      public static function drawRectangle(width:Number = 100, height:Number = 100, is_fill:Boolean = true, colour:uint = 0) : Sprite
      {
         var re_obj:Sprite = new Sprite();
         re_obj.graphics.lineStyle(1,colour);
         if(is_fill)
         {
            re_obj.graphics.beginFill(colour);
         }
         re_obj.graphics.drawRect(0,0,width,height);
         re_obj.graphics.endFill();
         return re_obj;
      }
   }
}
