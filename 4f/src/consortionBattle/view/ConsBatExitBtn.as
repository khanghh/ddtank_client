package consortionBattle.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsBatExitBtn extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _returnBtn:SimpleBitmapButton;
      
      public function ConsBatExitBtn(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function setInOutVisible(param1:Boolean) : void{}
      
      private function inHandler(param1:MouseEvent) : void{}
      
      private function exitHandler(param1:MouseEvent) : void{}
      
      private function __exitConfirm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
