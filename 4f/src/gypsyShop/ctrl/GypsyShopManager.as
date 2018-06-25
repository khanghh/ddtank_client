package gypsyShop.ctrl{   import AvatarCollection.AvatarCollectionManager;   import AvatarCollection.data.AvatarCollectionItemVo;   import AvatarCollection.data.AvatarCollectionUnitVo;   import baglocked.BaglockedManager;   import ddt.CoreManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperDataModuleLoad;   import gypsyShop.GypsyShopEvent;   import gypsyShop.model.GypsyNPCModel;   import gypsyShop.model.GypsyPurchaseModel;   import gypsyShop.model.GypsyShopModel;   import gypsyShop.npcBehavior.GypsyNPCAdapter;   import gypsyShop.npcBehavior.GypsyNPCBhvr;   import gypsyShop.npcBehavior.IGypsyNPCBehavior;   import hall.HallStateView;   import road7th.data.DictionaryData;      public class GypsyShopManager extends CoreManager   {            private static var instance:GypsyShopManager;                   public var showRmbRefreshAlertAgain:Boolean = true;            private var _npcBehavior:IGypsyNPCBehavior;            private var _modelShop:GypsyShopModel;            private var _gypsyShopFrameIsShowing:Boolean;            public function GypsyShopManager(single:inner) { super(); }
            public static function getInstance() : GypsyShopManager { return null; }
            public function init($hall:HallStateView) : void { }
            public function setup() : void { }
            override protected function start() : void { }
            public function showMainFrame() : void { }
            private function showGypsyShopFrame() : void { }
            public function isAvatarActivated(templeteID:int) : Boolean { return false; }
            public function hideMainFrame() : void { }
            public function refreshNPC() : void { }
            public function showNPC() : void { }
            public function hideNPC() : void { }
            public function disposeNPC() : void { }
            public function newRareItemsUpdate() : void { }
            public function newItemListUpdate() : void { }
            public function updateBuyResult() : void { }
            public function itemBuyBtnClicked(id:int) : void { }
            public function confirmToBuy(id:int) : void { }
            public function refreshBtnClicked() : void { }
            public function confirmToRefresh() : void { }
            public function refreshWithRmbBtnClicked() : void { }
            public function confirmToRefreshWithRMB() : void { }
            public function dispose() : void { }
            public function set npcBehavior(value:IGypsyNPCBehavior) : void { }
            public function get npcBehavior() : IGypsyNPCBehavior { return null; }
            public function get gypsyShopFrameIsShowing() : Boolean { return false; }
   }}class inner{          function inner() { super(); }
}