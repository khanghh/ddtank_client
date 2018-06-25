package devilTurn{   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import devilTurn.analyze.DevilTurnBoxConvertAnalyzer;   import devilTurn.analyze.DevilTurnGoodsItemAnalyzer;   import devilTurn.analyze.DevilTurnPointShopAnalyzer;   import devilTurn.analyze.DevilTurnRankRewardAnalyzer;   import devilTurn.event.DevilTurnEvent;   import devilTurn.model.DevilTurnBoxInfo;   import devilTurn.model.DevilTurnModel;   import devilTurn.model.DevilTurnRankInfo;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;      public class DevilTurnManager extends EventDispatcher   {            private static var _instance:DevilTurnManager;                   public var lotteryRunning:Boolean;            public var activityState:int;            private var _model:DevilTurnModel;            public function DevilTurnManager() { super(); }
            public static function get instance() : DevilTurnManager { return null; }
            public function setup() : void { }
            public function initEvent() : void { }
            public function removeEvent() : void { }
            private function __onUpdateBoxList(e:PkgEvent) : void { }
            private function __onUpdateJackpot(e:PkgEvent) : void { }
            private function __onUpdateInfo(e:PkgEvent) : void { }
            private function __onUpdateRankList(e:PkgEvent) : void { }
            public function show() : void { }
            private function onLoadComplete() : void { }
            public function loadGoodsItemComplete(value:DevilTurnGoodsItemAnalyzer) : void { }
            public function loadBoxConvertItemComplete(value:DevilTurnBoxConvertAnalyzer) : void { }
            public function loadPointsShopItemComplete(value:DevilTurnPointShopAnalyzer) : void { }
            public function loadRankAwardItemComplete(value:DevilTurnRankRewardAnalyzer) : void { }
            private function __onInit(e:CrazyTankSocketEvent) : void { }
            private function initActivityDate() : void { }
            public function get model() : DevilTurnModel { return null; }
   }}