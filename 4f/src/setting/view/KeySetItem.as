package setting.view{   import bagAndInfo.cell.DragEffect;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.data.PropInfo;   import ddt.interfaces.IAcceptDrag;   import ddt.manager.DragManager;   import ddt.manager.ItemManager;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import gameCommon.view.ItemCellView;      public class KeySetItem extends ItemCellView implements IAcceptDrag, ITipedDisplay   {                   private var _propIndex:int;            private var _propID:int;            private var _isGlow:Boolean = false;            private var glow_mc:Bitmap;            private var lightingFilter:ColorMatrixFilter;            private const CONST1:int = 40;            private const CONST2:int = 35;            public function KeySetItem(index:uint = 0, propIndex:int = 0, propID:int = 0, item:DisplayObject = null, isCount:Boolean = false) { super(null,null,null); }
            override protected function initItemBg() : void { }
            override protected function setItemWidthAndHeight() : void { }
            public function dragDrop(effect:DragEffect) : void { }
            private function __over(e:MouseEvent) : void { }
            private function __out(e:MouseEvent) : void { }
            public function set glow(b:Boolean) : void { }
            public function get glow() : Boolean { return false; }
            public function set propID(value:int) : void { }
            public function get tipData() : Object { return null; }
            public function asDisplayObject() : DisplayObject { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            override public function dispose() : void { }
   }}