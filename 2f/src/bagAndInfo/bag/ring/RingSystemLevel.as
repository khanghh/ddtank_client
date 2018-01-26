package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class RingSystemLevel extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _level:FilterFrameText;
      
      private var _levelBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _mask:Shape;
      
      private var _exp:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      public function RingSystemLevel(){super();}
      
      private function initView() : void{}
      
      private function creatProgress() : void{}
      
      public function setProgress(param1:int, param2:int, param3:int) : void{}
      
      private function initEvent() : void{}
      
      public function dispose() : void{}
      
      private function removeEvent() : void{}
   }
}
