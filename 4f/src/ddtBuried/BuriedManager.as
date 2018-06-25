package ddtBuried{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.BagInfo;   import ddt.data.ServerConfigInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import ddtBuried.analyer.SearchGoodsPayAnalyer;   import ddtBuried.analyer.UpdateStarAnalyer;   import ddtBuried.data.MapItemData;   import ddtBuried.data.SearchGoodsData;   import ddtBuried.data.UpdateStarData;   import ddtBuried.event.BuriedEvent;   import flash.display.DisplayObject;   import flash.events.EventDispatcher;   import flash.filters.ColorMatrixFilter;   import road7th.comm.PackageIn;      public class BuriedManager extends EventDispatcher   {            private static var _instance:BuriedManager;                   public var mapdataList:Vector.<MapItemData>;            public var mapID:int;            public var level:int;            public var nowPosition:int;            private var serverConfigInfo:ServerConfigInfo;            public var payMoneyList:Vector.<SearchGoodsData>;            public var upDateStarList:Vector.<UpdateStarData>;            public var pay_count:int;            private var totol_count:int;            public var limit:int;            public var currPayLevel:int = -1;            public var takeCardPayList:Array;            public var eventPosition:int = -1;            public var takeCardLimit:int;            public var cardInitList:Array;            public var currCardIndex:int;            public var isContinue:Boolean;            public var isGetGoods:Boolean;            public var isOpenBuried:Boolean;            public var isBuriedBox:Boolean;            public var isGo:Boolean;            public var isBack:Boolean;            public var isBackToStart:Boolean;            public var isGoEnd:Boolean;            public var stoneNum:int;            private var _isOpening:Boolean;            private var cardPayinfo:ServerConfigInfo;            public var currGoodID:int;            private var _money:int;            private var _outFun:Function;            private var _timesReachEnd:int;            private var _stateRewardsGained:int;            public var _num:int;            private var _timesBuyDice:int;            public var boxNeedTimesList:Array;            public var maxTimesCanGainRewards:int;            public var isOver:Boolean;            public function BuriedManager() { super(); }
            public static function get Instance() : BuriedManager { return null; }
            public function get isOpening() : Boolean { return false; }
            public function set isOpening(bool:Boolean) : void { }
            public function setup() : void { }
            public function enter() : void { }
            private function playerEnterHander(e:PkgEvent) : void { }
            private function loadComplete() : void { }
            public function checkMoney(bool:Boolean, money:int, fun:Function = null) : Boolean { return false; }
            private function initAlertFarme() : void { }
            private function onResponseHander(e:FrameEvent) : void { }
            public function SearchGoodsTempHander(analyer:UpdateStarAnalyer) : void { }
            public function searchGoodsPayHander(analyzer:SearchGoodsPayAnalyer) : void { }
            private function initEvents() : void { }
            private function removeEventHandler(e:PkgEvent) : void { }
            private function removeOneStepHandler(e:PkgEvent) : void { }
            private function takeCardResponseHandler(e:PkgEvent) : void { }
            private function flopCardHandler(e:PkgEvent) : void { }
            private function getGoodsHandler(e:PkgEvent) : void { }
            private function playNowPositionHander(e:PkgEvent) : void { }
            public function getBuriedStoneNum() : String { return null; }
            public function setRemindRoll(bool:Boolean) : void { }
            public function getRemindRoll() : Boolean { return false; }
            public function setRemindOverCard(bool:Boolean) : void { }
            public function getRemindOverCard() : Boolean { return false; }
            public function setRemindOverBind(bool:Boolean) : void { }
            public function getRemindOverBind() : Boolean { return false; }
            public function setRemindRollBind(bool:Boolean) : void { }
            public function getRemindRollBind() : Boolean { return false; }
            public function dispose() : void { }
            public function applyGray(child:DisplayObject) : void { }
            public function reGray(child:DisplayObject) : void { }
            private function applyFilter(child:DisplayObject, matrix:Array) : void { }
            public function get timesReachEnd() : int { return 0; }
            public function get stateRewardsGained() : int { return 0; }
            public function get timesBuyDice() : int { return 0; }
            public function set stateRewardsGained(value:int) : void { }
            public function set timesReachEnd(value:int) : void { }
            public function set timesBuyDice(value:int) : void { }
            public function get num() : int { return 0; }
            public function set num(value:int) : void { }
   }}