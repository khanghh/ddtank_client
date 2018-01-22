package ddt.manager
{
   import ddt.events.PkgEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class MaxBtnStateManager extends EventDispatcher
   {
      
      public static const MAX_BTN_STATE_CHANGE:String = "maxbtnstate_change";
      
      private static var instance:MaxBtnStateManager;
       
      
      private var _maxBtnIsPackUp:Boolean = false;
      
      public function MaxBtnStateManager()
      {
         super();
         if(instance != null)
         {
            throw "MaxStateManager is a singleton.";
         }
      }
      
      public static function getInstance() : MaxBtnStateManager
      {
         if(!instance)
         {
            instance = new MaxBtnStateManager();
         }
         return instance;
      }
      
      public function dropDown() : void
      {
         GameInSocketOut.sendMaxBtnState(false);
      }
      
      public function packUp() : void
      {
         GameInSocketOut.sendMaxBtnState(true);
      }
      
      public function requireState() : void
      {
         GameInSocketOut.sendRequireMaxBtnState();
      }
      
      protected function onSetStateHandler(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg as ByteArray;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _maxBtnIsPackUp = _loc3_;
         dispatchEvent(new Event("maxbtnstate_change"));
      }
      
      protected function onGetStateHandler(param1:PkgEvent) : void
      {
         var _loc2_:ByteArray = param1.pkg as ByteArray;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _maxBtnIsPackUp = _loc3_;
         dispatchEvent(new Event("maxbtnstate_change"));
      }
      
      public function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(538,1),onGetStateHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(538,2),onSetStateHandler);
      }
      
      public function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(538,1),onGetStateHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(538,2),onSetStateHandler);
      }
      
      public function dispose() : void
      {
         instance = null;
      }
      
      public function get maxBtnIsPackUp() : Boolean
      {
         return _maxBtnIsPackUp;
      }
   }
}
