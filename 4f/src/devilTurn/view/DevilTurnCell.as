package devilTurn.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;      public class DevilTurnCell extends BagCell   {                   private var _selectMovie:Bitmap;            private var _selected:Boolean;            public function DevilTurnCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            private function init() : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            override public function dispose() : void { }
   }}