package gameCommon.view.propContainer{   import com.pickgliss.ui.controls.container.SimpleTileList;   import ddt.data.PropInfo;   import ddt.events.ItemEvent;   import ddt.view.PropItemView;   import flash.display.DisplayObject;   import gameCommon.view.ItemCellView;      [Event(name="itemClick",type="ddt.events.ItemEvent")]   [Event(name="itemOver",type="ddt.events.ItemEvent")]   [Event(name="itemOut",type="ddt.events.ItemEvent")]   [Event(name="itemMove",type="ddt.events.ItemEvent")]   public class ItemContainer extends SimpleTileList   {            public static var USE_THREE:String = "use_threeSkill";            public static var PLANE:int = 1;            public static var THREE_SKILL:int = 2;            public static var BOTH:int = 3;                   private var list:Array;            private var _ordinal:Boolean;            private var _clickAble:Boolean;            public function ItemContainer(count:Number, column:Number = 1, bgvisible:Boolean = true, ordinal:Boolean = false, clickable:Boolean = false, EffectType:String = "") { super(null); }
            public function setState(clickable:Boolean, isGray:Boolean) : void { }
            public function get clickAble() : Boolean { return false; }
            public function appendItem(item:DisplayObject) : void { }
            public function get blankItems() : Array { return null; }
            public function mouseClickAt(index:int) : void { }
            private function __itemClick(event:ItemEvent) : void { }
            private function __itemOver(event:ItemEvent) : void { }
            private function __itemOut(event:ItemEvent) : void { }
            private function __itemMove(event:ItemEvent) : void { }
            public function appendItemAt(item:DisplayObject, index:int) : void { }
            public function removeItem(item:DisplayObject) : void { }
            public function removeItemAt(index:int) : void { }
            public function clear() : void { }
            public function setItemClickAt(index:int, isClick:Boolean, isGray:Boolean) : void { }
            public function disableCellIndex(index:int) : void { }
            public function disableSelfProp(value:int) : void { }
            public function disableCellArr() : void { }
            public function setNoClickAt(index:int) : void { }
            private function setItemState(isClick:Boolean, isGray:Boolean) : void { }
            public function setClickByEnergy(energy:int) : void { }
            public function setVisible(index:int, v:Boolean) : void { }
            override public function dispose() : void { }
   }}