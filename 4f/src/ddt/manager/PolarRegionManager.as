package ddt.manager
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import flash.events.IEventDispatcher;
   import flash.utils.getTimer;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class PolarRegionManager extends CoreManager
   {
      
      private static var _instance:PolarRegionManager;
       
      
      public var ShowFlag:Boolean;
      
      private var _last_creat:uint;
      
      public var isOpen:Boolean;
      
      private var _hall:HallStateView;
      
      public function PolarRegionManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : PolarRegionManager{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenIcon(param1:PkgEvent) : void{}
      
      override protected function start() : void{}
   }
}
