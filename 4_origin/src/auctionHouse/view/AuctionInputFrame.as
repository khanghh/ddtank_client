package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   
   public class AuctionInputFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _SellText:FilterFrameText;
      
      private var _SellText1:FilterFrameText;
      
      private var _sellInputBg:Scale9CornerImage;
      
      public function AuctionInputFrame()
      {
         super();
         setView();
      }
      
      private function setView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBuyView.Auction"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _SellText = ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.SellLeftAlerText2");
         _SellText.text = LanguageMgr.GetTranslation("tank.ddtauctionHouse.text.BrowseNumber");
         _SellText1 = ComponentFactory.Instance.creatComponentByStylename("ddtauctionHouse.SellLeftAlerText3");
         _SellText1.text = LanguageMgr.GetTranslation("tank.auctionHouse.view.AuctionBrowseView.buction1");
         _sellInputBg = ComponentFactory.Instance.creatComponentByStylename("auctionHouse.SellLeftAlerInputBg1");
         addToContent(_SellText);
         addToContent(_SellText1);
         addToContent(_sellInputBg);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
