package ddt.bagStore{   import bagAndInfo.BagAndInfoManager;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.events.CEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperDataModuleLoad;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import store.StoreController;      public class BagStore extends EventDispatcher   {            public static var OPEN_BAGSTORE:String = "openBagStore";            public static var CLOSE_BAGSTORE:String = "closeBagStore";            public static const SHOW_BUY_FRAME:String = "showbuyframe";            public static const GENERAL:String = "general";            public static const CONSORTIA:String = "consortia";            public static const BAG_STORE:String = "bag_store";            public static const FORGE_STORE:String = "forge_store";            public static const FINE_STORE:String = "fine_store";            public static const GODREFINING_STORE:String = "godRefining_store";            public static const OpenGrade_Store:int = 5;            public static const OpenGrade_Forge:int = 10;            public static const OpenGrade_FineStore:int = 15;            public static const OpenGrade_Strengthen:int = 5;            public static const OpenGrade_Exalt:int = 25;            public static const OpenGrade_Compose:int = 5;            public static const OpenGrade_Transfer:int = 10;            public static const OpenGrade_Fusion:int = 5;            public static const OpenGrade_Potential:int = 30;            public static const OpenGrade_CastGold:int = 25;            public static const OpenGrade_Affinage:int = 10;            public static const OpenGrade_WarGhost:int = 30;            public static const OpenGrade_AddMagic:int = 40;            public static const OpenGrade_FineForge:int = 35;            public static const OpenGrade_BringUp:int = 15;            public static const OpenGrade_Evolution:int = 10;            public static const OpenGrade_MagicStone:int = 40;            public static const OpenGrade_TransferPanel:int = 10;            private static var _instance:BagStore;                   private var _tipPanelNumber:int = 0;            private var _passwordOpen:Boolean = true;            private var _controllerInstance:StoreController;            private var _storeOpenAble:Boolean = false;            private var _isFromBagFrame:Boolean = false;            private var _isFromShop:Boolean = false;            private var _isFromConsortionBankFrame:Boolean = false;            private var _isFromHomeBankFrame:Boolean = false;            private var _type:String = "bag_store";            private var _isInBagStoreFrame:Boolean;            private var cevent:CEvent;            public function BagStore(target:IEventDispatcher = null) { super(); }
            public static function get instance() : BagStore { return null; }
            public function openStore(type:String = "bag_store", index:int = 0) : void { }
            private function loadUIModule() : void { }
            private function setupSelectIndex(index:int) : void { }
            private function loadComplete() : void { }
            public function set isInBagStoreFrame(value:Boolean) : void { }
            public function get isInBagStoreFrame() : Boolean { return false; }
            public function closed() : void { }
            public function get tipPanelNumber() : int { return 0; }
            public function set tipPanelNumber(value:int) : void { }
            public function reduceTipPanelNumber() : void { }
            public function get passwordOpen() : Boolean { return false; }
            public function set passwordOpen(value:Boolean) : void { }
            public function set storeOpenAble(value:Boolean) : void { }
            public function get storeOpenAble() : Boolean { return false; }
            public function set isFromBagFrame(value:Boolean) : void { }
            public function get isFromBagFrame() : Boolean { return false; }
            public function set isFromConsortionBankFrame(value:Boolean) : void { }
            public function set isFromHomeBankFrame(value:Boolean) : void { }
            public function set isFromShop(value:Boolean) : void { }
            public function get isFromShop() : Boolean { return false; }
            public function get controllerInstance() : StoreController { return null; }
            public function showShortcutBuyFrame(templateIDList:Array, showRadioBtn:Boolean, title:String, panelIndex:int, selectedIndex:int = -1, hSpace:Number = 30, vSpace:Number = 40) : void { }
            public function dispose() : void { }
   }}