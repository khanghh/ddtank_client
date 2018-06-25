package giftSystem{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.data.goods.ShopItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import giftSystem.view.ClearingInterface;   import giftSystem.view.GiftFrame;      public class GiftController extends EventDispatcher   {            private static var _instance:GiftController;                   private var _giftFrame:GiftFrame;            private var _CI:ClearingInterface;            public function GiftController(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : GiftController { return null; }
            public function setup() : void { }
            private function __onOpenView(event:GiftEvent) : void { }
            private function onLoaded() : void { }
            public function hideGiftFrame() : void { }
            private function __sendStatus(event:PkgEvent) : void { }
            public function openClearingInterface(info:ShopItemInfo) : void { }
   }}