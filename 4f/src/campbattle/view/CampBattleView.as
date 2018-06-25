package campbattle.view{   import campbattle.CampBattleControl;   import campbattle.CampBattleManager;   import campbattle.data.CampModel;   import campbattle.data.RoleData;   import campbattle.event.MapEvent;   import campbattle.view.awardsView.AwardsViewFrame;   import campbattle.view.rank.ScoreRankView;   import campbattle.view.roleView.CampBattlePlayer;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatView;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import gameCommon.GameControl;   import gameCommon.model.SmallEnemy;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class CampBattleView extends BaseStateView   {                   private var _mapID:int;            private var _mapLayer:Sprite;            private var _uiLayer:Sprite;            private var _headView:HeadInfoView;            private var _titleView:CampBattleTitle;            private var _backBtn:CampBattleReturnBtn;            private var _smallMap:Bitmap;            private var _mapView:CampBattleMap;            private var _campLight:Bitmap;            private var _progressBar:CampProgress;            private var _statueBtn:CampStatueBtn;            private var _clickDoor:ClickDoor;            private var _battleTimer:CampBattleInTimer;            private var _chatView:ChatView;            private var _hideBtn:CampStateHideBtn;            private var _helpBtn:BaseButton;            private var _rankView:ScoreRankView;            private var _itemList:Array;            private var _awardsBtn:BaseButton;            public function CampBattleView() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function initData() : void { }
            private function initView() : void { }
            public function changeMap(id:int) : void { }
            private function createActItem() : void { }
            private function initEvent() : void { }
            private function __onClickAwardsBtn(evt:MouseEvent = null) : void { }
            protected function __onAddRole(event:MapEvent) : void { }
            protected function __onRemoveRole(event:MapEvent) : void { }
            protected function __onUpdateWinCount(event:MapEvent) : void { }
            private function __onDoorstatus(evt:PkgEvent) : void { }
            private function __onUpdateScoreHander(event:MapEvent) : void { }
            private function __onEnterFrameHander(event:Event) : void { }
            private function createBg() : void { }
            private function addChatView() : void { }
            private function __onStatueGotoFightHander(event:MapEvent) : void { }
            private function creatMap(clsStr:String = null, resStr:String = null, playerModel:DictionaryData = null, monsterModel:DictionaryData = null, itemList:Array = null, smallMap:Bitmap = null) : void { }
            private function __onGotoFightHander(event:MapEvent) : void { }
            private function __onCaptureMapHander(event:MapEvent) : void { }
            private function captureMap() : void { }
            private function __onCapMapHander(evt:PkgEvent) : void { }
            private function __onAddMonstersList(evt:PkgEvent) : void { }
            private function __onCaptureOverHander(event:MapEvent) : void { }
            private function __onRoleMoveHander(event:PkgEvent) : void { }
            private function __onToOhterMapHander(event:MapEvent) : void { }
            private function __onPlayerStateChange(evt:MapEvent) : void { }
            private function __onMonsterStateChange(evt:PkgEvent) : void { }
            private function getRoleData(zoneID:int, userID:int) : RoleData { return null; }
            private function createRrsurrectView() : void { }
            private function __onResurrectHandler(event:Event) : void { }
            private function __startLoading(e:Event) : void { }
            protected function __onFighterHander(event:MapEvent) : void { }
            protected function __onHideBtnClick(event:Event) : void { }
            protected function __onHelpBtnClick(event:MouseEvent) : void { }
            private function frameEvent(event:FrameEvent) : void { }
            protected function __onBackBtnClick(event:MouseEvent) : void { }
            protected function __onConfirm(event:FrameEvent) : void { }
            override public function getType() : String { return null; }
            override public function leaving(next:BaseStateView) : void { }
            private function removeEvent() : void { }
            private function removeMap() : void { }
            override public function dispose() : void { }
   }}