package playerDress
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import playerDress.event.PlayerDressEvent;
   import playerDress.views.DressBagView;
   import playerDress.views.PlayerDressView;
   
   public class PlayerDressControl
   {
      
      private static var _instance:PlayerDressControl;
       
      
      private var _dressView:PlayerDressView;
      
      private var _dressBag:DressBagView;
      
      public var showBind:Boolean = true;
      
      private var _uiLoader:HelperUIModuleLoad;
      
      public function PlayerDressControl()
      {
         super();
      }
      
      public static function get instance() : PlayerDressControl
      {
         if(!_instance)
         {
            _instance = new PlayerDressControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PlayerDressManager.instance.addEventListener("playerDressOpen",__playerDressViewOpen);
         PlayerDressManager.instance.addEventListener("playerDressDispose",__playerDressViewDispose);
         PlayerDressManager.instance.addEventListener("setBtnStatus",__setBtnStatus);
         SocketManager.Instance.addEventListener(PkgEvent.format(237,7),unlockDressBag);
      }
      
      protected function __setBtnStatus(event:PlayerDressEvent) : void
      {
         if(_dressView)
         {
            _dressView.setBtnsStatus();
         }
      }
      
      protected function __playerDressViewDispose(event:PlayerDressEvent) : void
      {
         var _loc2_:* = event.info;
         if(0 !== _loc2_)
         {
            if(1 === _loc2_)
            {
               _dressBag = null;
            }
         }
         else
         {
            _dressView = null;
         }
      }
      
      protected function __playerDressViewOpen(event:PlayerDressEvent) : void
      {
         _uiLoader = new HelperUIModuleLoad();
         _uiLoader.loadUIModule(["playerDress"],openPlayerDressView,[event.info]);
      }
      
      protected function openPlayerDressView(type:int) : void
      {
         var event:* = null;
         _uiLoader = null;
         switch(int(type))
         {
            case 0:
               if(!_dressView)
               {
                  _dressView = ComponentFactory.Instance.creatCustomObject("playerDress.playerDressView");
               }
               event = new PlayerDressEvent("dressViewComplete");
               event.info = _dressView;
               PlayerDressManager.instance.dispatchEvent(event);
               break;
            case 1:
               if(!_dressBag)
               {
                  _dressBag = ComponentFactory.Instance.creatCustomObject("playerDress.dressBagView");
               }
               event = new PlayerDressEvent("bagViewComplete");
               event.info = _dressBag;
               PlayerDressManager.instance.dispatchEvent(event);
         }
      }
      
      protected function unlockDressBag(event:PkgEvent) : void
      {
         if(_dressBag)
         {
            _dressBag.baglist.unlockBag();
         }
      }
      
      public function lockDressBag() : void
      {
         if(_dressBag)
         {
            _dressBag.baglist.locked = true;
         }
      }
      
      public function putOnDress(item:InventoryItemInfo) : void
      {
         _dressView.putOnDress(item);
      }
      
      public function get dressView() : PlayerDressView
      {
         return _dressView;
      }
   }
}
