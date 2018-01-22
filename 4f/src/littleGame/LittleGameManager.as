package littleGame
{
   import ddt.data.player.PlayerInfo;
   import ddt.ddt_internal;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.DisplayObjectContainer;
   import flash.events.EventDispatcher;
   import littleGame.actions.LittleAction;
   import littleGame.actions.LittleLivingDieAction;
   import littleGame.actions.LittleLivingMoveAction;
   import littleGame.actions.LittleSelfMoveAction;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.interfaces.ILittleObject;
   import littleGame.model.LittleLiving;
   import littleGame.model.LittlePlayer;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import littleGame.object.BoguGiveUp;
   import littleGame.object.NormalBoguInhaled;
   import littleGame.view.GameScene;
   import road7th.comm.PackageIn;
   import road7th.comm.PackageOut;
   
   use namespace ddt_internal;
   
   [Event(name="activedChanged",type="littleGame.events.LittleGameEvent")]
   public class LittleGameManager extends EventDispatcher
   {
      
      public static const Player:int = 1;
      
      public static const Living:int = 2;
      
      public static const GameBackLayer:int = 0;
      
      public static const GameForeLayer:int = 1;
      
      private static var _ins:LittleGameManager;
       
      
      public var soundEnabled:Boolean = true;
      
      private var _current:Scenario;
      
      private var _mainStage:DisplayObjectContainer;
      
      private var _gamescene:GameScene;
      
      public function LittleGameManager(){super();}
      
      public static function get Instance() : LittleGameManager{return null;}
      
      public function kickPlayer(param1:PackageIn) : void{}
      
      public function fillPath(param1:LittleLiving, param2:Grid, param3:int, param4:int, param5:int, param6:int) : Array{return null;}
      
      public function collide(param1:LittleSelf, param2:LittleLiving) : Boolean{return false;}
      
      public function enterWorld() : void{}
      
      public function enterGame(param1:Scenario, param2:PackageIn) : void{}
      
      public function addObject(param1:Scenario, param2:String, param3:PackageIn = null) : ILittleObject{return null;}
      
      public function removeObject(param1:Scenario, param2:PackageIn) : ILittleObject{return null;}
      
      public function invokeObject(param1:Scenario, param2:PackageIn) : ILittleObject{return null;}
      
      public function addLiving(param1:Scenario, param2:PackageIn) : LittleLiving{return null;}
      
      public function removeLiving(param1:Scenario, param2:PackageIn) : LittleLiving{return null;}
      
      public function livingDie(param1:Scenario, param2:LittleLiving, param3:int = 6) : void{}
      
      private function readLivingFromPacket(param1:PackageIn, param2:Scenario = null) : LittleLiving{return null;}
      
      private function setLivingSize(param1:LittleLiving, param2:String) : void{}
      
      public function updatePos(param1:Scenario, param2:PackageIn) : void{}
      
      public function livingMove(param1:Scenario, param2:PackageIn) : LittleLiving{return null;}
      
      public function selfMoveTo(param1:Scenario, param2:LittleSelf, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Array) : void{}
      
      public function inhaled(param1:LittleSelf) : void{}
      
      public function updateLivingProperty(param1:Scenario, param2:PackageIn) : void{}
      
      public function doAction(param1:Scenario, param2:PackageIn) : LittleAction{return null;}
      
      public function doMovie(param1:Scenario, param2:PackageIn) : void{}
      
      public function setClock(param1:Scenario, param2:PackageIn) : void{}
      
      public function pong(param1:Scenario, param2:PackageIn) : void{}
      
      public function ping(param1:int) : void{}
      
      public function setNetDelay(param1:Scenario, param2:PackageIn) : void{}
      
      public function getScore(param1:Scenario, param2:PackageIn) : void{}
      
      public function livingClick(param1:Scenario, param2:LittleLiving, param3:int, param4:int) : void{}
      
      public function cancelInhaled(param1:int) : void{}
      
      public function synchronousLivingPos(param1:int, param2:int) : void{}
      
      public function loadComplete() : void{}
      
      public function createGame(param1:PackageIn) : Scenario{return null;}
      
      public function leave() : void{}
      
      public function get Current() : Scenario{return null;}
      
      public function sendScore(param1:int, param2:int) : void{}
      
      private function createPackageOut() : PackageOut{return null;}
      
      public function sendPackage(param1:PackageOut) : void{}
      
      public function setMainStage(param1:DisplayObjectContainer) : void{}
      
      public function setGameScene(param1:GameScene) : void{}
      
      public function get gameScene() : GameScene{return null;}
      
      public function get mainStage() : DisplayObjectContainer{return null;}
   }
}
