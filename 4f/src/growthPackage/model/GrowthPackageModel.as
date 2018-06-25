package growthPackage.model{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import growthPackage.data.GrowthPackageInfo;   import growthPackage.event.GrowthPackageEvent;      public class GrowthPackageModel extends EventDispatcher   {                   private var _isBuy:int;            private var _buyPrice:Number;            private var _itemInfoList:Array;            private var _isCompleteList:Array;            private var _gradeList:Array;            public function GrowthPackageModel(target:IEventDispatcher = null) { super(null); }
            public function getInventoryItemInfo(info:GrowthPackageInfo) : InventoryItemInfo { return null; }
            public function dataChange(_eventType:String, _resultData:Object = null) : void { }
            public function get buyPrice() : Number { return 0; }
            public function set buyPrice(value:Number) : void { }
            public function get itemInfoList() : Array { return null; }
            public function set itemInfoList(value:Array) : void { }
            public function get isCompleteList() : Array { return null; }
            public function set isCompleteList(value:Array) : void { }
            public function get isShowIcon() : Boolean { return false; }
            public function get gradeList() : Array { return null; }
            public function set gradeList(value:Array) : void { }
            public function get isBuy() : int { return 0; }
            public function set isBuy(value:int) : void { }
   }}