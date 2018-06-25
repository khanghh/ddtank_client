package groupPurchase.view
{
   import ddt.command.QuickBuyFrameView;
   import ddt.manager.LanguageMgr;
   import groupPurchase.GroupPurchaseManager;
   
   public class GroupPurchaseQuickBuyFrameView extends QuickBuyFrameView
   {
       
      
      public function GroupPurchaseQuickBuyFrameView()
      {
         super();
      }
      
      override protected function refreshNumText() : void
      {
         var price:int = GroupPurchaseManager.instance.price;
         if(_isBand)
         {
            totalText.text = String(_stoneNumber * price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.bandStipple");
         }
         else
         {
            totalText.text = String(_stoneNumber * price) + " " + LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.stipple");
         }
      }
   }
}
