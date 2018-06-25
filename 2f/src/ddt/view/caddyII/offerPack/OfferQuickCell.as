package ddt.view.caddyII.offerPack{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.geom.Point;      public class OfferQuickCell extends BaseCell implements ISelectable   {                   private var _mcBg:ScaleBitmapImage;            private var _selected:Boolean;            private var _selecetedShin:Scale9CornerImage;            public function OfferQuickCell() { super(null); }
            private function initView() : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set autoSelect(value:Boolean) : void { }
            override public function asDisplayObject() : DisplayObject { return null; }
            public function showBg() : void { }
            public function hideBg() : void { }
            override public function dispose() : void { }
   }}