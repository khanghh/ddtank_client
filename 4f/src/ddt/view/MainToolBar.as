package ddt.view
{
   import bagAndInfo.BagAndInfoManager;
   import calendar.CalendarManager;
   import com.greensock.TweenLite;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.events.TaskEvent;
   import ddt.manager.ExitPromptManager;
   import ddt.manager.IMManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import gotopage.view.GotoPageController;
   import hall.HallStateView;
   import hall.tasktrack.HallTaskGuideManager;
   import horse.HorseManager;
   import magicStone.MagicStoneManager;
   import petsBag.PetsBagManager;
   import quest.QuestBubbleManager;
   import quest.TaskManager;
   import road7th.utils.MovieClipWrapper;
   import trainer.controller.WeakGuildManager;
   import trainer.view.NewHandContainer;
   
   public class MainToolBar extends Sprite
   {
      
      public static const ENTER_HALL:int = 0;
      
      public static const LEAVE_HALL:int = 1;
      
      private static var _instance:MainToolBar;
       
      
      private var _toolBarBg:Bitmap;
      
      private var _bgGradient:Bitmap;
      
      private var _goSupplyBtn:BaseButton;
      
      private var _goShopBtn:BaseButton;
      
      private var _goBagBtn:BaseButton;
      
      private var _goTaskBtn:BaseButton;
      
      private var _goFriendListBtn:BaseButton;
      
      private var _goSignBtn:BaseButton;
      
      private var _goChannelBtn:BaseButton;
      
      private var _goReturnBtn:BaseButton;
      
      private var _goExitBtn:BaseButton;
      
      private var _goBuriedBtn:BaseButton;
      
      private var _goPetBtn:BaseButton;
      
      private var _horseBtn:BaseButton;
      
      private var _callBackFun:Function;
      
      private var _unReadTask:Boolean;
      
      private var _enabled:Boolean;
      
      private var _unReadMovement:Boolean;
      
      private var _taskEffectEnable:Boolean;
      
      private var _signEffectEnable:Boolean = true;
      
      private var _boxContainer:HBox;
      
      private var allBtns:Array;
      
      private var _isEvent:Boolean;
      
      private var _bagTxt:Bitmap;
      
      private var _shopTxt:Bitmap;
      
      private var _jobTxt:Bitmap;
      
      private var _friendTxt:Bitmap;
      
      private var _signTxt:Bitmap;
      
      private var _otherTxt:Bitmap;
      
      private var _petTxt:Bitmap;
      
      private var _gameSetTxt:Bitmap;
      
      private var _horseTxt:Bitmap;
      
      private var _guideBtnTxtList:Array;
      
      private var _openBtnList:Array;
      
      private var _placePointList:Array;
      
      private var _lastClick:Number = 0;
      
      private var _taskShineEffect:IEffect;
      
      private var _signShineEffect:IEffect;
      
      private var _friendShineEffec:IEffect;
      
      private var _bagShineEffect:IEffect;
      
      private var _talkTimer:Timer;
      
      public function MainToolBar(){super();}
      
      public static function get Instance() : MainToolBar{return null;}
      
      override public function get width() : Number{return 0;}
      
      private function initView() : void{}
      
      public function setMoveChild(param1:int, param2:int) : void{}
      
      private function createGuideData() : void{}
      
      public function set enabled(param1:Boolean) : void{}
      
      public function enableAll() : void{}
      
      public function disableAll() : void{}
      
      private function initEvent() : void{}
      
      protected function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function taskChangeHandler(param1:TaskEvent) : void{}
      
      private function checkHorseGuide() : void{}
      
      protected function __addToStageHandler(param1:Event) : void{}
      
      protected function __noMessageHandler(param1:Event) : void{}
      
      protected function __hasNewHandler(param1:Event) : void{}
      
      private function __stopTalkTime(param1:TimerEvent) : void{}
      
      protected function __friendOverHandler(param1:MouseEvent) : void{}
      
      protected function __friendOutHandler(param1:MouseEvent) : void{}
      
      public function newBtnOpenCartoon() : Point{return null;}
      
      private function showCurLevelOpenBtn(param1:Object) : void{}
      
      public function btnOpen() : void{}
      
      private function questManuGetHandler(param1:PkgEvent) : void{}
      
      public function set backFunction(param1:Function) : void{}
      
      private function removeEvent() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      public function setRoomWaitState() : void{}
      
      public function setRoomStartState() : void{}
      
      public function setRoomStartState2(param1:Boolean) : void{}
      
      private function setSeverListStartState() : void{}
      
      public function setReturnEnable(param1:Boolean) : void{}
      
      public function setBtnStateForConsortiaDomain(param1:Boolean) : void{}
      
      public function updateReturnBtn(param1:int) : void{}
      
      public function set ExitBtnVisible(param1:Boolean) : void{}
      
      private function isBitMapAddGrayFilter(param1:Bitmap, param2:Boolean) : void{}
      
      private function dispose() : void{}
      
      private function __onReturnClick(param1:MouseEvent) : void{}
      
      private function __onExitClick(param1:MouseEvent) : void{}
      
      private function __onBuriedClick(param1:MouseEvent) : void{}
      
      private function __onPetClick(param1:MouseEvent) : void{}
      
      private function __onImClick(param1:MouseEvent) : void{}
      
      private function __onChannelClick(param1:MouseEvent) : void{}
      
      private function __onSignClick(param1:MouseEvent) : void{}
      
      private function __onHorseClick(param1:MouseEvent) : void{}
      
      public function set signEffectEnable(param1:Boolean) : void{}
      
      private function _overTaskBtn(param1:MouseEvent) : void{}
      
      private function _outTaskBtn(param1:MouseEvent) : void{}
      
      private function _showTaskTip(param1:Event) : void{}
      
      private function __onTaskClick(param1:MouseEvent) : void{}
      
      private function showTask() : void{}
      
      private function __onBagClick(param1:MouseEvent) : void{}
      
      private function __onShopClick(param1:MouseEvent) : void{}
      
      private function toShopNeedConfirm() : Boolean{return false;}
      
      private function __confirmToShopResponse(param1:FrameEvent) : void{}
      
      private function __onSupplyClick(param1:MouseEvent) : void{}
      
      public function set unReadTask(param1:Boolean) : void{}
      
      public function get unReadTask() : Boolean{return false;}
      
      public function set unReadMovement(param1:Boolean) : void{}
      
      public function get unReadMovement() : Boolean{return false;}
      
      public function showTaskHightLight() : void{}
      
      public function hideTaskHightLight() : void{}
      
      public function showmovementHightLight() : void{}
      
      public function setRoomState() : void{}
      
      public function setShopState() : void{}
      
      public function setAuctionHouseState() : void{}
      
      private function update() : void{}
      
      private function setEnableByIndex(param1:int, param2:Boolean) : void{}
      
      private function updateTask() : void{}
      
      private function showFriendShineEffec(param1:Boolean) : void{}
      
      private function showTaskShineEffect(param1:Boolean) : void{}
      
      public function showSignShineEffect(param1:Boolean) : void{}
      
      public function showBagShineEffect(param1:Boolean) : void{}
      
      public function __player(param1:MouseEvent) : void{}
      
      public function refresh() : void{}
      
      private function setChannelEnable(param1:Boolean) : void{}
      
      private function setBagEnable(param1:Boolean) : void{}
      
      private function setFriendBtnEnable(param1:Boolean) : void{}
      
      private function setSignEnable(param1:Boolean) : void{}
      
      public function tipTask() : void{}
      
      public function get goBagBtn() : BaseButton{return null;}
   }
}
