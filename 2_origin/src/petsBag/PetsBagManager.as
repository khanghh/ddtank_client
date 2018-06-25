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
   import ddt.manager.ServerConfigManager;
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
      
      public var activateAlertFrameShow:Boolean = true;
      
      private var _newPetInfo:PetInfo;
      
      private var _washProItemLock:DictionaryData;
      
      public var isSelf:Boolean = true;
      
      private var _popuMsg:Array;
      
      private var _timer:Timer;
      
      public function PetsBagManager()
      {
         _popuMsg = [];
         super();
         _washProItemLock = new DictionaryData();
      }
      
      public static function instance() : PetsBagManager
      {
         if(!_instance)
         {
            _instance = new PetsBagManager();
         }
         return _instance;
      }
      
      public function set newPetInfo(value:PetInfo) : void
      {
         _newPetInfo = value;
      }
      
      public function get newPetInfo() : PetInfo
      {
         return _newPetInfo;
      }
      
      public function addPetWashProItemLock(petID:int, result:Array) : void
      {
         if(_washProItemLock == null)
         {
            _washProItemLock = new DictionaryData();
         }
         _washProItemLock.add(petID,result);
      }
      
      public function getWashProLockByPetID($pet:PetInfo) : Array
      {
         if(_washProItemLock && $pet && _washProItemLock.hasKey($pet.ID))
         {
            return _washProItemLock[$pet.ID];
         }
         return new Array(0,0,0,0,0);
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
      
      private function _eatPetsInfoHandler(e:PkgEvent) : void
      {
         var eatPetsInfo:DictionaryData = new DictionaryData();
         eatPetsInfo.add("weaponExp",e.pkg.readInt());
         eatPetsInfo.add("weaponLevel",e.pkg.readInt());
         eatPetsInfo.add("clothesExp",e.pkg.readInt());
         eatPetsInfo.add("clothesLevel",e.pkg.readInt());
         eatPetsInfo.add("hatExp",e.pkg.readInt());
         eatPetsInfo.add("hatLevel",e.pkg.readInt());
         if(petModel.eatPetsInfo.length == 0)
         {
            petModel.eatPetsLevelUp = false;
         }
         else if(eatPetsInfo.weaponLevel > petModel.eatPetsInfo.weaponLevel || eatPetsInfo.clothesLevel > petModel.eatPetsInfo.clothesLevel || eatPetsInfo.hatLevel > petModel.eatPetsInfo.hatLevel)
         {
            petModel.eatPetsLevelUp = true;
         }
         else
         {
            petModel.eatPetsLevelUp = false;
         }
         petModel.eatPetsInfo = eatPetsInfo;
      }
      
      public function petAtlasAnalyzer(analyzer:PetAtlasAnalyzer) : void
      {
         petModel.petsAtlas = analyzer.data;
      }
      
      public function updateAwakenEquipList(data:AwakenEquipInfo) : void
      {
         if(_awakenEquipList)
         {
            _awakenEquipList[data.itemID.toString()] = data;
         }
      }
      
      public function getAwakenEquipInfo(equipID:String) : AwakenEquipInfo
      {
         if(_awakenEquipList)
         {
            return _awakenEquipList[equipID];
         }
         return null;
      }
      
      public function isAwakenSkill(skillID:int) : Boolean
      {
         if(_awakenEquipList)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _awakenEquipList;
            for each(var info in _awakenEquipList)
            {
               if(info.skillId1 == skillID || info.skillId2 == skillID)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function petEquipAwakenInfoHandler(evt:PkgEvent) : void
      {
         var itemID:int = 0;
         var info:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         var len:int = pkg.readInt();
         if(_awakenEquipList == null)
         {
            _awakenEquipList = new Dictionary();
         }
         i = 0;
         while(i < len)
         {
            info = new AwakenEquipInfo();
            info.itemID = pkg.readInt();
            info.skillId1 = pkg.readInt();
            info.skillId2 = pkg.readInt();
            info.belongPetId = pkg.readInt();
            _awakenEquipList[info.itemID] = info;
            i++;
         }
      }
      
      public function curMaxBreakGrade() : int
      {
         var __curMaxBreakLevel:int = 0;
         var dd:DictionaryData = PlayerManager.Instance.Self.pets;
         var _loc5_:int = 0;
         var _loc4_:* = dd;
         for each(var pInfo in dd)
         {
            if(pInfo.breakGrade > __curMaxBreakLevel)
            {
               __curMaxBreakLevel = pInfo.breakGrade;
            }
         }
         return __curMaxBreakLevel;
      }
      
      public function onPetCellUnlockPrice(analyzer:PetsCellUnlocakPriceAnalyzer) : void
      {
         petModel.cellUnlockPrice = analyzer.getPrice();
      }
      
      protected function petCellUnLockHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         petModel.unlockedCellNum = pkg.readInt();
         dispatchEvent(new UpdatePetInfoEvent("ptm_unlock_update"));
      }
      
      protected function petBreakInfoHandler(e:PkgEvent) : void
      {
         var breakInfo:BreakInfo = new BreakInfo();
         var pkg:PackageIn = e.pkg;
         breakInfo.targetGrade = pkg.readInt();
         breakInfo.stoneNumber = pkg.readInt();
         breakInfo.breakGrade1 = pkg.readInt();
         breakInfo.star1 = pkg.readInt();
         breakInfo.breakGrade2 = pkg.readInt();
         breakInfo.star2 = pkg.readInt();
         petModel.currentPetBreakInfo = breakInfo;
         PetsAdvancedManager.Instance.dispatchEvent(new Event("change"));
      }
      
      protected function petBreakHander(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var suc:Boolean = pkg.readBoolean();
         if(suc)
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
      
      public function petBreakBtnClick(tagPet:int, useProtect:Boolean, eatPosList:Array) : void
      {
         petBreak(tagPet,useProtect,eatPosList);
      }
      
      private function petBreak(tagPet:int, useProtect:Boolean, eatPosList:Array) : void
      {
         SocketManager.Instance.out.sendPetBreak(tagPet,useProtect,eatPosList);
      }
      
      public function petBreakInfoRequire() : void
      {
         if(petModel.currentPetInfo == null)
         {
            return;
         }
         var targetGrade:int = petModel.currentPetInfo.breakGrade + 1;
         SocketManager.Instance.out.sendBreakInfoRequire(targetGrade);
      }
      
      public function onPetChange(info:PetInfo) : void
      {
         var msg:* = null;
         if(info == null)
         {
            return;
         }
         if(!PetsBagManager.instance().isSelf)
         {
            return;
         }
         if(info.IsEquip)
         {
            msg = LanguageMgr.GetTranslation("ddt.pets.bench.fighting.canotGotoBench");
            MessageTipManager.getInstance().show(msg,0,true,1.5);
         }
         else if(petModel.petBenchIsFull())
         {
            msg = LanguageMgr.GetTranslation("ddt.pets.bench.full");
            MessageTipManager.getInstance().show(msg,0,true,1.5);
         }
      }
      
      public function onBenchBagPetCellClick(btnPlace:int) : void
      {
         btnPlace = btnPlace;
         onCheckOut = function():void
         {
            SocketManager.Instance.out.sendPetCellUnlock(petModel.confirmData().isBind,times);
         };
         onConfirm = function(frame:BaseAlerFrame):void
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
      
      public function onBenchBagPetCellDoubleClick(info:PetInfo) : void
      {
         var msg:* = null;
         if(info != null)
         {
            if(petModel.petBagIsFull())
            {
               msg = LanguageMgr.GetTranslation("ddt.pets.bag.full");
               MessageTipManager.getInstance().show(msg,0,true,1.5);
            }
         }
      }
      
      protected function addPetEquipHander(event:PkgEvent) : void
      {
         var petPlace:int = 0;
         var type:int = 0;
         var tempID:int = 0;
         var startTime:* = null;
         var ValidDate:int = 0;
         var data:* = null;
         var equInfo:* = null;
         var newInfo:* = null;
         var bool:Boolean = event.pkg.readBoolean();
         if(bool)
         {
            petPlace = event.pkg.readInt();
            type = event.pkg.readInt();
            tempID = event.pkg.readInt();
            startTime = event.pkg.readDateString();
            ValidDate = event.pkg.readInt();
            data = new PetEquipData();
            data.eqTemplateID = tempID;
            data.eqType = type;
            data.startTime = startTime;
            data.ValidDate = ValidDate;
            equInfo = new InventoryItemInfo();
            equInfo.TemplateID = data.eqTemplateID;
            equInfo.ValidDate = data.ValidDate;
            equInfo.BeginDate = data.startTime;
            equInfo.IsBinds = true;
            equInfo.IsUsed = true;
            equInfo.AttackCompose = event.pkg.readInt();
            equInfo.DefendCompose = event.pkg.readInt();
            equInfo.AgilityCompose = event.pkg.readInt();
            equInfo.LuckCompose = event.pkg.readInt();
            equInfo.ItemID = event.pkg.readInt();
            equInfo.Place = data.eqType;
            newInfo = ItemManager.fill(equInfo) as InventoryItemInfo;
            if(petModel.currentPetInfo.equipList[type])
            {
               petModel.currentPetInfo.equipList[type] = newInfo;
            }
            else
            {
               petModel.currentPetInfo.equipList.add(type,newInfo);
            }
            if(_view && _view.parent && petPlace == petModel.currentPetInfo.Place)
            {
               _view.addPetEquip(newInfo);
            }
         }
      }
      
      protected function delPetEquipHander(event:PkgEvent) : void
      {
         var petInfo:* = null;
         var bool:Boolean = event.pkg.readBoolean();
         var petPlace:int = event.pkg.readInt();
         var type:int = event.pkg.readInt();
         if(bool)
         {
            var _loc8_:int = 0;
            var _loc7_:* = PlayerManager.Instance.Self.pets;
            for(var p in PlayerManager.Instance.Self.pets)
            {
               petInfo = PlayerManager.Instance.Self.pets[p] as PetInfo;
               if(petInfo.Place == petPlace && petInfo.equipList[type])
               {
                  petInfo.equipList.remove(type);
               }
            }
            if(_view && _view.parent && petPlace == petModel.currentPetInfo.Place)
            {
               _view.delPetEquip(petPlace,type);
            }
         }
      }
      
      public function get view() : PetsBagOutView
      {
         return _view;
      }
      
      public function set view(value:PetsBagOutView) : void
      {
         _view = value;
      }
      
      public function getEquipdSkillIndex() : int
      {
         return view.getUnLockItemIndex();
      }
      
      public function pushMsg(str:String) : void
      {
         _popuMsg.push(str);
         if(!_timer)
         {
            _timer = new Timer(2000);
            _timer.addEventListener("timer",__popu);
            _timer.start();
         }
      }
      
      private function __popu(e:TimerEvent) : void
      {
         var msg:String = "";
         if(_popuMsg.length > 0)
         {
            msg = _popuMsg.shift();
            MessageTipManager.getInstance().show(msg);
            ChatManager.Instance.sysChatYellow(msg);
         }
         else
         {
            _timer.stop();
            _timer.removeEventListener("timer",__popu);
            _timer = null;
            _popuMsg = [];
         }
      }
      
      public function getPicStrByLv($info:PetInfo) : String
      {
         var result:String = "";
         if($info.Level < 30)
         {
            result = $info.Pic + "/icon1";
         }
         else if(30 <= $info.Level && $info.Level < 50)
         {
            result = $info.Pic + "/icon2";
         }
         else if(50 <= $info.Level)
         {
            result = $info.Pic + "/icon3";
         }
         return result;
      }
      
      private function loadPetsGuildeUI(callBack:Function) : void
      {
         callBack = callBack;
         var __Finish:Function = function(evt:UIModuleEvent):void
         {
            if(evt.module == "farmPetTrainerUI")
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
      
      private function showLoadedArrow(currentPetFarmArrow:Object) : void
      {
         if(currentPetFarmArrow.id != 94 && currentPetFarmArrow.id != 119 && currentPetFarmArrow.id != 100)
         {
            NewHandContainer.Instance.showArrow(currentPetFarmArrow.id,currentPetFarmArrow.rotation,currentPetFarmArrow.arrowPos,currentPetFarmArrow.tip,currentPetFarmArrow.tipPos,currentPetFarmArrow.con,0,true);
         }
      }
      
      public function showPetFarmGuildArrow(id:int, rotation:int, arrowPos:String, tip:String = "", tipPos:String = "", con:DisplayObjectContainer = null, delay:int = 0) : void
      {
         if(petModel.isLoadPetTrainer)
         {
            if(petModel.preShowArrowID != 0)
            {
               if(id != petModel.nextShowArrowID)
               {
                  return;
               }
            }
            setAvailableArrow(id);
            if(id != 94)
            {
               NewHandContainer.Instance.showArrow(id,rotation,arrowPos,tip,tipPos,con,0,true);
            }
         }
         else
         {
            petModel.CurrentPetFarmGuildeArrow = {};
            petModel.CurrentPetFarmGuildeArrow.id = id;
            petModel.CurrentPetFarmGuildeArrow.rotation = rotation;
            petModel.CurrentPetFarmGuildeArrow.arrowPos = arrowPos;
            petModel.CurrentPetFarmGuildeArrow.tip = tip;
            petModel.CurrentPetFarmGuildeArrow.tipPos = tipPos;
            petModel.CurrentPetFarmGuildeArrow.con = con;
            loadPetsGuildeUI(showLoadedArrow);
         }
      }
      
      private function setAvailableArrow(arrowID:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc6_:* = petModel.petGuilde;
         for each(var items in petModel.petGuilde)
         {
            var _loc5_:int = 0;
            var _loc4_:* = items;
            for each(var item in items)
            {
               if(item.arrowID == arrowID)
               {
                  item.isFinish = true;
                  petModel.nextShowArrowID = item.NextArrowID;
                  petModel.preShowArrowID = item.PreArrowID;
                  return true;
               }
            }
         }
         return false;
      }
      
      public function clearCurrentPetFarmGuildeArrow(orderID:int) : void
      {
         NewHandContainer.Instance.clearArrowByID(orderID);
      }
      
      public function haveTaskOrderByID(taskID:int) : Boolean
      {
         var bool:Boolean = TaskManager.instance.isAvailable(TaskManager.instance.getQuestByID(taskID));
         TaskManager.instance.checkSendRequestAddQuestDic();
         return bool;
      }
      
      public function isPetFarmGuildeTask(taskID:int) : Boolean
      {
         return petModel.petGuilde[taskID];
      }
      
      public function finishTask() : void
      {
         petModel.preShowArrowID = 0;
         petModel.nextShowArrowID = 0;
      }
      
      private function __petGuildOptionChange(event:PkgEvent) : void
      {
         var pkg:* = null;
         var optionOnOff:int = 8;
         var isFlag:Boolean = true;
         if(event)
         {
            pkg = event.pkg;
            isFlag = pkg.readBoolean();
            optionOnOff = pkg.readInt();
         }
         switch(int(optionOnOff) - 8)
         {
            case 0:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            default:
               petModel.petGuildeOptionOnOff.add(117,optionOnOff);
               break;
            case 8:
               petModel.petGuildeOptionOnOff.add(118,optionOnOff);
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
      
      public function getPetQualityIndex(value:Number) : int
      {
         var i:int = 0;
         var qArr:Array = ServerConfigManager.instance.petQualityConfig;
         for(i = 0; i < qArr.length; )
         {
            if(value <= qArr[i])
            {
               return i;
            }
            i++;
         }
         return qArr.length - 1;
      }
      
      public function sendPetWashBone(place:int, hpLock:Boolean, attackLock:Boolean, defenceLock:Boolean, agilityLock:Boolean, luckLock:Boolean) : void
      {
         SocketManager.Instance.out.sendPetWashBone(place,hpLock,attackLock,defenceLock,agilityLock,luckLock);
      }
   }
}
