package email.view
{
   import auctionHouse.view.AuctionBagEquipListView;
   import auctionHouse.view.AuctionBagListView;
   import auctionHouse.view.AuctionBagView;
   import auctionHouse.view.AuctionBeadListView;
   import com.pickgliss.ui.controls.BaseButton;
   
   public class EmailBagView extends AuctionBagView
   {
       
      
      private var _beadBtn:BaseButton;
      
      public function EmailBagView(){super();}
      
      override protected function initBagList() : void{}
      
      override protected function adjustEvent() : void{}
   }
}
