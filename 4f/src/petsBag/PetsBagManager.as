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
      
      public function PetsBagManager(){super();}
      
      public static function instance() : PetsBagManager{return null;}
      
      public function set newPetInfo(param1:PetInfo) : void{}
      
      public function get newPetInfo() : PetInfo{return null;}
      
      public function setup() : void{}
      
      private function _eatPetsInfoHandler(param1:PkgEvent) : void{}
      
      public function petAtlasAnalyzer(param1:PetAtlasAnalyzer) : void{}
      
      public function updateAwakenEquipList(param1:AwakenEquipInfo) : void{}
      
      public function getAwakenEquipInfo(param1:String) : AwakenEquipInfo{return null;}
      
      public function isAwakenSkill(param1:int) : Boolean{return false;}
      
      public function petEquipAwakenInfoHandler(param1:PkgEvent) : void{}
      
      public function curMaxBreakGrade() : int{return 0;}
      
      public function onPetCellUnlockPrice(param1:PetsCellUnlocakPriceAnalyzer) : void{}
      
      protected function petCellUnLockHandler(param1:PkgEvent) : void{}
      
      protected function petBreakInfoHandler(param1:PkgEvent) : void{}
      
      protected function petBreakHander(param1:PkgEvent) : void{}
      
      public function petBreakBtnClick(param1:int, param2:Boolean, param3:Array) : void{}
      
      private function petBreak(param1:int, param2:Boolean, param3:Array) : void{}
      
      public function petBreakInfoRequire() : void{}
      
      public function onPetChange(param1:PetInfo) : void{}
      
      public function onBenchBagPetCellClick(param1:int) : void{}
      
      public function onBenchBagPetCellDoubleClick(param1:PetInfo) : void{}
      
      protected function addPetEquipHander(param1:PkgEvent) : void{}
      
      protected function delPetEquipHander(param1:PkgEvent) : void{}
      
      public function get view() : PetsBagOutView{return null;}
      
      public function set view(param1:PetsBagOutView) : void{}
      
      public function getEquipdSkillIndex() : int{return 0;}
      
      public function pushMsg(param1:String) : void{}
      
      private function __popu(param1:TimerEvent) : void{}
      
      public function getPicStrByLv(param1:PetInfo) : String{return null;}
      
      private function loadPetsGuildeUI(param1:Function) : void{}
      
      private function showLoadedArrow(param1:Object) : void{}
      
      public function showPetFarmGuildArrow(param1:int, param2:int, param3:String, param4:String = "", param5:String = "", param6:DisplayObjectContainer = null, param7:int = 0) : void{}
      
      private function setAvailableArrow(param1:int) : Boolean{return false;}
      
      public function clearCurrentPetFarmGuildeArrow(param1:int) : void{}
      
      public function haveTaskOrderByID(param1:int) : Boolean{return false;}
      
      public function isPetFarmGuildeTask(param1:int) : Boolean{return false;}
      
      public function finishTask() : void{}
      
      private function __petGuildOptionChange(param1:PkgEvent) : void{}
      
      public function show() : void{}
      
      private function dispatchShow() : void{}
      
      public function hide() : void{}
   }
}
