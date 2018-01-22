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
      
      public function GypsyNPCModel(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : GypsyNPCModel
      {
         if(!instance)
         {
            instance = new GypsyNPCModel(new inner());
         }
         return instance;
      }
      
      public function init() : void
      {
         var _loc1_:int = 278;
         var _loc2_:String = PkgEvent.format(_loc1_,1);
         SocketManager.Instance.addEventListener(_loc2_,onNPCStateChange);
      }
      
      protected function onNPCStateChange(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         if(_loc3_)
         {
            _isStart = true;
            GypsyShopManager.getInstance().showNPC();
         }
         else
         {
            _isStart = false;
            GypsyShopManager.getInstance().hideNPC();
         }
         if(_loc3_)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("gypsy.open"));
         }
         else if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("gypsy.close"));
         }
         _isOpen = _loc3_;
      }
      
      public function refreshNPCState() : void
      {
         if(_isOpen)
         {
            _isStart = true;
            GypsyShopManager.getInstance().showNPC();
         }
         else
         {
            _isStart = false;
            GypsyShopManager.getInstance().hideNPC();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 278;
         var _loc2_:String = PkgEvent.format(_loc1_,1);
         SocketManager.Instance.removeEventListener(_loc2_,onNPCStateChange);
      }
      
      public function isStart() : Boolean
      {
         return _isStart;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
