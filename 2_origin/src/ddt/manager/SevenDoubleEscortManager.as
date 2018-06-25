package ddt.manager
{
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddtKingFloat.DDTKingFloatIconManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import floatParade.FloatParadeIconManager;
   import road7th.comm.PackageIn;
   
   public class SevenDoubleEscortManager extends EventDispatcher
   {
      
      private static var _instance:SevenDoubleEscortManager;
       
      
      private var _tag:int;
      
      public function SevenDoubleEscortManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : SevenDoubleEscortManager
      {
         if(_instance == null)
         {
            _instance = new SevenDoubleEscortManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(148),pkgHandler);
         FloatParadeIconManager.instance.setup();
         DDTKingFloatIconManager.instance.setup();
      }
      
      private function pkgHandler(event:PkgEvent) : void
      {
         var tmpTag:int = 0;
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         if(cmd == 1)
         {
            tmpTag = pkg.readInt();
            if(pkg.readBoolean())
            {
               _tag = tmpTag;
            }
            pkg.position = pkg.position - 5;
         }
         pkg.position = pkg.position - 1;
         if(_tag == 1)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("seven_double",pkg));
         }
         else if(_tag == 2)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("escort",pkg));
         }
         else if(_tag == 3)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("drgn_baot",pkg));
         }
         else if(_tag == 4)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("float_parade",pkg));
         }
         else if(_tag == 5)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("ddt_king_float",pkg));
         }
      }
   }
}
