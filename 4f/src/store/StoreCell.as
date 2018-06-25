package store{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.ShineObject;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.geom.Point;      public class StoreCell extends BagCell   {                   protected var _shiner:ShineObject;            protected var _index:int;            public var DoubleClickEnabled:Boolean = true;            public var mouseSilenced:Boolean = false;            public function StoreCell(bg:Sprite, $index:int) { super(null,null,null,null); }
            override protected function createChildren() : void { }
            override protected function initEvent() : void { }
            override protected function removeEvent() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            public function get itemBagType() : int { return 0; }
            public function get index() : int { return 0; }
            public function startShine() : void { }
            public function stopShine() : void { }
            override public function dispose() : void { }
   }}