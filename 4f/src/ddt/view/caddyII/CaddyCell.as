package ddt.view.caddyII{   import bagAndInfo.bag.SellGoodsBtn;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.DragEffect;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CellEvent;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CaddyCell extends BagCell   {                   private var _isSellGoods:Boolean;            public function CaddyCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null) { super(null,null,null,null); }
            override public function dragDrop(effect:DragEffect) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            private function __click(event:MouseEvent) : void { }
   }}