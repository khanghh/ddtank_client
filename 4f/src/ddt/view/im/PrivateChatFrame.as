package ddt.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.MinimizeFrame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import ddt.view.chat.ChatNamePanel;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   import vip.VipController;
   
   public class PrivateChatFrame extends MinimizeFrame
   {
       
      
      private var _info:PlayerInfo;
      
      private var _outputBG:ScaleBitmapImage;
      
      private var _inputBG:ScaleBitmapImage;
      
      private var _output:TextArea;
      
      private var _input:TextArea;
      
      private var _send:TextButton;
      
      private var _record:SimpleBitmapButton;
      
      private var _recordFrame:PrivateRecordFrame;
      
      private var _show:Boolean = false;
      
      private var _selfPortrait:PlayerPortraitView;
      
      private var _selfLevelT:FilterFrameText;
      
      private var _selfLevel:LevelIcon;
      
      private var _selfName:FilterFrameText;
      
      private var _selfVipName:GradientText;
      
      private var _targetProtrait:PlayerPortraitView;
      
      private var _targetLevelT:FilterFrameText;
      
      private var _targetLevel:LevelIcon;
      
      private var _targetName:FilterFrameText;
      
      private var _targetVipName:GradientText;
      
      private var _warningBg:Bitmap;
      
      private var _warning:Bitmap;
      
      private var _warningWord:FilterFrameText;
      
      private var _nameTip:ChatNamePanel;
      
      public function PrivateChatFrame(){super();}
      
      private function initView() : void{}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      public function clearOutput() : void{}
      
      public function addMessage(param1:String) : void{}
      
      public function addAllMessage(param1:Vector.<String>) : void{}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __targetProtraitClick(param1:MouseEvent) : void{}
      
      private function __keyDownHandler(param1:KeyboardEvent) : void{}
      
      protected function __addToStageHandler(param1:Event) : void{}
      
      protected function __focusOutHandler(param1:FocusEvent) : void{}
      
      protected function __focusInHandler(param1:FocusEvent) : void{}
      
      protected function __keyUpHandler(param1:KeyboardEvent) : void{}
      
      protected function __recordHandler(param1:MouseEvent) : void{}
      
      private function closeRecordFrame() : void{}
      
      protected function __recordCloseHandler(param1:Event) : void{}
      
      protected function __recordResponseHandler(param1:FrameEvent) : void{}
      
      protected function __sendHandler(param1:MouseEvent) : void{}
      
      private function checkHtmlTag(param1:String) : Boolean{return false;}
      
      protected function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
