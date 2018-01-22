package baglocked
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ExplainFrame extends Frame
   {
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _delPassBtn:TextButton;
      
      private var _explainMap:Sprite;
      
      private var _removeLockBtn:TextButton;
      
      private var _setPassBtn:TextButton;
      
      private var _updatePassBtn:TextButton;
      
      private var _ddtbagLocked:Scale9CornerImage;
      
      private var _btnSetting:SimpleBitmapButton;
      
      private var _pswNeededSelecterFrame:BagLockPSWNeededSelecterFrame;
      
      public function ExplainFrame(){super();}
      
      public function set bagLockedController(param1:BagLockedController) : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      protected function onSettingClick(param1:MouseEvent) : void{}
      
      private function __onSelecterFrameResponse(param1:FrameEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __setPassBtnClick(param1:Event) : void{}
      
      private function __delPassBtnClick(param1:Event) : void{}
      
      private function __removeLockBtnClick(param1:Event) : void{}
      
      private function __updatePassBtnClick(param1:Event) : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
