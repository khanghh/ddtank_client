package campbattle.view
{
   import campbattle.CampBattleControl;
   import campbattle.CampBattleManager;
   import campbattle.data.CampModel;
   import campbattle.data.RoleData;
   import campbattle.event.MapEvent;
   import campbattle.view.awardsView.AwardsViewFrame;
   import campbattle.view.rank.ScoreRankView;
   import campbattle.view.roleView.CampBattlePlayer;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.GameControl;
   import gameCommon.model.SmallEnemy;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class CampBattleView extends BaseStateView
   {
       
      
      private var _mapID:int;
      
      private var _mapLayer:Sprite;
      
      private var _uiLayer:Sprite;
      
      private var _headView:HeadInfoView;
      
      private var _titleView:CampBattleTitle;
      
      private var _backBtn:CampBattleReturnBtn;
      
      private var _smallMap:Bitmap;
      
      private var _mapView:CampBattleMap;
      
      private var _campLight:Bitmap;
      
      private var _progressBar:CampProgress;
      
      private var _statueBtn:CampStatueBtn;
      
      private var _clickDoor:ClickDoor;
      
      private var _battleTimer:CampBattleInTimer;
      
      private var _chatView:ChatView;
      
      private var _hideBtn:CampStateHideBtn;
      
      private var _helpBtn:BaseButton;
      
      private var _rankView:ScoreRankView;
      
      private var _itemList:Array;
      
      private var _awardsBtn:BaseButton;
      
      public function CampBattleView(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function initData() : void{}
      
      private function initView() : void{}
      
      public function changeMap(param1:int) : void{}
      
      private function createActItem() : void{}
      
      private function initEvent() : void{}
      
      private function __onClickAwardsBtn(param1:MouseEvent = null) : void{}
      
      protected function __onAddRole(param1:MapEvent) : void{}
      
      protected function __onRemoveRole(param1:MapEvent) : void{}
      
      protected function __onUpdateWinCount(param1:MapEvent) : void{}
      
      private function __onDoorstatus(param1:PkgEvent) : void{}
      
      private function __onUpdateScoreHander(param1:MapEvent) : void{}
      
      private function __onEnterFrameHander(param1:Event) : void{}
      
      private function createBg() : void{}
      
      private function addChatView() : void{}
      
      private function __onStatueGotoFightHander(param1:MapEvent) : void{}
      
      private function creatMap(param1:String = null, param2:String = null, param3:DictionaryData = null, param4:DictionaryData = null, param5:Array = null, param6:Bitmap = null) : void{}
      
      private function __onGotoFightHander(param1:MapEvent) : void{}
      
      private function __onCaptureMapHander(param1:MapEvent) : void{}
      
      private function captureMap() : void{}
      
      private function __onCapMapHander(param1:PkgEvent) : void{}
      
      private function __onAddMonstersList(param1:PkgEvent) : void{}
      
      private function __onCaptureOverHander(param1:MapEvent) : void{}
      
      private function __onRoleMoveHander(param1:PkgEvent) : void{}
      
      private function __onToOhterMapHander(param1:MapEvent) : void{}
      
      private function __onPlayerStateChange(param1:MapEvent) : void{}
      
      private function __onMonsterStateChange(param1:PkgEvent) : void{}
      
      private function getRoleData(param1:int, param2:int) : RoleData{return null;}
      
      private function createRrsurrectView() : void{}
      
      private function __onResurrectHandler(param1:Event) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      protected function __onFighterHander(param1:MapEvent) : void{}
      
      protected function __onHideBtnClick(param1:Event) : void{}
      
      protected function __onHelpBtnClick(param1:MouseEvent) : void{}
      
      private function frameEvent(param1:FrameEvent) : void{}
      
      protected function __onBackBtnClick(param1:MouseEvent) : void{}
      
      protected function __onConfirm(param1:FrameEvent) : void{}
      
      override public function getType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function removeEvent() : void{}
      
      private function removeMap() : void{}
      
      override public function dispose() : void{}
   }
}
