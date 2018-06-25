package bagAndInfo.cell{   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.DisplayObject;      public class LockableBagCell extends BagCell   {                   private var _lockDisplayObject:DisplayObject;            private var _cellLocked:Boolean = false;            public function LockableBagCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            public function get lockDisplayObject() : DisplayObject { return null; }
            public function set lockDisplayObject(value:DisplayObject) : void { }
            public function get cellLocked() : Boolean { return false; }
            public function set cellLocked(value:Boolean) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
   }}