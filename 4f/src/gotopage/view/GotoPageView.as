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
      
      public function GotoPageView(){super();}
      
      private function initView() : void{}
      
      private function creatBtn() : void{}
      
      private function clearBtn() : void{}
      
      private function __clickHandle(param1:MouseEvent) : void{}
      
      private function showAlert() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function skipView(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
