package giftSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import giftSystem.view.ClearingInterface;
   import giftSystem.view.GiftFrame;
   
   public class GiftController extends EventDispatcher
   {
      
      private static var _instance:GiftController;
       
      
      private var _giftFrame:GiftFrame;
      
      private var _CI:ClearingInterface;
      
      public function GiftController(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : GiftController{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:GiftEvent) : void{}
      
      private function onLoaded() : void{}
      
      public function hideGiftFrame() : void{}
      
      private function __sendStatus(param1:PkgEvent) : void{}
      
      public function openClearingInterface(param1:ShopItemInfo) : void{}
   }
}
