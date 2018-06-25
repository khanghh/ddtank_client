package store.fineStore.view.pageForge{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.view.tips.GoodTipInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.geom.Point;      public class FineForgeCell extends BaseCell implements ISelectable   {                   private var _select:Boolean;            private var _shine:Bitmap;            private var _text:FilterFrameText;            private var _type:int;            private var _name:String;            public function FineForgeCell(type:int, text:String = "", $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true) { super(null,null,null,null); }
            override public function set info(value:ItemTemplateInfo) : void { }
            override protected function createChildren() : void { }
            public function set bgType(value:int) : void { }
            public function get type() : int { return 0; }
            public function get cellName() : String { return null; }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set autoSelect(value:Boolean) : void { }
            override public function dispose() : void { }
   }}