package littleGame
{
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import littleGame.events.LittleGameEvent;
   
   public class LittleControl extends EventDispatcher
   {
      
      private static var _ins:LittleControl;
       
      
      private var _actived:Boolean = false;
      
      public function LittleControl(){super();}
      
      public static function get Instance() : LittleControl{return null;}
      
      public function setup() : void{}
      
      private function __actived(param1:PkgEvent) : void{}
      
      public function hasActive() : Boolean{return false;}
      
      public function hasCanStart(param1:PlayerInfo) : Boolean{return false;}
   }
}
