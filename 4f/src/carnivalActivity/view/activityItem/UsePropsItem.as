package carnivalActivity.view.activityItem{   import bagAndInfo.cell.BagCell;   import carnivalActivity.CarnivalActivityControl;   import carnivalActivity.view.CarnivalActivityItem;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import ddt.utils.PositionUtils;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.data.GiftConditionInfo;   import wonderfulActivity.data.PlayerCurInfo;      public class UsePropsItem extends CarnivalActivityItem   {                   protected var _propId:int;            protected var _useCount:int;            protected var _propCell:BagCell;            public function UsePropsItem(type:int, info:GiftBagInfo, index:int) { super(null,null,null); }
            override protected function initData() : void { }
            override protected function initView() : void { }
            override protected function initItem() : void { }
            protected function createProp() : BagCell { return null; }
            override public function updateView() : void { }
            override public function dispose() : void { }
   }}