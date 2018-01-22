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
      
      protected function __setBtnStatus(param1:PlayerDressEvent) : void
      {
         if(_dressView)
         {
            _dressView.setBtnsStatus();
         }
      }
      
      protected function __playerDressViewDispose(param1:PlayerDressEvent) : void
      {
         var _loc2_:* = param1.info;
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
      
      protected function __playerDressViewOpen(param1:PlayerDressEvent) : void
      {
         _uiLoader = new HelperUIModuleLoad();
         _uiLoader.loadUIModule(["playerDress"],openPlayerDressView,[param1.info]);
      }
      
      protected function openPlayerDressView(param1:int) : void
      {
         var _loc2_:* = null;
         _uiLoader = null;
         switch(int(param1))
         {
            case 0:
               if(!_dressView)
               {
                  _dressView = ComponentFactory.Instance.creatCustomObject("playerDress.playerDressView");
               }
               _loc2_ = new PlayerDressEvent("dressViewComplete");
               _loc2_.info = _dressView;
               PlayerDressManager.instance.dispatchEvent(_loc2_);
               break;
            case 1:
               if(!_dressBag)
               {
                  _dressBag = ComponentFactory.Instance.creatCustomObject("playerDress.dressBagView");
               }
               _loc2_ = new PlayerDressEvent("bagViewComplete");
               _loc2_.info = _dressBag;
               PlayerDressManager.instance.dispatchEvent(_loc2_);
         }
      }
      
      protected function unlockDressBag(param1:PkgEvent) : void
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
      
      public function putOnDress(param1:InventoryItemInfo) : void
      {
         _dressView.putOnDress(param1);
      }
      
      public function get dressView() : PlayerDressView
      {
         return _dressView;
      }
   }
}
