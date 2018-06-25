package gypsyShop.ctrl{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import gypsyShop.GypsyShopEvent;   import gypsyShop.model.GypsyShopModel;   import gypsyShop.npcBehavior.IGypsyNPCBehavior;   import gypsyShop.ui.ConfirmFrameHonourNeeded;   import gypsyShop.ui.ConfirmFrameMoneyNeeded;   import gypsyShop.view.GypsyShopMainFrame;   import gypsyShop.view.GypsyUILoader;   import magicStone.components.MagicStoneConfirmView;      public class GypsyShopController   {            private static var instance:GypsyShopController;                   private var _mainFrameGypsy:GypsyShopMainFrame;            private var _npcBehavior:IGypsyNPCBehavior;            private var _modelShop:GypsyShopModel;            private var _manager:GypsyShopManager;            public function GypsyShopController(single:inner) { super(); }
            public static function getInstance() : GypsyShopController { return null; }
            public function setup() : void { }
            private function addEvents() : void { }
            protected function onEventHandler(e:GypsyShopEvent) : void { }
            public function showMainFrame() : void { }
            private function onLoaded() : void { }
            public function hideMainFrame() : void { }
            public function newRareItemsUpdate() : void { }
            public function newItemListUpdate() : void { }
            public function updateBuyResult() : void { }
            private function moneyNeeded(id:int) : void { }
            private function honourNeeded() : void { }
            private function rmbNeeded() : void { }
            private function comfirmHandler(event:FrameEvent) : void { }
            private function reConfirmHandler(evt:FrameEvent) : void { }
            public function dispose() : void { }
   }}class inner{          function inner() { super(); }
}