package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.common.DeedIcon;
   import ddt.view.common.KingBlessIcon;
   import ddtDeed.DeedManager;
   import email.MailManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   import kingBless.KingBlessManager;
   import loginDevice.LoginDeviceManager;
   import oldPlayerRegress.RegressEvent;
   import oldPlayerRegress.RegressManager;
   import signBuff.SignBuffManager;
   import trainer.view.NewHandContainer;
   
   public class PlayerTool extends Sprite
   {
       
      
      private var _hBox:HBox;
      
      private var _kingBlessIcon:KingBlessIcon;
      
      private var _emailBtn:MovieImage;
      
      private var _celebrityBtn:SimpleBitmapButton;
      
      private var _oldPlayerBtn:SimpleBitmapButton;
      
      private var _selfInfo:SelfInfo;
      
      private var _deedIcon:DeedIcon;
      
      private var _loginDevice:MovieImage;
      
      private var _signBuffBtn:SimpleBitmapButton;
      
      public function PlayerTool(){super();}
      
      private function initView() : void{}
      
      protected function __onRegressRecvPacks(param1:PkgEvent) : void{}
      
      private function __onAddRegressBtn(param1:RegressEvent) : void{}
      
      private function initEvent() : void{}
      
      protected function __onSetEmailShine(param1:NewHallEvent) : void{}
      
      protected function __updateEmail(param1:Event) : void{}
      
      private function showEmailEffect(param1:Boolean) : void{}
      
      protected function __onOldPlayerClick(param1:MouseEvent) : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function refreshView() : void{}
      
      protected function __onSignBuffClick(param1:MouseEvent) : void{}
      
      protected function __onCelebrityClick(param1:MouseEvent) : void{}
      
      protected function __onMailClick(param1:MouseEvent) : void{}
      
      private function removeOldPlayerBtn() : void{}
      
      private function __onLoginClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
