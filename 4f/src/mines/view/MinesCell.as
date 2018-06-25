package mines.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.geom.Point;      public class MinesCell extends BagCell   {                   protected var _index:int;            public var DoubleClickEnabled:Boolean = true;            public var mouseSilenced:Boolean = false;            public function MinesCell(bg:Sprite, $index:int) { super(null,null,null,null); }
            override protected function initEvent() : void { }
            override protected function removeEvent() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            public function get itemBagType() : int { return 0; }
            public function get index() : int { return 0; }
            override public function dispose() : void { }
   }}