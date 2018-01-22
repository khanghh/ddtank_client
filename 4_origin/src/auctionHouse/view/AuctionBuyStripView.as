package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   
   public class AuctionBuyStripView extends BaseStripView
   {
       
      
      private var _curPrice:StripCurBuyPriceView;
      
      private var _lefTip:StripTip;
      
      public function AuctionBuyStripView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         back_mc.width = 924;
         stripSelect_bit.width = 932;
         leftBG.width = 924;
         _name.x = 61;
         _count.x = 272;
         _leftTime.x = 380;
         _lefTip = ComponentFactory.Instance.creat("auctionHouse.view.StripLeftTime");
         _lefTip.x = _leftTime.x;
         _leftTime.x = -20;
         _leftTime.y = 0;
         _lefTip.setView(_leftTime);
         addChild(_lefTip);
         _curPrice = ComponentFactory.Instance.creat("auctionHouse.view.StripCurBuyPriceView");
         _curPrice.setup(1);
         addChild(_curPrice);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _leftTime.mouseEnabled = true;
      }
      
      override function clearSelectStrip() : void
      {
         super.clearSelectStrip();
         this.removeChild(_curPrice);
      }
      
      override protected function updateInfo() : void
      {
         super.updateInfo();
         _curPrice.info = _info;
         _lefTip.width = _leftTime.textWidth;
         _lefTip.height = _leftTime.textHeight;
         _lefTip.tipData = _info.getSithTimeDescription();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_curPrice)
         {
            ObjectUtils.disposeObject(_curPrice);
         }
         _curPrice = null;
         if(_lefTip)
         {
            ObjectUtils.disposeObject(_lefTip);
         }
         _lefTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
