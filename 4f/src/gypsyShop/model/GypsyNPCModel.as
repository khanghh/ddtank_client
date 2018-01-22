package gypsyShop.model
{
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import gypsyShop.ctrl.GypsyShopManager;
   
   public class GypsyNPCModel extends EventDispatcher
   {
      
      private static var instance:GypsyNPCModel;
       
      
      private var _isStart:Boolean = false;
      
      private var _isOpen:Boolean = false;
      
      public function GypsyNPCModel(param1:inner){super();}
      
      public static function getInstance() : GypsyNPCModel{return null;}
      
      public function init() : void{}
      
      protected function onNPCStateChange(param1:PkgEvent) : void{}
      
      public function refreshNPCState() : void{}
      
      public function dispose() : void{}
      
      public function isStart() : Boolean{return false;}
   }
}

class inner
{
    
   
   function inner(){super();}
}
