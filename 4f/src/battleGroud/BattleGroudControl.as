package battleGroud{   import battleGroud.data.BatlleData;   import battleGroud.data.BattlPrestigeData;   import battleGroud.data.BattleUpdateData;   import battleGroud.data.BattleWeeklyAwardAnalyzer;   import battleGroud.data.PlayerBattleData;   import battleGroud.view.BattleGroudView;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.BattleGroudManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import room.RoomManager;      public class BattleGroudControl   {            private static var _instance:BattleGroudControl;                   private var _battlGroudView:BattleGroudView;            private var _moduleComplete:Boolean;            private var _battleDataList:Array;            public var orderdata:BattleUpdateData;            private var _isBattleUILoaded:Boolean;            private var _battlePresDataList:Vector.<BattlPrestigeData>;            public var playerBattleData:PlayerBattleData;            public var awardDataList:Array;            public function BattleGroudControl() { super(); }
            public static function get Instance() : BattleGroudControl { return null; }
            private function realTimeUpdataValue(e:PkgEvent) : void { }
            private function updataValue(e:PkgEvent) : void { }
            public function getBattleDataByPrestige(prestige:int) : BatlleData { return null; }
            public function getBattleDataByLevel(level:int) : BatlleData { return null; }
            public function setup() : void { }
            private function sendPkg() : void { }
            private function initEvent() : void { }
            protected function __onOpenView(event:CEvent) : void { }
            protected function playerDataUpDate(event:PkgEvent) : void { }
            private function orderData() : void { }
            private function celeTotalPrestigeData() : void { }
            public function completeHander(analyzer:BattleGroundAnalyer) : void { }
            public function completeHander2(analyzer:CeleTotalPrestigeAnalyer) : void { }
            public function getCurrBattlePresData(id:int) : BattlPrestigeData { return null; }
            private function loadeDataComplete() : void { }
            public function initBattleView() : void { }
            public function addBattleSingleRoom() : void { }
            private function __onProgress(event:UIModuleEvent) : void { }
            private function lodaDataTemplate() : void { }
            private function dataAnalyzer(e:BattleWeeklyAwardAnalyzer) : void { }
            public function show() : void { }
            public function hide() : void { }
            private function __onUIModuleComplete(evt:UIModuleEvent) : void { }
            private function __onClose(event:Event) : void { }
   }}