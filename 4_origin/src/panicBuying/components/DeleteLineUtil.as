package panicBuying.components
{
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Shape;
   
   public class DeleteLineUtil
   {
       
      
      public function DeleteLineUtil()
      {
         super();
      }
      
      public static function newDeleteLine(param1:FilterFrameText) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(1,param1.textColor,1);
         _loc2_.graphics.moveTo(0,param1.height / 2);
         _loc2_.graphics.lineTo(param1.width,param1.height / 2);
         _loc2_.graphics.endFill();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         return _loc2_;
      }
      
      public static function setDeleteLine(param1:Shape, param2:FilterFrameText) : void
      {
         param1.graphics.clear();
         param1.graphics.lineStyle(1,param2.textColor,1);
         param1.graphics.moveTo(0,param2.height / 2);
         param1.graphics.lineTo(param2.width,param2.height / 2);
         param1.graphics.endFill();
         param1.x = param2.x;
         param1.y = param2.y;
      }
   }
}
