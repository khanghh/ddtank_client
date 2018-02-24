package battleGroud
{
   import battleGroud.data.BatlleData;
   import battleGroud.data.BattlPrestigeData;
   import battleGroud.data.BattleUpdateData;
   import battleGroud.data.BattleWeeklyAwardAnalyzer;
   import battleGroud.data.PlayerBattleData;
   import battleGroud.view.BattleGroudView;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import room.RoomManager;
   
   public class BattleGroudControl
   {
      
      private static var _instance:BattleGroudControl;
       
      
      private var _battlGroudView:BattleGroudView;
      
      private var _moduleComplete:Boolean;
      
      private var _battleDataList:Array;
      
      public var orderdata:BattleUpdateData;
      
      private var _isBattleUILoaded:Boolean;
      
      private var _battlePresDataList:Vector.<BattlPrestigeData>;
      
      public var playerBattleData:PlayerBattleData;
      
      public var awardDataList:Array;
      
      public function BattleGroudControl(){super();}
      
      public static function get Instance() : BattleGroudControl{return null;}
      
      private function realTimeUpdataValue(param1:PkgEvent) : void{}
      
      private function updataValue(param1:PkgEvent) : void{}
      
      public function getBattleDataByPrestige(param1:int) : BatlleData{return null;}
      
      public function getBattleDataByLevel(param1:int) : BatlleData{return null;}
      
      public function setup() : void{}
      
      private function sendPkg() : void{}
      
      private function initEvent() : void{}
      
      protected function __onOpenView(param1:CEvent) : void{}
      
      protected function playerDataUpDate(param1:PkgEvent) : void{}
      
      private function orderData() : void{}
      
      private function celeTotalPrestigeData() : void{}
      
      public function completeHander(param1:BattleGroundAnalyer) : void{}
      
      public function completeHander2(param1:CeleTotalPrestigeAnalyer) : void{}
      
      public function getCurrBattlePresData(param1:int) : BattlPrestigeData{return null;}
      
      private function loadeDataComplete() : void{}
      
      public function initBattleView() : void{}
      
      public function addBattleSingleRoom() : void{}
      
      private function __onProgress(param1:UIModuleEvent) : void{}
      
      private function lodaDataTemplate() : void{}
      
      private function dataAnalyzer(param1:BattleWeeklyAwardAnalyzer) : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      private function __onUIModuleComplete(param1:UIModuleEvent) : void{}
      
      private function __onClose(param1:Event) : void{}
   }
}
