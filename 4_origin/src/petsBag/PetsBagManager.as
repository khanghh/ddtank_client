package petsBag
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.goods.AwakenEquipInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelperBuyAlert;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import pet.data.PetEquipData;
   import pet.data.PetInfo;
   import petsBag.data.BreakInfo;
   import petsBag.data.PetAtlasAnalyzer;
   import petsBag.data.PetFarmGuildeInfo;
   import petsBag.event.UpdatePetInfoEvent;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import petsBag.petsAdvanced.PetsCellUnlocakPriceAnalyzer;
   import petsBag.view.PetsBagOutView;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import trainer.view.NewHandContainer;
   
   public class PetsBagManager extends EventDispatcher
   {
      
      private static var _instance:PetsBagManager;
      
      public static const BREAK_SUCC:String = "b_succ";
      
      public static const BREAK_FAIL:String = "b_fail";
       
      
      public var isOtherPetViewOpen:Boolean = false;
      
      public var petModel:PetBagModel;
      
      public var isEquip:Boolean = false;
      
      private var _view:PetsBagOutView;
      
      public var isShow:Boolean = false;
      
      public const P_Break_Open_Grade:int = 60;
      
      public const P_Train_Open_Grade:int = 30;
      
      public const P_Gallery_Open_Grade:int = 30;
      
      public const P_RingStar_Open_Grade:int = 30;
      
      public const P_Evolution_Open_Grade:int = 35;
      
      public const P_Form_Open_Grade:int = 40;
      
      public const P_EatPets_Open_Grade:int = 30;
      
      public const P_Awaken_Open_Grade:int = 60;
      
      private var _awakenEquipList:Dictionary;
      
      private var _newPetInfo:PetInfo;
      
      public var isSelf:Boolean = true;
      
      private var _popuMsg:Array;
      
      private var _timer:Timer;
      
      public function PetsBagManager()
      {
         _popuMsg = [];
         super();
      }
      
      public static function instance() : PetsBagManager
      {
         if(!_instance)
         {
            _instance = new PetsBagManager();
         }
         return _instance;
      }
      
      public function set newPetInfo(param1:PetInfo) : void
      {
         _newPetInfo = param1;
      }
      
      public function get newPetInfo() : PetInfo
      {
         return _newPetInfo;
      }
      
      public function setup() : void
      {
         petModel = new PetBagModel();
         _awakenEquipList = new Dictionary();
         SocketManager.Instance.addEventListener(PkgEvent.format(158),__petGuildOptionChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,21),delPetEquipHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,20),addPetEquipHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,33),_eatPetsInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,31),petBreakHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,34),petBreakInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,10),petCellUnLockHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,38),petEquipAwakenInfoHandler);
      }
      
      private function _eatPetsInfoHandler(param1:PkgEvent) : void
      {
         var _loc2_:DictionaryData = new DictionaryData();
         _loc2_.add("weaponExp",param1.pkg.readInt());
         _loc2_.add("weaponLevel",param1.pkg.readInt());
         _loc2_.add("clothesExp",param1.pkg.readInt());
         _loc2_.add("clothesLevel",param1.pkg.readInt());
         _loc2_.add("hatExp",param1.pkg.readInt());
         _loc2_.add("hatLevel",param1.pkg.readInt());
         if(petModel.eatPetsInfo.length == 0)
         {
            petModel.eatPetsLevelUp = false;
         }
         else if(_loc2_.weaponLevel > petModel.eatPetsInfo.weaponLevel || _loc2_.clothesLevel > petModel.eatPetsInfo.clothesLevel || _loc2_.hatLevel > petModel.eatPetsInfo.hatLevel)
         {
            petModel.eatPetsLevelUp = true;
         }
         else
         {
            petModel.eatPetsLevelUp = false;
         }
         petModel.eatPetsInfo = _loc2_;
      }
      
      public function petAtlasAnalyzer(param1:PetAtlasAnalyzer) : void
      {
         petModel.petsAtlas = param1.data;
      }
      
      public function updateAwakenEquipList(param1:AwakenEquipInfo) : void
      {
         if(_awakenEquipList)
         {
            _awakenEquipList[param1.itemID.toString()] = param1;
         }
      }
      
      public function getAwakenEquipInfo(param1:String) : AwakenEquipInfo
      {
         if(_awakenEquipList)
         {
            return _awakenEquipList[param1];
         }
         return null;
      }
      
      public function isAwakenSkill(param1:int) : Boolean
      {
         if(_awakenEquipList)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _awakenEquipList;
            for each(var _loc2_ in _awakenEquipList)
            {
               if(_loc2_.skillId1 == param1 || _loc2_.skillId2 == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function petEquipAwakenInfoHandler(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         if(_awakenEquipList == null)
         {
            _awakenEquipList = new Dictionary();
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new AwakenEquipInfo();
            _loc6_.itemID = _loc3_.readInt();
            _loc6_.skillId1 = _loc3_.readInt();
            _loc6_.skillId2 = _loc3_.readInt();
            _loc6_.belongPetId = _loc3_.readInt();
            _awakenEquipList[_loc6_.itemID] = _loc6_;
            _loc5_++;
         }
      }
      
      public function curMaxBreakGrade() : int
      {
         var _loc3_:int = 0;
         var _loc1_:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.breakGrade > _loc3_)
            {
               _loc3_ = _loc2_.breakGrade;
            }
         }
         return _loc3_;
      }
      
      public function onPetCellUnlockPrice(param1:PetsCellUnlocakPriceAnalyzer) : void
      {
         petModel.cellUnlockPrice = param1.getPrice();
      }
      
      protected function petCellUnLockHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         petModel.unlockedCellNum = _loc2_.readInt();
         dispatchEvent(new UpdatePetInfoEvent("ptm_unlock_update"));
      }
      
      protected function petBreakInfoHandler(param1:PkgEvent) : void
      {
         var _loc2_:BreakInfo = new BreakInfo();
         var _loc3_:PackageIn = param1.pkg;
         _loc2_.targetGrade = _loc3_.readInt();
         _loc2_.stoneNumber = _loc3_.readInt();
         _loc2_.breakGrade1 = _loc3_.readInt();
         _loc2_.star1 = _loc3_.readInt();
         _loc2_.breakGrade2 = _loc3_.readInt();
         _loc2_.star2 = _loc3_.readInt();
         petModel.currentPetBreakInfo = _loc2_;
         PetsAdvancedManager.Instance.dispatchEvent(new Event("change"));
      }
      
      protected function petBreakHander(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         if(_loc2_)
         {
            SocketManager.Instance.out.sendUpdatePetInfo(petModel.currentPetInfo.ID);
            petBreakInfoRequire();
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("ddt.pets.break.SucMessage"));
            this.dispatchEvent(new Event("b_succ"));
         }
         else
         {
            this.dispatchEvent(new Event("b_fail"));
         }
      }
      
      public function petBreakBtnClick(param1:int, param2:Boolean, param3:Array) : void
      {
         petBreak(param1,param2,param3);
      }
      
      private function petBreak(param1:int, param2:Boolean, param3:Array) : void
      {
         SocketManager.Instance.out.sendPetBreak(param1,param2,param3);
      }
      
      public function petBreakInfoRequire() : void
      {
         if(petModel.currentPetInfo == null)
         {
            return;
         }
         var _loc1_:int = petModel.currentPetInfo.breakGrade + 1;
         SocketManager.Instance.out.sendBreakInfoRequire(_loc1_);
      }
      
      public function onPetChange(param1:PetInfo) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(!PetsBagManager.instance().isSelf)
         {
            return;
         }
         if(param1.IsEquip)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.pets.bench.fighting.canotGotoBench");
            MessageTipManager.getInstance().show(_loc2_,0,true,1.5);
         }
         else if(petModel.petBenchIsFull())
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.pets.bench.full");
            MessageTipManager.getInstance().show(_loc2_,0,true,1.5);
         }
      }
      
      public function onBenchBagPetCellClick(param1:int) : void
      {
         btnPlace = param1;
         onCheckOut = function():void
         {
            SocketManager.Instance.out.sendPetCellUnlock(petModel.confirmData().isBind,times);
         };
         onConfirm = function(param1:BaseAlerFrame):void
         {
         };
         if(btnPlace >= petModel.cellMaxUnlockedPlace)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            var times:int = btnPlace - petModel.cellMaxUnlockedPlace + 1;
            var moneyNeeded:int = petModel.getMoneyNeeded(times);
            var msg1:String = LanguageMgr.GetTranslation("ddt.pets.cellUnlock",moneyNeeded,times);
            petModel.confirmData().moneyNeeded = moneyNeeded;
            HelperBuyAlert.getInstance().alert(msg1,petModel.confirmData(),null,onCheckOut,onConfirm);
         }
      }
      
      public function onBenchBagPetCellDoubleClick(param1:PetInfo) : void
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            if(petModel.petBagIsFull())
            {
               _loc2_ = LanguageMgr.GetTranslation("ddt.pets.bag.full");
               MessageTipManager.getInstance().show(_loc2_,0,true,1.5);
            }
         }
      }
      
      protected function addPetEquipHander(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc8_:Boolean = param1.pkg.readBoolean();
         if(_loc8_)
         {
            _loc4_ = param1.pkg.readInt();
            _loc9_ = param1.pkg.readInt();
            _loc10_ = param1.pkg.readInt();
            _loc3_ = param1.pkg.readDateString();
            _loc7_ = param1.pkg.readInt();
            _loc6_ = new PetEquipData();
            _loc6_.eqTemplateID = _loc10_;
            _loc6_.eqType = _loc9_;
            _loc6_.startTime = _loc3_;
            _loc6_.ValidDate = _loc7_;
            _loc5_ = new InventoryItemInfo();
            _loc5_.TemplateID = _loc6_.eqTemplateID;
            _loc5_.ValidDate = _loc6_.ValidDate;
            _loc5_.BeginDate = _loc6_.startTime;
            _loc5_.IsBinds = true;
            _loc5_.IsUsed = true;
            _loc5_.AttackCompose = param1.pkg.readInt();
            _loc5_.DefendCompose = param1.pkg.readInt();
            _loc5_.AgilityCompose = param1.pkg.readInt();
            _loc5_.LuckCompose = param1.pkg.readInt();
            _loc5_.ItemID = param1.pkg.readInt();
            _loc5_.Place = _loc6_.eqType;
            _loc2_ = ItemManager.fill(_loc5_) as InventoryItemInfo;
            if(petModel.currentPetInfo.equipList[_loc9_])
            {
               petModel.currentPetInfo.equipList[_loc9_] = _loc2_;
            }
            else
            {
               petModel.currentPetInfo.equipList.add(_loc9_,_loc2_);
            }
            if(_view && _view.parent && _loc4_ == petModel.currentPetInfo.Place)
            {
               _view.addPetEquip(_loc2_);
            }
         }
      }
      
      protected function delPetEquipHander(param1:PkgEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         if(_loc4_)
         {
            var _loc8_:int = 0;
            var _loc7_:* = PlayerManager.Instance.Self.pets;
            for(var _loc3_ in PlayerManager.Instance.Self.pets)
            {
               _loc6_ = PlayerManager.Instance.Self.pets[_loc3_] as PetInfo;
               if(_loc6_.Place == _loc2_ && _loc6_.equipList[_loc5_])
               {
                  _loc6_.equipList.remove(_loc5_);
               }
            }
            if(_view && _view.parent && _loc2_ == petModel.currentPetInfo.Place)
            {
               _view.delPetEquip(_loc2_,_loc5_);
            }
         }
      }
      
      public function get view() : PetsBagOutView
      {
         return _view;
      }
      
      public function set view(param1:PetsBagOutView) : void
      {
         _view = param1;
      }
      
      public function getEquipdSkillIndex() : int
      {
         return view.getUnLockItemIndex();
      }
      
      public function pushMsg(param1:String) : void
      {
         _popuMsg.push(param1);
         if(!_timer)
         {
            _timer = new Timer(2000);
            _timer.addEventListener("timer",__popu);
            _timer.start();
         }
      }
      
      private function __popu(param1:TimerEvent) : void
      {
         var _loc2_:String = "";
         if(_popuMsg.length > 0)
         {
            _loc2_ = _popuMsg.shift();
            MessageTipManager.getInstance().show(_loc2_);
            ChatManager.Instance.sysChatYellow(_loc2_);
         }
         else
         {
            _timer.stop();
            _timer.removeEventListener("timer",__popu);
            _timer = null;
            _popuMsg = [];
         }
      }
      
      public function getPicStrByLv(param1:PetInfo) : String
      {
         var _loc2_:String = "";
         if(param1.Level < 30)
         {
            _loc2_ = param1.Pic + "/icon1";
         }
         else if(30 <= param1.Level && param1.Level < 50)
         {
            _loc2_ = param1.Pic + "/icon2";
         }
         else if(50 <= param1.Level)
         {
            _loc2_ = param1.Pic + "/icon3";
         }
         return _loc2_;
      }
      
      private function loadPetsGuildeUI(param1:Function) : void
      {
         callBack = param1;
         var __Finish:Function = function(param1:UIModuleEvent):void
         {
            if(param1.module == "farmPetTrainerUI")
            {
               UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__Finish);
               petModel.isLoadPetTrainer = true;
               if(petModel.CurrentPetFarmGuildeArrow)
               {
                  callBack(petModel.CurrentPetFarmGuildeArrow);
               }
            }
         };
         UIModuleLoader.Instance.addUIModuleImp("farmPetTrainerUI");
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__Finish);
      }
      
      private function showLoadedArrow(param1:Object) : void
      {
         if(param1.id != 94 && param1.id != 119 && param1.id != 100)
         {
            NewHandContainer.Instance.showArrow(param1.id,param1.rotation,param1.arrowPos,param1.tip,param1.tipPos,param1.con,0,true);
         }
      }
      
      public function showPetFarmGuildArrow(param1:int, param2:int, param3:String, param4:String = "", param5:String = "", param6:DisplayObjectContainer = null, param7:int = 0) : void
      {
         if(petModel.isLoadPetTrainer)
         {
            if(petModel.preShowArrowID != 0)
            {
               if(param1 != petModel.nextShowArrowID)
               {
                  return;
               }
            }
            setAvailableArrow(param1);
            if(param1 != 94)
            {
               NewHandContainer.Instance.showArrow(param1,param2,param3,param4,param5,param6,0,true);
            }
         }
         else
         {
            petModel.CurrentPetFarmGuildeArrow = {};
            petModel.CurrentPetFarmGuildeArrow.id = param1;
            petModel.CurrentPetFarmGuildeArrow.rotation = param2;
            petModel.CurrentPetFarmGuildeArrow.arrowPos = param3;
            petModel.CurrentPetFarmGuildeArrow.tip = param4;
            petModel.CurrentPetFarmGuildeArrow.tipPos = param5;
            petModel.CurrentPetFarmGuildeArrow.con = param6;
            loadPetsGuildeUI(showLoadedArrow);
         }
      }
      
      private function setAvailableArrow(param1:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc6_:* = petModel.petGuilde;
         for each(var _loc2_ in petModel.petGuilde)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(_loc3_.arrowID == param1)
               {
                  _loc3_.isFinish = true;
                  petModel.nextShowArrowID = _loc3_.NextArrowID;
                  petModel.preShowArrowID = _loc3_.PreArrowID;
                  return true;
               }
            }
         }
         return false;
      }
      
      public function clearCurrentPetFarmGuildeArrow(param1:int) : void
      {
         NewHandContainer.Instance.clearArrowByID(param1);
      }
      
      public function haveTaskOrderByID(param1:int) : Boolean
      {
         var _loc2_:Boolean = TaskManager.instance.isAvailable(TaskManager.instance.getQuestByID(param1));
         TaskManager.instance.checkSendRequestAddQuestDic();
         return _loc2_;
      }
      
      public function isPetFarmGuildeTask(param1:int) : Boolean
      {
         return petModel.petGuilde[param1];
      }
      
      public function finishTask() : void
      {
         petModel.preShowArrowID = 0;
         petModel.nextShowArrowID = 0;
      }
      
      private function __petGuildOptionChange(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 8;
         var _loc2_:Boolean = true;
         if(param1)
         {
            _loc4_ = param1.pkg;
            _loc2_ = _loc4_.readBoolean();
            _loc3_ = _loc4_.readInt();
         }
         switch(int(_loc3_) - 8)
         {
            case 0:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,_loc3_);
               break;
            case 8:
               petModel.petGuildeOptionOnOff.add(118,_loc3_);
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatPetExpericenceAnalyzeLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createPetsRisingStarDataLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createPetsEvolutionDataLoader());
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.addModelLoader("petsBag",6);
         AssetModuleLoader.startCodeLoader(dispatchShow);
      }
      
      private function dispatchShow() : void
      {
         dispatchEvent(new UpdatePetInfoEvent("petsBagOpenView"));
      }
      
      public function hide() : void
      {
         dispatchEvent(new UpdatePetInfoEvent("petsBagHideView"));
      }
   }
}
