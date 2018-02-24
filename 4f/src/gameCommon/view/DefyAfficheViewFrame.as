package gameCommon.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import room.model.RoomInfo;
   
   public class DefyAfficheViewFrame extends Frame
   {
      
      private static const ANNOUNCEMENT_FEE:int = 500;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _defyAffichebtn:TextButton;
      
      private var _defyAffichebtn1:TextButton;
      
      private var _roomInfo:RoomInfo;
      
      private var _str:String;
      
      private var _textInput:TextInput;
      
      private var _titText:FilterFrameText;
      
      private var _titleInfoText:FilterFrameText;
      
      public function DefyAfficheViewFrame(){super();}
      
      override public function dispose() : void{}
      
      public function inputCheck() : Boolean{return false;}
      
      public function set roomInfo(param1:RoomInfo) : void{}
      
      public function show() : void{}
      
      private function __alertSendDefy(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      private function __cancelClick(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function __leaveToFill(param1:FrameEvent) : void{}
      
      private function __okClick(param1:MouseEvent) : void{}
      
      private function __texeInput(param1:Event) : void{}
      
      private function handleString() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function selectedBandHander(param1:MouseEvent) : void{}
      
      private function initView() : void{}
   }
}
