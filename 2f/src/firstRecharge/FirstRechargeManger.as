package firstRecharge{   import com.pickgliss.events.UIModuleEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.SocketManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.view.UIModuleSmallLoading;   import firstRecharge.analyer.RechargeAnalyer;   import firstRecharge.data.RechargeData;   import firstRecharge.event.FirstRechageEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;   import wonderfulActivity.WonderfulActivityManager;      public class FirstRechargeManger extends EventDispatcher   {            private static var _instance:FirstRechargeManger;            public static const REMOVEFIRSTRECHARGEICON:String = "removefirstrechargeicon";            public static const ADDFIRSTRECHARGEICON:String = "addfirstrechargeicon";                   private var _isOpen:Boolean;            private var callback:Function;            private var _isOver:Boolean;            private var startTime:Date;            private var endTime:Date;            public var openFun:Function;            public var endFun:Function;            private var _goodsList:Vector.<RechargeData>;            public var _goodsList_haiwai:Vector.<RechargeData>;            public var rechargeMoneyTotal:int;            public var rechargeGiftBagValue:int;            public var rechargeEndTime:String;            private var _isopen:Boolean = false;            public function FirstRechargeManger() { super(); }
            public static function get Instance() : FirstRechargeManger { return null; }
            public function setup() : void { }
            public function completeHander(analyzer:RechargeAnalyer) : void { }
            public function getGoodsList() : Vector.<RechargeData> { return null; }
            public function getGoodsList_haiwai() : Vector.<RechargeData> { return null; }
            private function initEvent() : void { }
            public function get isopen() : Boolean { return false; }
            public function set ShowIcon(value:Function) : void { }
            private function __firstRechargeOpen(e:CrazyTankSocketEvent) : void { }
            protected function getSpree(event:CrazyTankSocketEvent) : void { }
            protected function cumlatechargeOpen(event:CrazyTankSocketEvent) : void { }
            private function loadRewardComplete() : void { }
            protected function cumlatechargeOver(event:CrazyTankSocketEvent) : void { }
            public function show() : void { }
            private function gemstoneProgress(pEvent:UIModuleEvent) : void { }
            public function get isOpen() : Boolean { return false; }
   }}