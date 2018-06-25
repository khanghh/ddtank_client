package littleGame{   import ddt.data.player.PlayerInfo;   import ddt.ddt_internal;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import flash.display.DisplayObjectContainer;   import flash.events.EventDispatcher;   import littleGame.actions.LittleAction;   import littleGame.actions.LittleLivingDieAction;   import littleGame.actions.LittleLivingMoveAction;   import littleGame.actions.LittleSelfMoveAction;   import littleGame.data.Grid;   import littleGame.data.Node;   import littleGame.interfaces.ILittleObject;   import littleGame.model.LittleLiving;   import littleGame.model.LittlePlayer;   import littleGame.model.LittleSelf;   import littleGame.model.Scenario;   import littleGame.object.BoguGiveUp;   import littleGame.object.NormalBoguInhaled;   import littleGame.view.GameScene;   import road7th.comm.PackageIn;   import road7th.comm.PackageOut;      use namespace ddt_internal;      [Event(name="activedChanged",type="littleGame.events.LittleGameEvent")]   public class LittleGameManager extends EventDispatcher   {            public static const Player:int = 1;            public static const Living:int = 2;            public static const GameBackLayer:int = 0;            public static const GameForeLayer:int = 1;            private static var _ins:LittleGameManager;                   public var soundEnabled:Boolean = true;            private var _current:Scenario;            private var _mainStage:DisplayObjectContainer;            private var _gamescene:GameScene;            public function LittleGameManager() { super(); }
            public static function get Instance() : LittleGameManager { return null; }
            public function kickPlayer(pkg:PackageIn) : void { }
            public function fillPath(living:LittleLiving, grid:Grid, startX:int, startY:int, endX:int, endY:int) : Array { return null; }
            public function collide(self:LittleSelf, target:LittleLiving) : Boolean { return false; }
            public function enterWorld() : void { }
            public function enterGame(scene:Scenario, pkg:PackageIn) : void { }
            public function addObject(scene:Scenario, type:String, pkg:PackageIn = null) : ILittleObject { return null; }
            public function removeObject(scene:Scenario, pkg:PackageIn) : ILittleObject { return null; }
            public function invokeObject(scene:Scenario, pkg:PackageIn) : ILittleObject { return null; }
            public function addLiving(scene:Scenario, pkg:PackageIn) : LittleLiving { return null; }
            public function removeLiving(scene:Scenario, pkg:PackageIn) : LittleLiving { return null; }
            public function livingDie(scene:Scenario, living:LittleLiving, lifetime:int = 6) : void { }
            private function readLivingFromPacket(pkg:PackageIn, scene:Scenario = null) : LittleLiving { return null; }
            private function setLivingSize(living:LittleLiving, modelID:String) : void { }
            public function updatePos(scene:Scenario, pkg:PackageIn) : void { }
            public function livingMove(scene:Scenario, pkg:PackageIn) : LittleLiving { return null; }
            public function selfMoveTo(scene:Scenario, self:LittleSelf, x:int, y:int, dx:int, dy:int, clock:int, path:Array) : void { }
            public function inhaled(self:LittleSelf) : void { }
            public function updateLivingProperty(scene:Scenario, pkg:PackageIn) : void { }
            public function doAction(scene:Scenario, pkg:PackageIn) : LittleAction { return null; }
            public function doMovie(scene:Scenario, pkg:PackageIn) : void { }
            public function setClock(scene:Scenario, pkg:PackageIn) : void { }
            public function pong(scene:Scenario, pkg:PackageIn) : void { }
            public function ping(timestamp:int) : void { }
            public function setNetDelay(scene:Scenario, pkg:PackageIn) : void { }
            public function getScore(scene:Scenario, pkg:PackageIn) : void { }
            public function livingClick(scene:Scenario, living:LittleLiving, x:int, y:int) : void { }
            public function cancelInhaled(id:int) : void { }
            public function synchronousLivingPos(x:int, y:int) : void { }
            public function loadComplete() : void { }
            public function createGame(pkg:PackageIn) : Scenario { return null; }
            public function leave() : void { }
            public function get Current() : Scenario { return null; }
            public function sendScore(score:int, id:int) : void { }
            private function createPackageOut() : PackageOut { return null; }
            public function sendPackage(pkg:PackageOut) : void { }
            public function setMainStage(val:DisplayObjectContainer) : void { }
            public function setGameScene(val:GameScene) : void { }
            public function get gameScene() : GameScene { return null; }
            public function get mainStage() : DisplayObjectContainer { return null; }
   }}