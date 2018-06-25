package store{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.Helpers;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import flash.geom.Point;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import store.fineStore.view.pageBringUp.FineBringUpAlertYESConfirm;   import trainer.view.NewHandContainer;      public class FineBringUpController extends EventDispatcher   {            public static const UPDATE_ITEM_LOCK_STATUS:String = "bringup_item_lock_status";            public static const UPDATE_LOCK_STATUS_LIST:String = "bringup_lock_status_list";            public static const EAT_MOUSE_STATUS_CHANGE:String = "eat_mouse_status_change";            protected static const All:String = "all";            protected static const FIRST_ONE:String = "one";            protected static const QUICK:String = "quick";            protected static const ALL_LOW:String = "all_Low";            protected static const ALL_REMAIN:String = "all_remain";            private static var instance:FineBringUpController;                   private var _hasSetedup:Boolean = false;            public var needUpdate:Boolean = false;            private var _usingLock:Boolean = false;            private var _needPlayMovie:Boolean = false;            private var _container:Sprite;            private var _eatBtnClk:Boolean = false;            private var _state:String = "";            private var _firstConfirm:Boolean = false;            private var __alertLevel:int;            private var _placeMap:Dictionary;            private var _bagBringUpInfo:BagInfo;            private var _tagItem:InventoryItemInfo;            private var _tagTempleteItem:ItemTemplateInfo;            private var _onSending:Boolean;            private var expData:ExpData;            private var _quickEatInfo:InventoryItemInfo;            public function FineBringUpController(single:inner) { super(); }
            public static function getInstance() : FineBringUpController { return null; }
            public function get usingLock() : Boolean { return false; }
            public function set usingLock(value:Boolean) : void { }
            public function get needPlayMovie() : Boolean { return false; }
            public function dispose() : void { }
            public function setup($container:Sprite) : void { }
            protected function onBringUpEatResult(e:PkgEvent) : void { }
            public function alertIsMaxLevel() : void { }
            public function havePropertiesCanNotEaten($item:InventoryItemInfo) : Boolean { return false; }
            public function alertHavePropertiesCanNotEaten() : void { }
            public function eatBtnClick($info:InventoryItemInfo, $eatenInfo:InventoryItemInfo = null) : void { }
            public function eatAllBtnClick($info:InventoryItemInfo) : void { }
            public function isMaxLevel($info:InventoryItemInfo) : Boolean { return false; }
            private function eat($state:String, $expData:ExpData = null) : void { }
            private function sendEat() : void { }
            public function buyExp($type:int, $num:int) : void { }
            private function alertLevel() : int { return 0; }
            private function checkLevel($item:ItemTemplateInfo) : int { return 0; }
            private function getExperienceList(tagItem:InventoryItemInfo, type:String) : ExpData { return null; }
            private function calculateExperience(tagItemTempleteID:int, beEatenItem:InventoryItemInfo) : Number { return 0; }
            private function getTempleteInfoByLevel(eatenLevel:int, tagItemInfo:ItemTemplateInfo) : ItemTemplateInfo { return null; }
            public function getPlaceMap() : Dictionary { return null; }
            public function getItem(itemPlace:int) : InventoryItemInfo { return null; }
            public function getCanBringUpData() : BagInfo { return null; }
            public function isTopLevel() : void { }
            public function isExpJewelry() : void { }
            public function showNewHandTip() : void { }
            public function hideNewHandTip() : void { }
            public function completeNewHandGuide() : void { }
            public function progress($info:InventoryItemInfo) : int { return 0; }
            public function expDataArr($info:ItemTemplateInfo) : Array { return null; }
            public function progressTipData($info:ItemTemplateInfo) : String { return null; }
            public function needGuide() : Boolean { return false; }
            public function get onSending() : Boolean { return false; }
   }}class inner{          function inner() { super(); }
}class ExpData{          public var totalExp:Number = 0;      public var placeArr:Array;      public var experienceArr:Array;      public var nameArr:Array;      function ExpData() { super(); }
}