package ddt.view{   import bagAndInfo.BagAndInfoManager;   import calendar.CalendarManager;   import com.greensock.TweenLite;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.layout.StageResizeUtils;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.events.TaskEvent;   import ddt.manager.ExitPromptManager;   import ddt.manager.IMManager;   import ddt.manager.KeyboardShortcutsManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.PositionUtils;   import ddtBuried.BuriedManager;   import farm.FarmModelController;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import flash.utils.getTimer;   import flash.utils.setTimeout;   import gotopage.view.GotoPageController;   import hall.HallStateView;   import hall.tasktrack.HallTaskGuideManager;   import horse.HorseManager;   import magicStone.MagicStoneManager;   import petsBag.PetsBagManager;   import quest.QuestBubbleManager;   import quest.TaskManager;   import road7th.utils.MovieClipWrapper;   import trainer.controller.WeakGuildManager;   import trainer.view.NewHandContainer;      public class MainToolBar extends Sprite   {            public static const ENTER_HALL:int = 0;            public static const LEAVE_HALL:int = 1;            private static var _instance:MainToolBar;                   private var _toolBarBg:Bitmap;            private var _bgGradient:Bitmap;            private var _goSupplyBtn:BaseButton;            private var _goShopBtn:BaseButton;            private var _goBagBtn:BaseButton;            private var _goTaskBtn:BaseButton;            private var _goFriendListBtn:BaseButton;            private var _goSignBtn:BaseButton;            private var _goChannelBtn:BaseButton;            private var _goReturnBtn:BaseButton;            private var _goExitBtn:BaseButton;            private var _goBuriedBtn:BaseButton;            private var _goPetBtn:BaseButton;            private var _horseBtn:BaseButton;            private var _callBackFun:Function;            private var _unReadTask:Boolean;            private var _enabled:Boolean;            private var _unReadMovement:Boolean;            private var _taskEffectEnable:Boolean;            private var _signEffectEnable:Boolean = true;            private var _boxContainer:HBox;            private var allBtns:Array;            private var _isEvent:Boolean;            private var _bagTxt:Bitmap;            private var _shopTxt:Bitmap;            private var _jobTxt:Bitmap;            private var _friendTxt:Bitmap;            private var _signTxt:Bitmap;            private var _otherTxt:Bitmap;            private var _petTxt:Bitmap;            private var _gameSetTxt:Bitmap;            private var _horseTxt:Bitmap;            private var _guideBtnTxtList:Array;            private var _openBtnList:Array;            private var _placePointList:Array;            private var _lastClick:Number = 0;            private var _taskShineEffect:IEffect;            private var _signShineEffect:IEffect;            private var _friendShineEffec:IEffect;            private var _bagShineEffect:IEffect;            private var _talkTimer:Timer;            public function MainToolBar() { super(); }
            public static function get Instance() : MainToolBar { return null; }
            override public function get width() : Number { return 0; }
            private function initView() : void { }
            public function setMoveChild(x:int, y:int) : void { }
            private function createGuideData() : void { }
            public function set enabled(value:Boolean) : void { }
            public function enableAll() : void { }
            public function disableAll() : void { }
            private function initEvent() : void { }
            protected function __propertyChange(event:PlayerPropertyEvent) : void { }
            private function taskChangeHandler(event:TaskEvent) : void { }
            private function checkHorseGuide() : void { }
            protected function __addToStageHandler(event:Event) : void { }
            protected function __noMessageHandler(event:Event) : void { }
            protected function __hasNewHandler(event:Event) : void { }
            private function __stopTalkTime(event:TimerEvent) : void { }
            protected function __friendOverHandler(event:MouseEvent) : void { }
            protected function __friendOutHandler(event:MouseEvent) : void { }
            public function newBtnOpenCartoon() : Point { return null; }
            private function showCurLevelOpenBtn(openBtn:Object) : void { }
            public function btnOpen() : void { }
            private function questManuGetHandler(event:PkgEvent) : void { }
            public function set backFunction(fn:Function) : void { }
            private function removeEvent() : void { }
            public function show() : void { }
            public function hide() : void { }
            public function setRoomWaitState() : void { }
            public function setRoomStartState() : void { }
            public function setRoomStartState2(value:Boolean) : void { }
            private function setSeverListStartState() : void { }
            public function setReturnEnable(value:Boolean) : void { }
            public function setBtnStateForConsortiaDomain(enable:Boolean) : void { }
            public function updateReturnBtn(type:int) : void { }
            public function set ExitBtnVisible(value:Boolean) : void { }
            private function isBitMapAddGrayFilter(bmp:Bitmap, flg:Boolean) : void { }
            private function dispose() : void { }
            private function __onReturnClick(event:MouseEvent) : void { }
            private function __onExitClick(event:MouseEvent) : void { }
            private function __onBuriedClick(event:MouseEvent) : void { }
            private function __onPetClick(event:MouseEvent) : void { }
            private function __onImClick(event:MouseEvent) : void { }
            private function __onChannelClick(evnet:MouseEvent) : void { }
            private function __onSignClick(evnet:MouseEvent) : void { }
            private function __onHorseClick(evnet:MouseEvent) : void { }
            public function set signEffectEnable(value:Boolean) : void { }
            private function _overTaskBtn(e:MouseEvent) : void { }
            private function _outTaskBtn(e:MouseEvent) : void { }
            private function _showTaskTip(e:Event) : void { }
            private function __onTaskClick(event:MouseEvent) : void { }
            private function showTask() : void { }
            private function __onBagClick(evnet:MouseEvent) : void { }
            private function __onShopClick(event:MouseEvent) : void { }
            private function toShopNeedConfirm() : Boolean { return false; }
            private function __confirmToShopResponse(event:FrameEvent) : void { }
            private function __onSupplyClick(evnet:MouseEvent) : void { }
            public function set unReadTask(value:Boolean) : void { }
            public function get unReadTask() : Boolean { return false; }
            public function set unReadMovement(value:Boolean) : void { }
            public function get unReadMovement() : Boolean { return false; }
            public function showTaskHightLight() : void { }
            public function hideTaskHightLight() : void { }
            public function showmovementHightLight() : void { }
            public function setRoomState() : void { }
            public function setShopState() : void { }
            public function setAuctionHouseState() : void { }
            private function update() : void { }
            private function setEnableByIndex(index:int, value:Boolean) : void { }
            private function updateTask() : void { }
            private function showFriendShineEffec(show:Boolean) : void { }
            private function showTaskShineEffect(show:Boolean) : void { }
            public function showSignShineEffect(show:Boolean) : void { }
            public function showBagShineEffect(show:Boolean) : void { }
            public function __player(event:MouseEvent) : void { }
            public function refresh() : void { }
            private function setChannelEnable(value:Boolean) : void { }
            private function setBagEnable(value:Boolean) : void { }
            private function setFriendBtnEnable(value:Boolean) : void { }
            private function setSignEnable(value:Boolean) : void { }
            public function tipTask() : void { }
            public function get goBagBtn() : BaseButton { return null; }
   }}