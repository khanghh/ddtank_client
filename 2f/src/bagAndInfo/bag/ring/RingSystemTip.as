package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RingSystemTip extends Sprite implements Disposeable
   {
       
      
      private var _addition:Vector.<FilterFrameText>;
      
      private var _ringBitmap:Vector.<Bitmap>;
      
      public function RingSystemTip(){super();}
      
      private function initView() : void{}
      
      public function setAdditiontext(param1:Array) : void{}
      
      public function dispose() : void{}
   }
}
