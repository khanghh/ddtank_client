package store.view.fusion{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Shape;   import flash.events.Event;   import store.events.StoreIIEvent;      public class AccessoryFrameII extends Frame   {                   private var _list:SimpleTileList;            private var _bg:Shape;            private var _items:Array;            private var _area:AccessoryDragInArea;            public function AccessoryFrameII() { super(); }
            private function initII() : void { }
            private function initList() : void { }
            private function __itemInfoChange(evt:Event) : void { }
            public function clearList() : void { }
            public function get isBinds() : Boolean { return false; }
            public function setItemInfo(index:int, info:ItemTemplateInfo) : void { }
            public function listEmpty() : void { }
            public function show() : void { }
            public function hide() : void { }
            public function getCount() : Number { return 0; }
            public function containsItem(item:InventoryItemInfo) : Boolean { return false; }
            public function getAllAccessory() : Array { return null; }
            override public function dispose() : void { }
   }}