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
      
      public function PlayerTool()
      {
         super();
         _selfInfo = PlayerManager.Instance.Self;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _hBox = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.toolVBox");
         addChild(_hBox);
         _kingBlessIcon = ComponentFactory.Instance.creatCustomObject("hall.playerInfo.KingBlessIcon",[1]);
         _kingBlessIcon.setInfo(KingBlessManager.instance.getRemainTimeTxt().isOpen,true);
         _hBox.addChild(_kingBlessIcon);
         _emailBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.mailBtn");
         _emailBtn.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.email");
         _emailBtn.buttonMode = true;
         _emailBtn.movie.gotoAndStop(1);
         _hBox.addChild(_emailBtn);
         showEmailEffect(true);
         _celebrityBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.celebrityBtn");
         _celebrityBtn.tipData = LanguageMgr.GetTranslation("ddt.hallStateView.celebrityText");
         _hBox.addChild(_celebrityBtn);
         _deedIcon = ComponentFactory.Instance.creatCustomObject("hall.playerInfo.DeedIconIcon");
         _deedIcon.setInfo(DeedManager.instance.isOpen,true);
         _hBox.addChild(_deedIcon);
         _loginDevice = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.loginDeviceBtn");
         if(LoginDeviceManager.instance().loginType == "3")
         {
            _loginDevice.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.loginDevice.reward");
            _loginDevice.movie.gotoAndStop(2);
         }
         else
         {
            _loginDevice.tipData = LanguageMgr.GetTranslation("tank.view.common.BellowStripViewII.loginDevice.down");
            _loginDevice.movie.gotoAndStop(1);
         }
         _loginDevice.buttonMode = true;
         if(PathManager.getLoadingDevice() != "")
         {
            _hBox.addChild(_loginDevice);
         }
         _signBuffBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.signBuffBtn");
         _signBuffBtn.tipData = LanguageMgr.GetTranslation("ddt.hallStateView.signBuff.buttonTips");
         _hBox.addChild(_signBuffBtn);
         _hBox.arrange();
         if(_selfInfo.isOld)
         {
            RegressManager.instance.addEventListener("regress_addbtn",__onAddRegressBtn);
            SocketManager.Instance.addEventListener(PkgEvent.format(149,5),__onRegressRecvPacks);
            SocketManager.Instance.out.sendRegressRecvPacks();
         }
      }
      
      protected function __onRegressRecvPacks(event:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,5),__onRegressRecvPacks);
         RegressManager.recvPacksInfo(event.pkg);
      }
      
      private function __onAddRegressBtn(event:RegressEvent) : void
      {
         RegressManager.instance.removeEventListener("regress_addbtn",__onAddRegressBtn);
         if(!_selfInfo.isOld || RegressManager.isOver)
         {
            removeOldPlayerBtn();
         }
         else
         {
            _oldPlayerBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.oldPlayerBtn");
            _oldPlayerBtn.tipData = LanguageMgr.GetTranslation("ddt.hallStateView.oldPlayer");
            _hBox.addChild(_oldPlayerBtn);
            _hBox.arrange();
            _oldPlayerBtn.addEventListener("click",__onOldPlayerClick);
         }
         if(_selfInfo.isOld && !RegressManager.isOver && !_selfInfo.isSameDay && RegressManager.isFirstLogin && RegressManager.isAutoPop)
         {
            RegressManager.isAutoPop = false;
            RegressManager.instance.autoPopUp = true;
            RegressManager.instance.show();
         }
      }
      
      private function initEvent() : void
      {
         _emailBtn.addEventListener("click",__onMailClick);
         _celebrityBtn.addEventListener("click",__onCelebrityClick);
         _signBuffBtn.addEventListener("click",__onSignBuffClick);
         _loginDevice.addEventListener("click",__onLoginClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         MailManager.Instance.Model.addEventListener("initEmail",__updateEmail);
         MailManager.Instance.Model.addEventListener("cancelemailshine",__onSetEmailShine);
      }
      
      protected function __onSetEmailShine(event:NewHallEvent) : void
      {
         showEmailEffect(false);
      }
      
      protected function __updateEmail(event:Event) : void
      {
         if(_emailBtn)
         {
            showEmailEffect(true);
         }
      }
      
      private function showEmailEffect(show:Boolean) : void
      {
         if(show && MailManager.Instance.Model.hasUnReadEmail())
         {
            _emailBtn.movie.gotoAndStop(2);
            _emailBtn.mouseEnabled = true;
            _emailBtn.mouseChildren = true;
         }
         else
         {
            _emailBtn.movie.gotoAndStop(1);
         }
      }
      
      protected function __onOldPlayerClick(event:MouseEvent) : void
      {
         RegressManager.instance.show();
      }
      
      private function __propertyChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var grade:int = PlayerManager.Instance.Self.Grade;
         if(grade >= 20)
         {
            _celebrityBtn.alpha = 1;
            _celebrityBtn.mouseEnabled = true;
            _celebrityBtn.mouseChildren = true;
         }
         else
         {
            _celebrityBtn.alpha = 0;
            _celebrityBtn.mouseEnabled = false;
            _celebrityBtn.mouseChildren = false;
         }
         if(grade == 20 && !PlayerManager.Instance.Self.isNewOnceFinish(109))
         {
            SocketManager.Instance.out.syncWeakStep(109);
            NewHandContainer.Instance.showGuideCover("circle",[236,116,30]);
            NewHandContainer.Instance.showArrow(138,135,"hall.playerTool.tofflistGuidePos","","",LayerManager.Instance.getLayerByType(2),0,true);
         }
      }
      
      protected function __onSignBuffClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         SignBuffManager.instance.show();
      }
      
      protected function __onCelebrityClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("047");
         NewHandContainer.Instance.hideGuideCover();
         StateManager.setState("tofflist");
         ComponentSetting.SEND_USELOG_ID(8);
         if(PlayerManager.Instance.Self.IsWeakGuildFinish(76) && !PlayerManager.Instance.Self.IsWeakGuildFinish(78))
         {
            SocketManager.Instance.out.syncWeakStep(78);
         }
      }
      
      protected function __onMailClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         MailManager.Instance.switchVisible();
      }
      
      private function removeOldPlayerBtn() : void
      {
         if(_oldPlayerBtn)
         {
            _hBox.removeChild(_oldPlayerBtn);
            _oldPlayerBtn.dispose();
            _oldPlayerBtn.removeEventListener("click",__onOldPlayerClick);
            _oldPlayerBtn = null;
         }
      }
      
      private function __onLoginClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         LoginDeviceManager.instance().show();
      }
      
      private function removeEvent() : void
      {
         _emailBtn.removeEventListener("click",__onMailClick);
         _celebrityBtn.removeEventListener("click",__onCelebrityClick);
         _signBuffBtn.removeEventListener("click",__onSignBuffClick);
         _loginDevice.removeEventListener("click",__onLoginClick);
         if(_oldPlayerBtn)
         {
            _oldPlayerBtn.removeEventListener("click",__onOldPlayerClick);
         }
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         MailManager.Instance.Model.removeEventListener("initEmail",__updateEmail);
         MailManager.Instance.Model.removeEventListener("cancelemailshine",__onSetEmailShine);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_kingBlessIcon)
         {
            _kingBlessIcon.dispose();
            _kingBlessIcon = null;
         }
         if(_emailBtn)
         {
            _emailBtn.dispose();
            _emailBtn = null;
         }
         if(_celebrityBtn)
         {
            _celebrityBtn.dispose();
            _celebrityBtn = null;
         }
         if(_signBuffBtn)
         {
            _signBuffBtn.dispose();
            _signBuffBtn = null;
         }
         removeOldPlayerBtn();
         if(_deedIcon)
         {
            ObjectUtils.disposeObject(_deedIcon);
            _deedIcon = null;
         }
         if(_hBox)
         {
            _hBox.dispose();
            _hBox = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
