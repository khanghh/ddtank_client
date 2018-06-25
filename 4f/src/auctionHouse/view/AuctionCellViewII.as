package auctionHouse.view{   import bagAndInfo.cell.DragEffect;   import bagAndInfo.cell.LinkedBagCell;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class AuctionCellViewII extends LinkedBagCell   {            public static const SELECT_BID_GOOD:String = "selectBidGood";            public static const SELECT_GOOD:String = "selectGood";                   public function AuctionCellViewII() { super(null); }
            override protected function addEnchantMc() : void { }
            override protected function createChildren() : void { }
            override public function dragDrop(effect:DragEffect) : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            override protected function onMouseOver(evt:MouseEvent) : void { }
            override protected function onMouseOut(evt:MouseEvent) : void { }
            override public function dispose() : void { }
   }}