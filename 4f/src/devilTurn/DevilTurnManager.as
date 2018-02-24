package devilTurn
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import devilTurn.analyze.DevilTurnBoxConvertAnalyzer;
   import devilTurn.analyze.DevilTurnGoodsItemAnalyzer;
   import devilTurn.analyze.DevilTurnPointShopAnalyzer;
   import devilTurn.analyze.DevilTurnRankRewardAnalyzer;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnBoxInfo;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.model.DevilTurnRankInfo;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   
   public class DevilTurnManager extends EventDispatcher
   {
      
      private static var _instance:DevilTurnManager;
       
      
      public var lotteryRunning:Boolean;
      
      public var activityState:int;
      
      private var _model:DevilTurnModel;
      
      public function DevilTurnManager(){super();}
      
      public static function get instance() : DevilTurnManager{return null;}
      
      public function setup() : void{}
      
      public function initEvent() : void{}
      
      public function removeEvent() : void{}
      
      private function __onUpdateBoxList(param1:PkgEvent) : void{}
      
      private function __onUpdateJackpot(param1:PkgEvent) : void{}
      
      private function __onUpdateInfo(param1:PkgEvent) : void{}
      
      private function __onUpdateRankList(param1:PkgEvent) : void{}
      
      public function show() : void{}
      
      private function onLoadComplete() : void{}
      
      public function loadGoodsItemComplete(param1:DevilTurnGoodsItemAnalyzer) : void{}
      
      public function loadBoxConvertItemComplete(param1:DevilTurnBoxConvertAnalyzer) : void{}
      
      public function loadPointsShopItemComplete(param1:DevilTurnPointShopAnalyzer) : void{}
      
      public function loadRankAwardItemComplete(param1:DevilTurnRankRewardAnalyzer) : void{}
      
      private function __onInit(param1:CrazyTankSocketEvent) : void{}
      
      private function initActivityDate() : void{}
      
      public function get model() : DevilTurnModel{return null;}
   }
}
