package chickActivation.model{   import chickActivation.data.ChickActivationInfo;   import chickActivation.event.ChickActivationEvent;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.TimeManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;      public class ChickActivationModel extends EventDispatcher   {                   public var isOpen:Boolean = true;            private var _itemInfoList:Array;            public var qualityDic:Dictionary;            public var isKeyOpened:int;            public var keyIndex:int;            public var keyOpenedTime:Date;            public var keyOpenedType:int;            public var gainArr:Array;            public function ChickActivationModel(target:IEventDispatcher = null) { super(null); }
            public function getInventoryItemInfo(info:ChickActivationInfo) : InventoryItemInfo { return null; }
            public function findQualityValue(qualityKey:String) : int { return 0; }
            public function getRemainingDay() : int { return 0; }
            public function getGainLevel(level:int) : Boolean { return false; }
            public function get itemInfoList() : Array { return null; }
            public function set itemInfoList(value:Array) : void { }
            public function dataChange(_eventType:String, _resultData:Object = null) : void { }
   }}