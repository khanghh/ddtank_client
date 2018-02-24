package bagAndInfo.bag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BagArrangeTipSprite extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _contentTxt:FilterFrameText;
      
      private var _bagArrangeCheckBtn:SelectedCheckButton;
      
      private var _arrangeAdd:Boolean;
      
      public function BagArrangeTipSprite(){super();}
      
      public function get arrangeAdd() : Boolean{return false;}
      
      public function set arrangeAdd(param1:Boolean) : void{}
      
      private function initEvent() : void{}
      
      protected function __btnSelectedHandler(param1:MouseEvent) : void{}
      
      protected function __outHandler(param1:MouseEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function initView() : void{}
      
      protected function updateTransform() : void{}
      
      public function dispose() : void{}
   }
}
