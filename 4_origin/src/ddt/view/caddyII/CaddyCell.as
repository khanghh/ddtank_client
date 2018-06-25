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
      
      public function CaddyCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:Sprite = null)
      {
         super(index,info,showLoading,bg);
         tipDirctions = "7,5,2,6,4,1";
         addEventListener("click",__click);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(effect.data is SellGoodsBtn)
         {
            _isSellGoods = true;
         }
         else
         {
            _isSellGoods = false;
         }
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         if(value != null)
         {
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
      }
      
      private function __click(event:MouseEvent) : void
      {
         if(info && !_isSellGoods)
         {
            dispatchEvent(new CellEvent("itemclick",this));
         }
         _isSellGoods = false;
      }
   }
}
