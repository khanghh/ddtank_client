package ddt.bagStore
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperDataModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import store.StoreController;
   
   public class BagStore extends EventDispatcher
   {
      
      public static var OPEN_BAGSTORE:String = "openBagStore";
      
      public static var CLOSE_BAGSTORE:String = "closeBagStore";
      
      public static const SHOW_BUY_FRAME:String = "showbuyframe";
      
      public static const GENERAL:String = "general";
      
      public static const CONSORTIA:String = "consortia";
      
      public static const BAG_STORE:String = "bag_store";
      
      public static const FORGE_STORE:String = "forge_store";
      
      public static const FINE_STORE:String = "fine_store";
      
      public static const GODREFINING_STORE:String = "godRefining_store";
      
      public static const OpenGrade_Store:int = 5;
      
      public static const OpenGrade_Forge:int = 10;
      
      public static const OpenGrade_FineStore:int = 15;
      
      public static const OpenGrade_Strengthen:int = 5;
      
      public static const OpenGrade_Exalt:int = 25;
      
      public static const OpenGrade_Compose:int = 5;
      
      public static const OpenGrade_Transfer:int = 10;
      
      public static const OpenGrade_Fusion:int = 5;
      
      public static const OpenGrade_Potential:int = 30;
      
      public static const OpenGrade_CastGold:int = 25;
      
      public static const OpenGrade_Affinage:int = 10;
      
      public static const OpenGrade_WarGhost:int = 30;
      
      public static const OpenGrade_AddMagic:int = 40;
      
      public static const OpenGrade_FineForge:int = 35;
      
      public static const OpenGrade_BringUp:int = 15;
      
      public static const OpenGrade_Evolution:int = 10;
      
      public static const OpenGrade_MagicStone:int = 40;
      
      public static const OpenGrade_TransferPanel:int = 10;
      
      private static var _instance:BagStore;
       
      
      private var _tipPanelNumber:int = 0;
      
      private var _passwordOpen:Boolean = true;
      
      private var _controllerInstance:StoreController;
      
      private var _storeOpenAble:Boolean = false;
      
      private var _isFromBagFrame:Boolean = false;
      
      private var _isFromShop:Boolean = false;
      
      private var _isFromConsortionBankFrame:Boolean = false;
      
      private var _isFromHomeBankFrame:Boolean = false;
      
      private var _type:String = "bag_store";
      
      private var _isInBagStoreFrame:Boolean;
      
      private var cevent:CEvent;
      
      public function BagStore(param1:IEventDispatcher = null)
      {
         super();
      }
      
      public static function get instance() : BagStore
      {
         if(_instance == null)
         {
            _instance = new BagStore();
         }
         return _instance;
      }
      
      public function openStore(param1:String = "bag_store", param2:int = 0) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(17))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.trainer.store.open"));
            return;
         }
         _type = param1;
         setupSelectIndex(param2);
         controllerInstance.Model.loadBagData();
         cevent = new CEvent("openview",{
            "control":controllerInstance,
            "type":_type
         });
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.creatItemStrengthenGoodsInfoLoader,LoaderCreate.Instance.createNewFusionDataLoader],loadUIModule);
      }
      
      private function loadUIModule() : void
      {
         AssetModuleLoader.addModelLoader("ddtstore",6);
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function setupSelectIndex(param1:int) : void
      {
         controllerInstance.selectedIndex.add("bag_store",0);
         controllerInstance.selectedIndex.add("forge_store",0);
         controllerInstance.selectedIndex.add("fine_store",0);
         controllerInstance.selectedIndex.add("godRefining_store",0);
         controllerInstance.selectedIndex.add(_type,param1);
      }
      
      private function loadComplete() : void
      {
         dispatchEvent(cevent);
         storeOpenAble = true;
      }
      
      public function set isInBagStoreFrame(param1:Boolean) : void
      {
         _isInBagStoreFrame = param1;
      }
      
      public function get isInBagStoreFrame() : Boolean
      {
         return _isInBagStoreFrame;
      }
      
      public function closed() : void
      {
         if(_isFromBagFrame)
         {
            BagAndInfoManager.Instance.showBagAndInfo();
            dispatchEvent(new Event(CLOSE_BAGSTORE));
            _isFromBagFrame = false;
         }
         if(_isFromConsortionBankFrame)
         {
            ConsortionModelManager.Instance.alertBankFrame();
            _isFromConsortionBankFrame = false;
         }
      }
      
      public function get tipPanelNumber() : int
      {
         return _tipPanelNumber;
      }
      
      public function set tipPanelNumber(param1:int) : void
      {
         _tipPanelNumber = param1;
      }
      
      public function reduceTipPanelNumber() : void
      {
         _tipPanelNumber = Number(_tipPanelNumber) - 1;
      }
      
      public function get passwordOpen() : Boolean
      {
         return _passwordOpen;
      }
      
      public function set passwordOpen(param1:Boolean) : void
      {
         _passwordOpen = param1;
      }
      
      public function set storeOpenAble(param1:Boolean) : void
      {
         _storeOpenAble = param1;
      }
      
      public function get storeOpenAble() : Boolean
      {
         return _storeOpenAble;
      }
      
      public function set isFromBagFrame(param1:Boolean) : void
      {
         _isFromBagFrame = param1;
         if(_isFromBagFrame)
         {
            BagAndInfoManager.Instance.hideBagAndInfo();
         }
      }
      
      public function get isFromBagFrame() : Boolean
      {
         return _isFromBagFrame;
      }
      
      public function set isFromConsortionBankFrame(param1:Boolean) : void
      {
         _isFromConsortionBankFrame = param1;
         if(_isFromConsortionBankFrame)
         {
            ConsortionModelManager.Instance.hideBankFrame();
         }
      }
      
      public function set isFromHomeBankFrame(param1:Boolean) : void
      {
         _isFromHomeBankFrame = param1;
      }
      
      public function set isFromShop(param1:Boolean) : void
      {
         _isFromShop = param1;
      }
      
      public function get isFromShop() : Boolean
      {
         return _isFromShop;
      }
      
      public function get controllerInstance() : StoreController
      {
         if(!_controllerInstance)
         {
            _controllerInstance = new StoreController();
         }
         return _controllerInstance;
      }
      
      public function showShortcutBuyFrame(param1:Array, param2:Boolean, param3:String, param4:int, param5:int = -1, param6:Number = 30, param7:Number = 40) : void
      {
         var _loc8_:Object = {};
         _loc8_.templateIDList = param1;
         _loc8_.showRadioBtn = param2;
         _loc8_.title = param3;
         _loc8_.panelIndex = param4;
         _loc8_.selectedIndex = param5;
         _loc8_.hSpace = param6;
         _loc8_.vSpace = param7;
         cevent = new CEvent("showbuyframe",_loc8_);
         loadUIModule();
      }
      
      public function dispose() : void
      {
         if(_controllerInstance)
         {
            ObjectUtils.disposeObject(_controllerInstance);
         }
         _controllerInstance = null;
      }
   }
}
