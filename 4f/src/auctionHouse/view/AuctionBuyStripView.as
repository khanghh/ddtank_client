package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   
   public class AuctionBuyStripView extends BaseStripView
   {
       
      
      private var _curPrice:StripCurBuyPriceView;
      
      private var _lefTip:StripTip;
      
      public function AuctionBuyStripView(){super();}
      
      override protected function initView() : void{}
      
      private function addEvent() : void{}
      
      override function clearSelectStrip() : void{}
      
      override protected function updateInfo() : void{}
      
      override public function dispose() : void{}
   }
}
