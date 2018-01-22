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
      
      public function set puzzleState(param1:Boolean) : void
      {
         _puzzleState = param1;
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
      
      private function __initDataHandler(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         _manaualModel.clear();
         _manaualModel.beginChanges();
         _manaualModel.manualLev = _loc2_.readInt();
         _manaualModel.progress = _loc2_.readInt();
         _manaualModel.maxProgress = _loc2_.readInt();
         _manaualModel.havePage = _loc2_.readInt();
         _manaualModel.conditionCount = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Agile = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Armor = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Attack = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Damage = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Defense = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_HP = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Lucky = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_MagicAttack = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_MagicResistance = _loc2_.readInt();
         _manaualModel.pageAllPro.pro_Stamina = _loc2_.readInt();
         var _loc4_:int = _loc2_.readInt();
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.push(_loc2_.readInt());
            _loc5_++;
         }
         _manaualModel.activePageID = _loc3_;
         updatePlayerManualPro();
         _manaualModel.upgradeCondition.conditions = ExplorerManualManager.instance.getupgradeConditionByLev(_manaualModel.manualLev);
         _manaualModel.refreshData();
         _manaualModel.commitChanges();
      }
      
      private function updatePlayerManualPro() : void
      {
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         _loc1_.manualProInfo.manual_Level = _manaualModel.manualLev;
         _loc1_.manualProInfo.pro_Agile = _manaualModel.pageAllPro.pro_Agile;
         _loc1_.manualProInfo.pro_Armor = _manaualModel.pageAllPro.pro_Armor;
         _loc1_.manualProInfo.pro_Attack = _manaualModel.pageAllPro.pro_Attack;
         _loc1_.manualProInfo.pro_Damage = _manaualModel.pageAllPro.pro_Damage;
         _loc1_.manualProInfo.pro_Defense = _manaualModel.pageAllPro.pro_Defense;
         _loc1_.manualProInfo.pro_HP = _manaualModel.pageAllPro.pro_HP;
         _loc1_.manualProInfo.pro_Lucky = _manaualModel.pageAllPro.pro_Lucky;
         _loc1_.manualProInfo.pro_MagicAttack = _manaualModel.pageAllPro.pro_MagicAttack;
         _loc1_.manualProInfo.pro_MagicResistance = _manaualModel.pageAllPro.pro_MagicResistance;
         _loc1_.manualProInfo.pro_Stamina = _manaualModel.pageAllPro.pro_Stamina;
      }
      
      private function __openViewHandler(param1:Event) : void
      {
         evt = param1;
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
      
      private function __upgradeHandler(param1:PkgEvent) : void
      {
         var _loc5_:* = null;
         var _loc8_:PackageIn = param1.pkg;
         var _loc10_:Boolean = _loc8_.readBoolean();
         var _loc3_:Boolean = _loc8_.readBoolean();
         var _loc4_:Boolean = _loc8_.readBoolean();
         var _loc9_:int = _loc8_.readInt();
         var _loc2_:int = _loc8_.readInt();
         var _loc7_:int = _manaualModel.progress;
         var _loc6_:* = _loc2_;
         if(_manaualModel)
         {
            if(_manaualModel.manualLev != _loc9_)
            {
               if(!_loc10_)
               {
                  _loc5_ = LanguageMgr.GetTranslation("explorerManual.upgrade.succeed");
               }
               else
               {
                  _loc5_ = LanguageMgr.GetTranslation("explorerManual.upgrade.complete");
               }
               requestInitData();
               this.dispatchEvent(new Event("upgradeComplete"));
            }
            else
            {
               if(!_loc10_)
               {
                  _loc5_ = LanguageMgr.GetTranslation(!!_loc4_?"explorerManual.upgrade.critPrompt":"explorerManual.upgrade.prompt",_loc2_ - _loc7_);
               }
               else
               {
                  _loc5_ = LanguageMgr.GetTranslation("explorerManual.upgrade.complete");
               }
               _manaualModel.beginChanges();
               _manaualModel.progress = _loc2_;
               _manaualModel.commitChanges();
            }
         }
         MessageTipManager.getInstance().show(_loc5_);
      }
      
      private function __pageUpdateHandler(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc6_:ManualPageDebrisInfo = new ManualPageDebrisInfo();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc8_ = new DebrisInfo();
            _loc8_.debrisID = _loc3_.readInt();
            _loc8_.date = _loc3_.readDate();
            _loc6_.debris.push(_loc8_);
            _loc7_++;
         }
         _manaualModel.beginChanges();
         _manaualModel.debrisInfo = _loc6_;
         _manaualModel.commitChanges();
      }
      
      private function __pageActiveHandler(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         var _loc5_:int = _loc4_.readInt();
         if(_loc5_ == 1)
         {
            _loc3_ = !!_loc2_?"explorerManual.active.succeesMsg":"explorerManual.active.failMsg";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(_loc3_));
            if(_loc2_)
            {
               requestInitData();
            }
         }
         else if(_loc5_ == 2)
         {
            _loc3_ = !!_loc2_?"explorerManual.akeyMuzzle.succeesMsg":"explorerManual.akeyMuzzle.failMsg";
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(_loc3_));
            this.dispatchEvent(new CEvent("akeyMuzzleComplete",_loc2_));
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
      
      public function startUpgrade(param1:Boolean, param2:Boolean) : void
      {
         upgrade(param1,param2);
      }
      
      public function autoUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         upgrade(param1,param2,param3);
      }
      
      private function upgrade(param1:Boolean, param2:Boolean, param3:Boolean = false) : void
      {
         ExplorerManualManager.instance.startUpgrade(param1,param2,param3);
      }
      
      public function requestManualPageData(param1:int) : void
      {
         ExplorerManualManager.instance.requestManualPageData(param1);
      }
      
      public function switchChapterView(param1:int) : void
      {
         if(_frame)
         {
            _frame.openPageView(param1);
         }
      }
      
      public function sendManualPageActive(param1:int, param2:int) : void
      {
         ExplorerManualManager.instance.sendManualPageActive(param1,param2);
      }
      
      private function requestInitData() : void
      {
         ExplorerManualManager.instance.requestInitData();
      }
      
      public function get autoUpgradeing() : Boolean
      {
         return _autoUpgradeing;
      }
      
      public function set autoUpgradeing(param1:Boolean) : void
      {
         _autoUpgradeing = param1;
      }
   }
}
