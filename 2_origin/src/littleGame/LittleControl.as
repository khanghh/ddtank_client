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
      
      public function LittleControl()
      {
         super();
      }
      
      public static function get Instance() : LittleControl
      {
         return _ins || new LittleControl();
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(80),__actived);
      }
      
      private function __actived(param1:PkgEvent) : void
      {
         _actived = param1.pkg.readBoolean();
         dispatchEvent(new LittleGameEvent("activedChanged"));
      }
      
      public function hasActive() : Boolean
      {
         return _actived;
      }
      
      public function hasCanStart(param1:PlayerInfo) : Boolean
      {
         return param1.Grade >= PathManager.LittleGameMinLv;
      }
   }
}
