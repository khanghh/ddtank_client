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
      
      public function EmailBagView()
      {
         super();
      }
      
      override protected function initBagList() : void
      {
         _equiplist = new AuctionBagEquipListView(0);
         _proplist = new AuctionBagListView(1);
         var _loc1_:* = 14;
         _proplist.x = _loc1_;
         _equiplist.x = _loc1_;
         _loc1_ = 54;
         _proplist.y = _loc1_;
         _equiplist.y = _loc1_;
         _beadList = new AuctionBeadListView(21,32,80);
         _beadList2 = new AuctionBeadListView(21,81,129);
         _beadList3 = new AuctionBeadListView(21,130,178);
         _loc1_ = 14;
         _beadList3.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.x = _loc1_;
         _loc1_ = _loc1_;
         _beadList.x = _loc1_;
         _loc1_ = _loc1_;
         _proplist.x = _loc1_;
         _equiplist.x = _loc1_;
         _loc1_ = 54;
         _beadList3.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.y = _loc1_;
         _loc1_ = _loc1_;
         _beadList.y = _loc1_;
         _loc1_ = _loc1_;
         _proplist.y = _loc1_;
         _equiplist.y = _loc1_;
         _loc1_ = 330;
         _beadList3.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.width = _loc1_;
         _loc1_ = _loc1_;
         _beadList.width = _loc1_;
         _loc1_ = _loc1_;
         _proplist.width = _loc1_;
         _equiplist.width = _loc1_;
         _loc1_ = 320;
         _beadList3.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList2.height = _loc1_;
         _loc1_ = _loc1_;
         _beadList.height = _loc1_;
         _loc1_ = _loc1_;
         _proplist.height = _loc1_;
         _equiplist.height = _loc1_;
         _proplist.visible = false;
         _lists = [_equiplist,_proplist,_beadList,_beadList2,_beadList3];
         _currentList = _equiplist;
         addChild(_equiplist);
         addChild(_proplist);
         addChild(_beadList);
         addChild(_beadList2);
         addChild(_beadList3);
      }
      
      override protected function adjustEvent() : void
      {
      }
   }
}
