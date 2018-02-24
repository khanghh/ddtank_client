package ddt.view.caddyII
{
   import bagAndInfo.bag.SellGoodsBtn;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CaddyCell extends BagCell
   {
       
      
      private var _isSellGoods:Boolean;
      
      public function CaddyCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Sprite = null){super(null,null,null,null);}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      private function __click(param1:MouseEvent) : void{}
   }
}
