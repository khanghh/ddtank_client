package gotopage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.dailyRecord.DailyRecordControl;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.MouseEvent;
   import giftSystem.GiftManager;
   import league.LeagueManager;
   import room.RoomManager;
   import setting.controll.SettingController;
   import team.TeamManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class GotoPageView extends BaseAlerFrame
   {
       
      
      private var _btnList:Vector.<SimpleBitmapButton>;
      
      private var _btnListContainer:SimpleTileList;
      
      private var _bg:Scale9CornerImage;
      
      private var _VIPBtn:SimpleBitmapButton;
      
      private var _kingBlessBtn:SimpleBitmapButton;
      
      private var _eliteBtn:SimpleBitmapButton;
      
      private var _battleShopBtn:SimpleBitmapButton;
      
      private var _giftBoxBtn:SimpleBitmapButton;
      
      private var _templeBtn:SimpleBitmapButton;
      
      private var _friendBtn:SimpleBitmapButton;
      
      private var _dailyBtn:SimpleBitmapButton;
      
      private var _setBtn:SimpleBitmapButton;
      
      private var _farmBtn:SimpleBitmapButton;
      
      private var _teamBtn:SimpleBitmapButton;
      
      private var _hotspringGameBtn:SimpleBitmapButton;
      
      private var _vline:MutipleImage;
      
      private var _hline:MutipleImage;
      
      private var _event:MouseEvent;
      
      public function GotoPageView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         info = new AlertInfo(LanguageMgr.GetTranslation("tank.view.ChannelList.FastMenu.titleText"));
         _info.showSubmit = false;
         _info.showCancel = false;
         _info.moveEnable = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("gotopage.GotoPageView.bg");
         addToContent(_bg);
         _eliteBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.eliteBtn");
         addToContent(_eliteBtn);
         _battleShopBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.battleShopBtn");
         addToContent(_battleShopBtn);
         _giftBoxBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.giftBoxBtn");
         addToContent(_giftBoxBtn);
         _templeBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.templeBtn");
         addToContent(_templeBtn);
         _friendBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.friendBtn");
         addToContent(_friendBtn);
         _dailyBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.dailyBtn");
         addToContent(_dailyBtn);
         _setBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.setBtn");
         addToContent(_setBtn);
         _hotspringGameBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.hotspringGameBtn");
         addToContent(_hotspringGameBtn);
         _teamBtn = ComponentFactory.Instance.creatComponentByStylename("gotopage.teamBtn");
         addToContent(_teamBtn);
         _vline = ComponentFactory.Instance.creatComponentByStylename("gotopage.vline");
         addToContent(_vline);
         _hline = ComponentFactory.Instance.creatComponentByStylename("gotopage.hline");
         addToContent(_hline);
         _btnList = new Vector.<SimpleBitmapButton>();
         _btnList.push(_eliteBtn);
         _btnList.push(_battleShopBtn);
         _btnList.push(_giftBoxBtn);
         _btnList.push(_templeBtn);
         _btnList.push(_friendBtn);
         _btnList.push(_dailyBtn);
         _btnList.push(_setBtn);
         _btnList.push(_teamBtn);
         _btnList.push(_hotspringGameBtn);
         creatBtn();
      }
      
      private function creatBtn() : void
      {
         var i:int = 0;
         for(i = 0; i < _btnList.length; )
         {
            _btnList[i].addEventListener("click",__clickHandle);
            i++;
         }
      }
      
      private function clearBtn() : void
      {
         var i:int = 0;
         for(i = 0; i < _btnList.length; )
         {
            if(_btnList[i])
            {
               _btnList[i].removeEventListener("click",__clickHandle);
               ObjectUtils.disposeObject(_btnList[i]);
            }
            _btnList[i] = null;
            i++;
         }
      }
      
      private function __clickHandle(evt:MouseEvent) : void
      {
         evt.stopImmediatePropagation();
         _event = evt;
         SoundManager.instance.play("047");
         if(evt.currentTarget != _dailyBtn && evt.currentTarget != _setBtn && evt.currentTarget != _eliteBtn && RoomManager.Instance.current != null && RoomManager.Instance.current.selfRoomPlayer != null)
         {
            if((StateManager.currentStateType == "missionResult" || RoomManager.Instance.current.isOpenBoss) && !RoomManager.Instance.current.selfRoomPlayer.isViewer)
            {
               showAlert();
               return;
            }
         }
         skipView(evt);
      }
      
      private function showAlert() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.missionsettle.dungeon.leaveConfirm.contents"),"",LanguageMgr.GetTranslation("cancel"),true,true,false,1);
         alert.moveEnable = false;
         alert.addEventListener("response",__onResponse);
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         alert = null;
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            skipView(_event);
         }
         else
         {
            dispose();
            dispatchEvent(new FrameEvent(0));
         }
      }
      
      private function skipView(evt:MouseEvent) : void
      {
         var limitLev:int = 0;
         var isFirst:Boolean = false;
         var currentClick:int = _btnList.indexOf(evt.currentTarget as SimpleBitmapButton);
         switch(int(currentClick))
         {
            case 0:
               limitLev = ServerConfigManager.instance.trialBattleLevelLimit;
               if(PlayerManager.Instance.Self.Grade < limitLev)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",limitLev));
                  return;
               }
               BattleGroudManager.Instance.onShow();
               break;
            case 1:
               if(PlayerManager.Instance.Self.Grade < 24)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",24));
                  return;
               }
               LeagueManager.instance.show();
               break;
            case 2:
               if(PlayerManager.Instance.Self.Grade < 23)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",23));
                  return;
               }
               new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],GiftManager.Instance.show);
               break;
            case 3:
               if(PlayerManager.Instance.Self.Grade < 8)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",8));
                  return;
               }
               if(PlayerManager.Instance.Self.apprenticeshipState == 0)
               {
                  StateManager.setState("academyRegistration");
               }
               else
               {
                  StateManager.setState("academyRegistration");
               }
               ComponentSetting.SEND_USELOG_ID(119);
               break;
            case 4:
               if(PlayerManager.Instance.Self.Grade < 11)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",11));
                  return;
               }
               isFirst = false;
               if(PlayerManager.Instance.Self.IsWeakGuildFinish(13) && !PlayerManager.Instance.Self.IsWeakGuildFinish(61))
               {
                  SocketManager.Instance.out.syncWeakStep(61);
                  isFirst = true;
               }
               StateManager.setState("civil",isFirst);
               ComponentSetting.SEND_USELOG_ID(10);
               break;
            case 5:
               DailyRecordControl.Instance.alertDailyFrame();
               break;
            case 6:
               SettingController.Instance.switchVisible();
               break;
            case 7:
               if(PlayerManager.Instance.Self.Grade < 26)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",26));
                  return;
               }
               TeamManager.instance.showTeamBattleFrame();
               break;
            case 8:
               HappyLittleGameManager.instance.show();
         }
         dispatchEvent(new FrameEvent(0));
      }
      
      override public function dispose() : void
      {
         GotoPageController.Instance.isShow = false;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_VIPBtn)
         {
            ObjectUtils.disposeObject(_VIPBtn);
         }
         _VIPBtn = null;
         if(_kingBlessBtn)
         {
            ObjectUtils.disposeObject(_kingBlessBtn);
         }
         _kingBlessBtn = null;
         if(_eliteBtn)
         {
            ObjectUtils.disposeObject(_eliteBtn);
         }
         _eliteBtn = null;
         if(_battleShopBtn)
         {
            ObjectUtils.disposeObject(_battleShopBtn);
         }
         _battleShopBtn = null;
         if(_templeBtn)
         {
            ObjectUtils.disposeObject(_templeBtn);
         }
         _templeBtn = null;
         if(_giftBoxBtn)
         {
            ObjectUtils.disposeObject(_giftBoxBtn);
         }
         _giftBoxBtn = null;
         if(_friendBtn)
         {
            ObjectUtils.disposeObject(_friendBtn);
         }
         _friendBtn = null;
         if(_dailyBtn)
         {
            ObjectUtils.disposeObject(_dailyBtn);
         }
         _dailyBtn = null;
         if(_setBtn)
         {
            ObjectUtils.disposeObject(_setBtn);
         }
         _setBtn = null;
         ObjectUtils.disposeObject(_teamBtn);
         _teamBtn = null;
         ObjectUtils.disposeObject(_hotspringGameBtn);
         _hotspringGameBtn = null;
         if(_vline)
         {
            ObjectUtils.disposeObject(_vline);
         }
         _vline = null;
         if(_hline)
         {
            ObjectUtils.disposeObject(_hline);
         }
         _hline = null;
         if(_btnList)
         {
            clearBtn();
         }
         ObjectUtils.disposeObject(_btnListContainer);
         _btnList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
