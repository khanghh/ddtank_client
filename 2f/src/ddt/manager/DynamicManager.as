package ddt.manager
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.action.FrameShowAction;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.view.SNSFrame;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   
   public class DynamicManager
   {
      
      private static var _ins:DynamicManager;
       
      
      public function DynamicManager(){super();}
      
      public static function get Instance() : DynamicManager{return null;}
      
      public function initialize() : void{}
      
      private function __getDynamic(param1:PkgEvent) : void{}
      
      public function __sendDynamic(param1:CrazyTankSocketEvent) : void{}
      
      public function __semdWeiBo(param1:CrazyTankSocketEvent) : void{}
      
      public function sinaCallBack() : void{}
   }
}
