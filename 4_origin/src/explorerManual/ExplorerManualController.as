package explorerManual
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperDataModuleLoad;
   import ddt.utils.HelperUIModuleLoad;
   import explorerManual.data.DebrisInfo;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.ManualPageDebrisInfo;
   import explorerManual.view.ExplorerManualFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class ExplorerManualController extends EventDispatcher
   {
      
      private static var _instance:ExplorerManualController;
       
      
      private var _frame:ExplorerManualFrame = null;
      
      private var _manaualModel:ExplorerManualInfo;
      
      private var _autoUpgradeing:Boolean = false;
      
      private var _puzzleState:Boolean = false;
      
      public function ExplorerManualController()
      {
         super();
      }
      
      public static function get instance() : ExplorerManualController
      {
         if(!_instance)
         {
            _instance = new ExplorerManualController();
         }
         return _instance;
      }
      
      public function get puzzleState() : Boolean
      {
         return _puzzleState;
      }
      
      public function set puzzleState(value:Boolean) : void
      {
         _puzzleState = value;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      private function addEvent() : void
      {
         ExplorerManualManager.instance.addEventListener("openView",__openViewHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(377,1),__initDataHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(377,4),__upgradeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(377,2),__pageUpdateHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(377,3),__pageActiveHandler);
      }
      
      private function __initDataHandler(evt:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         _manaualModel.clear();
         _manaualModel.beginChanges();
         _manaualModel.manualLev = pkg.readInt();
         _manaualModel.progress = pkg.readInt();
         _manaualModel.maxProgress = pkg.readInt();
         _manaualModel.havePage = pkg.readInt();
         _manaualModel.conditionCount = pkg.readInt();
         _manaualModel.pageAllPro.pro_Agile = pkg.readInt();
         _manaualModel.pageAllPro.pro_Armor = pkg.readInt();
         _manaualModel.pageAllPro.pro_Attack = pkg.readInt();
         _manaualModel.pageAllPro.pro_Damage = pkg.readInt();
         _manaualModel.pageAllPro.pro_Defense = pkg.readInt();
         _manaualModel.pageAllPro.pro_HP = pkg.readInt();
         _manaualModel.pageAllPro.pro_Lucky = pkg.readInt();
         _manaualModel.pageAllPro.pro_MagicAttack = pkg.readInt();
         _manaualModel.pageAllPro.pro_MagicResistance = pkg.readInt();
         _manaualModel.pageAllPro.pro_Stamina = pkg.readInt();
         var len:int = pkg.readInt();
         var pageIDList:Array = [];
         for(i = 0; i < len; )
         {
            pageIDList.push(pkg.readInt());
            i++;
         }
         _manaualModel.activePageID = pageIDList;
         updatePlayerManualPro();
         _manaualModel.upgradeCondition.conditions = ExplorerManualManager.instance.getupgradeConditionByLev(_manaualModel.manualLev);
         _manaualModel.refreshData();
         _manaualModel.commitChanges();
      }
      
      private function updatePlayerManualPro() : void
      {
         var selft:SelfInfo = PlayerManager.Instance.Self;
         selft.manualProInfo.manual_Level = _manaualModel.manualLev;
         selft.manualProInfo.pro_Agile = _manaualModel.pageAllPro.pro_Agile;
         selft.manualProInfo.pro_Armor = _manaualModel.pageAllPro.pro_Armor;
         selft.manualProInfo.pro_Attack = _manaualModel.pageAllPro.pro_Attack;
         selft.manualProInfo.pro_Damage = _manaualModel.pageAllPro.pro_Damage;
         selft.manualProInfo.pro_Defense = _manaualModel.pageAllPro.pro_Defense;
         selft.manualProInfo.pro_HP = _manaualModel.pageAllPro.pro_HP;
         selft.manualProInfo.pro_Lucky = _manaualModel.pageAllPro.pro_Lucky;
         selft.manualProInfo.pro_MagicAttack = _manaualModel.pageAllPro.pro_MagicAttack;
         selft.manualProInfo.pro_MagicResistance = _manaualModel.pageAllPro.pro_MagicResistance;
         selft.manualProInfo.pro_Stamina = _manaualModel.pageAllPro.pro_Stamina;
      }
      
      private function __openViewHandler(evt:Event) : void
      {
         evt = evt;
         if(ExplorerManualManager.instance.isInitData)
         {
            loadUIModule();
         }
         else
         {
            new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createManaualDebrisData,LoaderCreate.Instance.createChapterItemData,LoaderCreate.Instance.createManualUpgradeData,LoaderCreate.Instance.createPageItemData],function():*
            {
               var /*UnknownSlot*/:* = function():void
               {
                  ExplorerManualManager.instance.isInitData = true;
                  loadUIModule();
               };
               return function():void
               {
                  ExplorerManualManager.instance.isInitData = true;
                  loadUIModule();
               };
            }());
         }
         puzzleState = false;
      }
      
      private function __upgradeHandler(evt:PkgEvent) : void
      {
         var str:* = null;
         var pkg:PackageIn = evt.pkg;
         var type:Boolean = pkg.readBoolean();
         var result:Boolean = pkg.readBoolean();
         var isCrit:Boolean = pkg.readBoolean();
         var manualLev:int = pkg.readInt();
         var progress:int = pkg.readInt();
         var cur:int = _manaualModel.progress;
         var next:* = progress;
         if(_manaualModel)
         {
            if(_manaualModel.manualLev != manualLev)
            {
               if(!type)
               {
                  str = LanguageMgr.GetTranslation("explorerManual.upgrade.succeed");
               }
               else
               {
                  str = LanguageMgr.GetTranslation("explorerManual.upgrade.complete");
               }
               requestInitData();
               this.dispatchEvent(new Event("upgradeComplete"));
            }
            else
            {
               if(!type)
               {
                  str = LanguageMgr.GetTranslation(!!isCrit?"explorerManual.upgrade.critPrompt":"explorerManual.upgrade.prompt",progress - cur);
               }
               else
               {
                  str = LanguageMgr.GetTranslation("explorerManual.upgrade.complete");
               }
               _manaualModel.beginChanges();
               _manaualModel.progress = progress;
               _manaualModel.commitChanges();
            }
         }
         MessageTipManager.getInstance().show(str);
      }
      
      private function __pageUpdateHandler(evt:PkgEvent) : void
      {
         var piecesID:int = 0;
         var getDate:* = null;
         var info:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         var len:int = pkg.readInt();
         var deInfo:ManualPageDebrisInfo = new ManualPageDebrisInfo();
         for(i = 0; i < len; )
         {
            info = new DebrisInfo();
            info.debrisID = pkg.readInt();
            info.date = pkg.readDate();
            deInfo.debris.push(info);
            i++;
         }
         _manaualModel.beginChanges();
         _manaualModel.debrisInfo = deInfo;
         _manaualModel.commitChanges();
      }
      
      private function __pageActiveHandler(evt:PkgEvent) : void
      {
         var str:* = null;
         var pkg:PackageIn = evt.pkg;
         var result:Boolean = pkg.readBoolean();
         var type:int = pkg.readInt();
         if(type == 1)
         {
            str = !!result?"explorerManual.active.succeesMsg":"explorerManual.active.failMsg";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(str));
            if(result)
            {
               requestInitData();
            }
         }
         else if(type == 2)
         {
            str = !!result?"explorerManual.akeyMuzzle.succeesMsg":"explorerManual.akeyMuzzle.failMsg";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(str));
            this.dispatchEvent(new CEvent("akeyMuzzleComplete",result));
         }
      }
      
      private function loadUIModule() : void
      {
         new HelperUIModuleLoad().loadUIModule(["explorerManual"],function():void
         {
            openView();
         });
      }
      
      private function openView() : void
      {
         if(_frame)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
         _manaualModel = new ExplorerManualInfo();
         _frame = ComponentFactory.Instance.creat("explorerManual.explorerManual.Frame",[_manaualModel,this]);
         if(_frame)
         {
            _frame.show();
            requestInitData();
         }
      }
      
      public function startUpgrade(autoBuy:Boolean, bindMoney:Boolean) : void
      {
         upgrade(autoBuy,bindMoney);
      }
      
      public function autoUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void
      {
         upgrade(autoBuy,bindMoney,autoUpgrade);
      }
      
      private function upgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean = false) : void
      {
         ExplorerManualManager.instance.startUpgrade(autoBuy,bindMoney,autoUpgrade);
      }
      
      public function requestManualPageData(chapterID:int) : void
      {
         ExplorerManualManager.instance.requestManualPageData(chapterID);
      }
      
      public function switchChapterView(chapterID:int) : void
      {
         if(_frame)
         {
            _frame.openPageView(chapterID);
         }
      }
      
      public function sendManualPageActive(activeType:int, pageID:int) : void
      {
         ExplorerManualManager.instance.sendManualPageActive(activeType,pageID);
      }
      
      private function requestInitData() : void
      {
         ExplorerManualManager.instance.requestInitData();
      }
      
      public function get autoUpgradeing() : Boolean
      {
         return _autoUpgradeing;
      }
      
      public function set autoUpgradeing(value:Boolean) : void
      {
         _autoUpgradeing = value;
      }
   }
}
