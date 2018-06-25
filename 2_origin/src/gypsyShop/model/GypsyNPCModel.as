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
      
      public function GypsyNPCModel(single:inner)
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
         var L1:int = 278;
         var type:String = PkgEvent.format(L1,1);
         SocketManager.Instance.addEventListener(type,onNPCStateChange);
      }
      
      protected function onNPCStateChange(e:PkgEvent) : void
      {
         var d:ByteArray = e.pkg;
         var isOpen:Boolean = d.readBoolean();
         if(isOpen)
         {
            _isStart = true;
            GypsyShopManager.getInstance().showNPC();
         }
         else
         {
            _isStart = false;
            GypsyShopManager.getInstance().hideNPC();
         }
         if(isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("gypsy.open"));
         }
         else if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("gypsy.close"));
         }
         _isOpen = isOpen;
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
         var L1:int = 278;
         var type:String = PkgEvent.format(L1,1);
         SocketManager.Instance.removeEventListener(type,onNPCStateChange);
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
