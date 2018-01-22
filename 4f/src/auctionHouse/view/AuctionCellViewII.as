package auctionHouse.view
{
   import bagAndInfo.cell.DragEffect;
   import bagAndInfo.cell.LinkedBagCell;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class AuctionCellViewII extends LinkedBagCell
   {
      
      public static const SELECT_BID_GOOD:String = "selectBidGood";
      
      public static const SELECT_GOOD:String = "selectGood";
       
      
      public function AuctionCellViewII(){super(null);}
      
      override protected function addEnchantMc() : void{}
      
      override protected function createChildren() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override protected function onMouseClick(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
