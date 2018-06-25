package trainer.controller{   import bagAndInfo.BagAndInfoManager;   import bagAndInfo.cell.BagCell;   import calendar.CalendarManager;   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import consortion.ConsortionModelManager;   import consortion.guard.ConsortiaGuardControl;   import ddt.bagStore.BagStore;   import ddt.data.goods.InventoryItemInfo;   import ddt.loader.LoaderCreate;   import ddt.manager.BattleGroudManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.HelperDataModuleLoad;   import farm.FarmModelController;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import pet.sprite.PetSpriteManager;   import sevenDouble.SevenDoubleManager;   import trainer.view.SystemOpenPromptFrame;   import treasure.model.TreasureModel;   import vip.VipController;      public class SystemOpenPromptManager extends EventDispatcher   {            public static const TOTEM:int = 1;            public static const GEMSTONE:int = 2;            public static const GET_AWARD:int = 3;            public static const SIGN:int = 4;            public static const CONSORTIA_BOSS_OPEN:int = 5;            public static const TREASURE:int = 10;            public static const BATTLE_GROUND_OPEN:int = 6;            public static const FARM_CROP_RIPE:int = 7;            public static const SEVEN_DOUBLE_DUNGEON:int = 8;            public static const GET_NEW_EQUIP_TIP:int = 9;            public static const ENCHANT:int = 10;            public static const CONSORTIA_GUARD:int = 11;            public static const TARGET:int = 12;            private static var _instance:SystemOpenPromptManager;                   public var isShowNewEuipTip:Boolean;            private var _item:InventoryItemInfo;            private var _equipFrameDic:Dictionary;            private var _isLoadComplete:Boolean = false;            private var _frameList:Object;            private var _isJudge:Boolean = false;            public function SystemOpenPromptManager() { super(null); }
            public static function get instance() : SystemOpenPromptManager { return null; }
            public function loadModule() : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            public function showFrame(item:InventoryItemInfo = null, toPlace:int = 0) : void { }
            public function showEquipTipFrame(item:InventoryItemInfo) : void { }
            public function equipedNewEquip(equipCell:BagCell) : void { }
            public function gotoSystem(type:int) : void { }
            private function goSevenDoubleDungeon() : void { }
            private function showFarm() : void { }
            private function showBattleGround() : void { }
            private function showConsortiaBoss() : void { }
            private function showSign() : void { }
            private function showGetAward() : void { }
            private function showGemstone() : void { }
            private function showConsortion() : void { }
            private function showEnchant() : void { }
            private function showTotem() : void { }
            public function dispose() : void { }
            public function get isLoadComplete() : Boolean { return false; }
   }}