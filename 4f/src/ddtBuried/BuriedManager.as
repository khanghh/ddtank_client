package ddtBuried
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.BagInfo;
   import ddt.data.ServerConfigInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddtBuried.analyer.SearchGoodsPayAnalyer;
   import ddtBuried.analyer.UpdateStarAnalyer;
   import ddtBuried.data.MapItemData;
   import ddtBuried.data.SearchGoodsData;
   import ddtBuried.data.UpdateStarData;
   import ddtBuried.event.BuriedEvent;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.filters.ColorMatrixFilter;
   import road7th.comm.PackageIn;
   
   public class BuriedManager extends EventDispatcher
   {
      
      private static var _instance:BuriedManager;
       
      
      public var mapdataList:Vector.<MapItemData>;
      
      public var mapID:int;
      
      public var level:int;
      
      public var nowPosition:int;
      
      private var serverConfigInfo:ServerConfigInfo;
      
      public var payMoneyList:Vector.<SearchGoodsData>;
      
      public var upDateStarList:Vector.<UpdateStarData>;
      
      public var pay_count:int;
      
      private var totol_count:int;
      
      public var limit:int;
      
      public var currPayLevel:int = -1;
      
      public var takeCardPayList:Array;
      
      public var eventPosition:int = -1;
      
      public var takeCardLimit:int;
      
      public var cardInitList:Array;
      
      public var currCardIndex:int;
      
      public var isContinue:Boolean;
      
      public var isGetGoods:Boolean;
      
      public var isOpenBuried:Boolean;
      
      public var isBuriedBox:Boolean;
      
      public var isGo:Boolean;
      
      public var isBack:Boolean;
      
      public var isBackToStart:Boolean;
      
      public var isGoEnd:Boolean;
      
      public var stoneNum:int;
      
      private var _isOpening:Boolean;
      
      private var cardPayinfo:ServerConfigInfo;
      
      public var currGoodID:int;
      
      private var _money:int;
      
      private var _outFun:Function;
      
      private var _timesReachEnd:int;
      
      private var _stateRewardsGained:int;
      
      public var _num:int;
      
      private var _timesBuyDice:int;
      
      public var boxNeedTimesList:Array;
      
      public var maxTimesCanGainRewards:int;
      
      public var isOver:Boolean;
      
      public function BuriedManager(){super();}
      
      public static function get Instance() : BuriedManager{return null;}
      
      public function get isOpening() : Boolean{return false;}
      
      public function set isOpening(param1:Boolean) : void{}
      
      public function setup() : void{}
      
      public function enter() : void{}
      
      private function playerEnterHander(param1:PkgEvent) : void{}
      
      private function loadComplete() : void{}
      
      public function checkMoney(param1:Boolean, param2:int, param3:Function = null) : Boolean{return false;}
      
      private function initAlertFarme() : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      public function SearchGoodsTempHander(param1:UpdateStarAnalyer) : void{}
      
      public function searchGoodsPayHander(param1:SearchGoodsPayAnalyer) : void{}
      
      private function initEvents() : void{}
      
      private function removeEventHandler(param1:PkgEvent) : void{}
      
      private function removeOneStepHandler(param1:PkgEvent) : void{}
      
      private function takeCardResponseHandler(param1:PkgEvent) : void{}
      
      private function flopCardHandler(param1:PkgEvent) : void{}
      
      private function getGoodsHandler(param1:PkgEvent) : void{}
      
      private function playNowPositionHander(param1:PkgEvent) : void{}
      
      public function getBuriedStoneNum() : String{return null;}
      
      public function setRemindRoll(param1:Boolean) : void{}
      
      public function getRemindRoll() : Boolean{return false;}
      
      public function setRemindOverCard(param1:Boolean) : void{}
      
      public function getRemindOverCard() : Boolean{return false;}
      
      public function setRemindOverBind(param1:Boolean) : void{}
      
      public function getRemindOverBind() : Boolean{return false;}
      
      public function setRemindRollBind(param1:Boolean) : void{}
      
      public function getRemindRollBind() : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function applyGray(param1:DisplayObject) : void{}
      
      public function reGray(param1:DisplayObject) : void{}
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void{}
      
      public function get timesReachEnd() : int{return 0;}
      
      public function get stateRewardsGained() : int{return 0;}
      
      public function get timesBuyDice() : int{return 0;}
      
      public function set stateRewardsGained(param1:int) : void{}
      
      public function set timesReachEnd(param1:int) : void{}
      
      public function set timesBuyDice(param1:int) : void{}
      
      public function get num() : int{return 0;}
      
      public function set num(param1:int) : void{}
   }
}
