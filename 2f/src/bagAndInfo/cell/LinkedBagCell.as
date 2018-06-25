package bagAndInfo.cell{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.interfaces.IDragable;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;      public class LinkedBagCell extends BagCell   {                   protected var _bagCell:BagCell;            public var DoubleClickEnabled:Boolean = true;            public function LinkedBagCell(bg:Sprite) { super(null,null,null,null); }
            override protected function init() : void { }
            private function __clickHandler(evt:InteractiveEvent) : void { }
            public function get bagCell() : BagCell { return null; }
            public function set bagCell(value:BagCell) : void { }
            override public function get place() : int { return 0; }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override public function dragStop(effect:DragEffect) : void { }
            private function __changed(event:Event) : void { }
            override public function getSource() : IDragable { return null; }
            public function clearLinkCell() : void { }
            override public function set locked(b:Boolean) : void { }
            override public function dispose() : void { }
   }}