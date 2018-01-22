package ddtBuried.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.BuriedBox;
   import ddt.view.DiceRoll;
   import ddt.view.SimpleReturnBar;
   import ddtBuried.BuriedControl;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import ddtBuried.items.StarItem;
   import ddtBuried.map.Scence1;
   import ddtBuried.role.BuriedPlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.view.NewHandContainer;
   
   public class DiceView extends Sprite implements Disposeable
   {
       
      
      private var _back:Bitmap;
      
      private var _mapContent:Sprite;
      
      private var _downBack:Bitmap;
      
      private var _starBtn:SimpleBitmapButton;
      
      private var _starBtnTip:SimpleBitmapButton;
      
      private var _freeBtn:SimpleBitmapButton;
      
      private var _shopBtn:SimpleBitmapButton;
      
      private var _scence:Scence1;
      
      private var _diceRoll:DiceRoll;
      
      private var _txtNum:FilterFrameText;
      
      private var _starItem:StarItem;
      
      private var _isWalkOver:Boolean = false;
      
      private var _buriedBox:BuriedBox;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var role:BuriedPlayer;
      
      private var rolePosition:int;
      
      private var rolePoint:Point;
      
      private var roleNowPosition:int;
      
      private var index:uint;
      
      private var _walkArray:Array;
      
      private var _fountain1:MovieClip;
      
      private var _fountain2:MovieClip;
      
      private var cell:BagCell;
      
      private var _fileTxt:FilterFrameText;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _isRemoeEvent:Boolean;
      
      private var _isOneStep:Boolean;
      
      private var currPos:int;
      
      private var onstep:int;
      
      private var _isCount:Boolean = false;
      
      private var _taskTrackView:TaskTrackView;
      
      public function DiceView(){super();}
      
      private function initView() : void{}
      
      private function exitHandler() : void{}
      
      private function roleCallback(param1:BuriedPlayer, param2:Boolean, param3:int) : void{}
      
      public function upDataBtn() : void{}
      
      public function setTxt(param1:String, param2:Boolean) : void{}
      
      public function setCrFrame(param1:String) : void{}
      
      public function play() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function oneStepHander(param1:BuriedEvent) : void{}
      
      private function removeEventHandler(param1:BuriedEvent) : void{}
      
      private function frameEvent(param1:FrameEvent) : void{}
      
      private function boxMoiveOverHander(param1:BuriedEvent) : void{}
      
      private function starBtnstatsHander(param1:BuriedEvent) : void{}
      
      private function flyGoods() : void{}
      
      private function comp() : void{}
      
      private function walkContinueHander(param1:BuriedEvent) : void{}
      
      private function roleWalkOverHander(param1:BuriedEvent) : void{}
      
      private function mapOverHandler(param1:BuriedEvent) : void{}
      
      private function onMapOverResponse(param1:FrameEvent) : void{}
      
      private function diceOverHandler(param1:BuriedEvent) : void{}
      
      private function configRoadArray() : Array{return null;}
      
      private function roleWalkPosition(param1:int) : void{}
      
      private function rollClickHander(param1:MouseEvent) : void{}
      
      private function clickCallBack(param1:Boolean) : void{}
      
      private function payRollHander(param1:Boolean) : void{}
      
      private function openshopHander(param1:MouseEvent) : void{}
      
      private function uplevelClickHander(param1:MouseEvent) : void{}
      
      private function onUpLevelResponse(param1:FrameEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      public function clearScene() : void{}
      
      public function setStarList(param1:int) : void{}
      
      public function updataStarLevel(param1:int) : void{}
      
      public function addMaps(param1:String, param2:int, param3:int, param4:int, param5:int) : void{}
      
      public function setLimitNum(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
