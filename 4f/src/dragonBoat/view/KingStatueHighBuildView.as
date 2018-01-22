package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class KingStatueHighBuildView extends BaseAlerFrame
   {
      
      private static const BUILD_COST:int = 100;
       
      
      private var _desc:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _coins:int;
      
      private var _type:int;
      
      public function KingStatueHighBuildView(){super();}
      
      public function init2(param1:int) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function inputTextChangeHandler(param1:Event) : void{}
      
      private function responseHandler(param1:FrameEvent) : void{}
      
      protected function __onResponse(param1:FrameEvent) : void{}
      
      private function enterKeyHandler() : void{}
      
      private function inputKeyDownHandler(param1:KeyboardEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
