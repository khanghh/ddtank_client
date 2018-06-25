package totem.view{   import totem.mornUI.TotemTabItemCellUI;      public class TotemTabItemCell extends TotemTabItemCellUI   {                   private var _quality:int = 0;            public function TotemTabItemCell() { super(); }
            override protected function createChildren() : void { }
            public function set quality(value:int) : void { }
            public function get quality() : int { return 0; }
            public function set chapter(page:int) : void { }
            override public function dispose() : void { }
   }}