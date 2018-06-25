package petsBag{   import baglocked.BaglockedManager;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.goods.AwakenEquipInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.ChatManager;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelperBuyAlert;   import flash.display.DisplayObjectContainer;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.TimerEvent;   import flash.utils.Dictionary;   import flash.utils.Timer;   import pet.data.PetEquipData;   import pet.data.PetInfo;   import petsBag.data.BreakInfo;   import petsBag.data.PetAtlasAnalyzer;   import petsBag.data.PetFarmGuildeInfo;   import petsBag.event.UpdatePetInfoEvent;   import petsBag.petsAdvanced.PetsAdvancedManager;   import petsBag.petsAdvanced.PetsCellUnlocakPriceAnalyzer;   import petsBag.view.PetsBagOutView;   import quest.TaskManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import trainer.view.NewHandContainer;      public class PetsBagManager extends EventDispatcher   {            private static var _instance:PetsBagManager;            public static const BREAK_SUCC:String = "b_succ";            public static const BREAK_FAIL:String = "b_fail";                   public var isOtherPetViewOpen:Boolean = false;            public var petModel:PetBagModel;            public var isEquip:Boolean = false;            private var _view:PetsBagOutView;            public var isShow:Boolean = false;            public const P_Break_Open_Grade:int = 60;            public const P_Train_Open_Grade:int = 30;            public const P_Gallery_Open_Grade:int = 30;            public const P_RingStar_Open_Grade:int = 30;            public const P_Evolution_Open_Grade:int = 35;            public const P_Form_Open_Grade:int = 40;            public const P_EatPets_Open_Grade:int = 30;            public const P_Awaken_Open_Grade:int = 60;            private var _awakenEquipList:Dictionary;            public var activateAlertFrameShow:Boolean = true;            private var _newPetInfo:PetInfo;            private var _washProItemLock:DictionaryData;            public var isSelf:Boolean = true;            private var _popuMsg:Array;            private var _timer:Timer;            public function PetsBagManager() { super(); }
            public static function instance() : PetsBagManager { return null; }
            public function set newPetInfo(value:PetInfo) : void { }
            public function get newPetInfo() : PetInfo { return null; }
            public function addPetWashProItemLock(petID:int, result:Array) : void { }
            public function getWashProLockByPetID($pet:PetInfo) : Array { return null; }
            public function setup() : void { }
            private function _eatPetsInfoHandler(e:PkgEvent) : void { }
            public function petAtlasAnalyzer(analyzer:PetAtlasAnalyzer) : void { }
            public function updateAwakenEquipList(data:AwakenEquipInfo) : void { }
            public function getAwakenEquipInfo(equipID:String) : AwakenEquipInfo { return null; }
            public function isAwakenSkill(skillID:int) : Boolean { return false; }
            public function petEquipAwakenInfoHandler(evt:PkgEvent) : void { }
            public function curMaxBreakGrade() : int { return 0; }
            public function onPetCellUnlockPrice(analyzer:PetsCellUnlocakPriceAnalyzer) : void { }
            protected function petCellUnLockHandler(e:PkgEvent) : void { }
            protected function petBreakInfoHandler(e:PkgEvent) : void { }
            protected function petBreakHander(e:PkgEvent) : void { }
            public function petBreakBtnClick(tagPet:int, useProtect:Boolean, eatPosList:Array) : void { }
            private function petBreak(tagPet:int, useProtect:Boolean, eatPosList:Array) : void { }
            public function petBreakInfoRequire() : void { }
            public function onPetChange(info:PetInfo) : void { }
            public function onBenchBagPetCellClick(btnPlace:int) : void { }
            public function onBenchBagPetCellDoubleClick(info:PetInfo) : void { }
            protected function addPetEquipHander(event:PkgEvent) : void { }
            protected function delPetEquipHander(event:PkgEvent) : void { }
            public function get view() : PetsBagOutView { return null; }
            public function set view(value:PetsBagOutView) : void { }
            public function getEquipdSkillIndex() : int { return 0; }
            public function pushMsg(str:String) : void { }
            private function __popu(e:TimerEvent) : void { }
            public function getPicStrByLv($info:PetInfo) : String { return null; }
            private function loadPetsGuildeUI(callBack:Function) : void { }
            private function showLoadedArrow(currentPetFarmArrow:Object) : void { }
            public function showPetFarmGuildArrow(id:int, rotation:int, arrowPos:String, tip:String = "", tipPos:String = "", con:DisplayObjectContainer = null, delay:int = 0) : void { }
            private function setAvailableArrow(arrowID:int) : Boolean { return false; }
            public function clearCurrentPetFarmGuildeArrow(orderID:int) : void { }
            public function haveTaskOrderByID(taskID:int) : Boolean { return false; }
            public function isPetFarmGuildeTask(taskID:int) : Boolean { return false; }
            public function finishTask() : void { }
            private function __petGuildOptionChange(event:PkgEvent) : void { }
            public function show() : void { }
            private function dispatchShow() : void { }
            public function hide() : void { }
            public function getPetQualityIndex(value:Number) : int { return 0; }
            public function sendPetWashBone(place:int, hpLock:Boolean, attackLock:Boolean, defenceLock:Boolean, agilityLock:Boolean, luckLock:Boolean) : void { }
   }}