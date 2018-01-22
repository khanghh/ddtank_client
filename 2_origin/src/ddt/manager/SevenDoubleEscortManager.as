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
      
      public function SevenDoubleEscortManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      private function pkgHandler(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readByte();
         if(_loc2_ == 1)
         {
            _loc3_ = _loc4_.readInt();
            if(_loc4_.readBoolean())
            {
               _tag = _loc3_;
            }
            _loc4_.position = _loc4_.position - 5;
         }
         _loc4_.position = _loc4_.position - 1;
         if(_tag == 1)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("seven_double",_loc4_));
         }
         else if(_tag == 2)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("escort",_loc4_));
         }
         else if(_tag == 3)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("drgn_baot",_loc4_));
         }
         else if(_tag == 4)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("float_parade",_loc4_));
         }
         else if(_tag == 5)
         {
            SocketManager.Instance.dispatchEvent(new CrazyTankSocketEvent("ddt_king_float",_loc4_));
         }
      }
   }
}
