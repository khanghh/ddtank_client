package bagAndInfo.bag{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import playerDress.components.DressUtils;      public class CellMenu extends Sprite   {            public static const ADDPRICE:String = "addprice";            public static const MOVE:String = "move";            public static const OPEN:String = "open";            public static const USE:String = "use";            public static const OPEN_BATCH:String = "open_batch";            public static const COLOR_CHANGE:String = "color_change";            public static const SELL:String = "delete";            public static const RELIEVE:String = "relieve";            private static var _instance:CellMenu;                   private var _bg:Bitmap;            private var _bg2:Bitmap;            private var _cell:BagCell;            private var _addpriceitem:BaseButton;            private var _moveitem:BaseButton;            private var _openitem:BaseButton;            private var _useitem:BaseButton;            private var _openBatchItem:BaseButton;            private var _colorChangeItem:BaseButton;            private var _sellItem:BaseButton;            private var _relieveBtm:BaseButton;            private var _list:Sprite;            public function CellMenu(single:SingletonFoce) { super(); }
            public static function get instance() : CellMenu { return null; }
            private function init() : void { }
            private function __relieveClick(e:MouseEvent) : void { }
            public function set cell(value:BagCell) : void { }
            public function get cell() : BagCell { return null; }
            private function __mouseClick(evt:MouseEvent) : void { }
            private function __addpriceClick(evt:MouseEvent) : void { }
            private function __moveClick(evt:MouseEvent) : void { }
            private function __openClick(evt:MouseEvent) : void { }
            private function __useClick(evt:MouseEvent) : void { }
            private function __openBatchClick(evt:MouseEvent) : void { }
            private function __colorChangeClick(evt:MouseEvent) : void { }
            private function __sellClick(evt:MouseEvent) : void { }
            public function show(cell:BagCell, x:int, y:int) : void { }
            private function isCanBatch(id:int) : Boolean { return false; }
            public function hide() : void { }
            public function get showed() : Boolean { return false; }
   }}class SingletonFoce{          function SingletonFoce() { super(); }
}