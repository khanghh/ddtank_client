package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   
   public class GodCardRaiseExchangeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _leftView:GodCardRaiseExchangeLeftView;
      
      private var _rightView:GodCardRaiseExchangeRightView;
      
      public function GodCardRaiseExchangeView(){super();}
      
      private function initView() : void{}
      
      public function updateView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
