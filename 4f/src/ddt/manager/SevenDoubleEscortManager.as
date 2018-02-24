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
      
      public function SevenDoubleEscortManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : SevenDoubleEscortManager{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:PkgEvent) : void{}
   }
}
