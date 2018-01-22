package gameCommon.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapShape;
   import ddt.manager.BitmapManager;
   import flash.display.Sprite;
   
   public class AchievNumShape extends Sprite implements Disposeable
   {
       
      
      private var _bitmapMgr:BitmapManager;
      
      private var _numShapes:Vector.<BitmapShape>;
      
      public function AchievNumShape(){super();}
      
      public function dispose() : void{}
      
      public function drawNum(param1:int) : void{}
   }
}
