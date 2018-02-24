package boguAdventure
{
   import boguAdventure.event.BoguAdventureEvent;
   import boguAdventure.model.BoguAdventureCellInfo;
   import boguAdventure.model.BoguAdventureModel;
   import boguAdventure.player.BoguAdventurePlayer;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class BoguAdventureControl extends EventDispatcher
   {
      
      public static const SIGN_MAX_COUNT:int = 10;
       
      
      public var changeMouse:Boolean;
      
      public var currentIndex:int;
      
      private var _hp:int;
      
      public var isMove:Boolean;
      
      public var signFocus:Point;
      
      public var mineFocus:Point;
      
      public var mineNumFocus:Point;
      
      private var _bogu:BoguAdventurePlayer;
      
      private var _model:BoguAdventureModel;
      
      public function BoguAdventureControl(){super();}
      
      private function init() : void{}
      
      private function __onAllEvent(param1:CrazyTankSocketEvent) : void{}
      
      private function enterGame(param1:PackageIn) : void{}
      
      private function updateCell(param1:PackageIn) : void{}
      
      private function revive(param1:PackageIn) : void{}
      
      private function acquireAward(param1:PackageIn) : void{}
      
      public function checkGameOver() : Boolean{return false;}
      
      public function walk(param1:Array) : void{}
      
      public function walkComplete() : void{}
      
      public function playActionComplete(param1:Object = null) : void{}
      
      public function get hp() : int{return 0;}
      
      public function set hp(param1:int) : void{}
      
      public function get bogu() : BoguAdventurePlayer{return null;}
      
      public function set bogu(param1:BoguAdventurePlayer) : void{}
      
      public function get model() : BoguAdventureModel{return null;}
      
      public function checkGetAward() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
