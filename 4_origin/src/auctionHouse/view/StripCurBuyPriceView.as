package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class StripCurBuyPriceView extends Sprite implements Disposeable
   {
       
      
      private var curPricel_txt:FilterFrameText;
      
      private var mouthful_txt:FilterFrameText;
      
      private var state_mc:ScaleFrameImage;
      
      private var goldMoneyTop_mc:ScaleFrameImage;
      
      private var goldMoneyChao_mc:ScaleFrameImage;
      
      private var _info:AuctionGoodsInfo;
      
      public function StripCurBuyPriceView()
      {
         super();
      }
      
      public function setup(state:int) : void
      {
         initView();
         state_mc.setFrame(state);
      }
      
      private function initView() : void
      {
         curPricel_txt = ComponentFactory.Instance.creat("auctionHouse.StripCurPricelTextII");
         addChild(curPricel_txt);
         mouthful_txt = ComponentFactory.Instance.creat("auctionHouse.StripmouthfulTextII");
         addChild(mouthful_txt);
         state_mc = ComponentFactory.Instance.creat("auctionHouse.BuyPriceState");
         addChild(state_mc);
         goldMoneyTop_mc = ComponentFactory.Instance.creat("auctionHouse.StripMoneyIconIII");
         addChild(goldMoneyTop_mc);
         goldMoneyChao_mc = ComponentFactory.Instance.creat("auctionHouse.StripMoneyIconV");
         addChild(goldMoneyChao_mc);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      function set info(value:AuctionGoodsInfo) : void
      {
         _info = value;
         update();
      }
      
      private function update() : void
      {
         curPricel_txt.text = _info.Price.toString();
         setMouth();
         if(_info.PayType == 0)
         {
            goldMoneyChao_mc.setFrame(1);
         }
         else
         {
            goldMoneyChao_mc.setFrame(2);
         }
         mouseEnabled = false;
         if(_info.BuyerID != PlayerManager.Instance.Self.ID)
         {
            state_mc.setFrame(2);
         }
         else
         {
            state_mc.setFrame(1);
         }
      }
      
      private function setMouth() : void
      {
         if(_info.Mouthful == 0)
         {
            goldMoneyTop_mc.visible = false;
            mouthful_txt.text = "";
         }
         else
         {
            goldMoneyTop_mc.setFrame(_info.PayType + 1);
            goldMoneyTop_mc.visible = true;
            mouthful_txt.text = _info.Mouthful.toString();
         }
         goldMoneyTop_mc.mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         if(mouthful_txt)
         {
            ObjectUtils.disposeObject(mouthful_txt);
         }
         mouthful_txt = null;
         if(curPricel_txt)
         {
            ObjectUtils.disposeObject(curPricel_txt);
         }
         curPricel_txt = null;
         if(goldMoneyTop_mc)
         {
            ObjectUtils.disposeObject(goldMoneyTop_mc);
         }
         goldMoneyTop_mc = null;
         if(goldMoneyChao_mc)
         {
            ObjectUtils.disposeObject(goldMoneyChao_mc);
         }
         goldMoneyChao_mc = null;
         if(state_mc)
         {
            ObjectUtils.disposeObject(state_mc);
         }
         state_mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
