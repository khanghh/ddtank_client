package petsBag.petsAdvanced{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.DragManager;   import ddt.manager.SocketManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;      public class PetsAwakenEquipCell extends BaseCell   {            public static const DATA_CHANGE:String = "dataChange";                   private var _drag:Sprite;            private var _place:int = 0;            private var _isReceiveDrag:Boolean = false;            private var _isSendToHideBag:Boolean = false;            private var _itemInfo:InventoryItemInfo;            private var _type:int = 3;            protected var _tbxCount:FilterFrameText;            public function PetsAwakenEquipCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null); }
            public function get type() : int { return 0; }
            public function set type(value:int) : void { }
            private function drawDrag() : void { }
            public function setCount(num:*) : void { }
            public function setBgVisible(boo:Boolean) : void { }
            public function getCount() : int { return 0; }
            public function setCountPos(x:int, y:int) : void { }
            public function refreshTbxPos() : void { }
            public function setCountNotVisible() : void { }
            public function updateCount() : void { }
            public function set bgVisible(value:Boolean) : void { }
            public function set isReceiveDrag(value:Boolean) : void { }
            public function get isReceiveDrag() : Boolean { return false; }
            public function set isSendToHideBag(value:Boolean) : void { }
            public function get isSendToHideBag() : Boolean { return false; }
            override public function dragStart() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            public function get itemInfo() : InventoryItemInfo { return null; }
            public function set itemInfo(value:InventoryItemInfo) : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            override public function dispose() : void { }
   }}