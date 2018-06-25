package boguAdventure
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class BoguAdventureManager
   {
      
      private static var _this:BoguAdventureManager;
       
      
      private var _isOpen:Boolean;
      
      public function BoguAdventureManager()
      {
         super();
      }
      
      public static function get instance() : BoguAdventureManager
      {
         if(_this == null)
         {
            _this = new BoguAdventureManager();
         }
         return _this;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("boguadventure",__onActivityState);
      }
      
      private function __onActivityState(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         if(e._cmd == 89)
         {
            _isOpen = pkg.readBoolean();
            checkOpen();
         }
      }
      
      public function checkOpen() : void
      {
         if(_isOpen)
         {
            if(PlayerManager.Instance.Self.Grade >= 10)
            {
               HallIconManager.instance.updateSwitchHandler("boguadventure",true);
            }
            else
            {
               HallIconManager.instance.executeCacheRightIconLevelLimit("boguadventure",true,10);
            }
         }
         else
         {
            HallIconManager.instance.updateSwitchHandler("boguadventure",false);
            HallIconManager.instance.executeCacheRightIconLevelLimit("boguadventure",false);
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
   }
}
