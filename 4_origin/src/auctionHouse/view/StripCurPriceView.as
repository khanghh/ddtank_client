package auctionHouse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.auctionHouse.AuctionGoodsInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StripCurPriceView extends Sprite implements Disposeable
   {
       
      
      private var _info:AuctionGoodsInfo;
      
      private var maxPrice_txt:FilterFrameText;
      
      private var mouthPrice_txt:FilterFrameText;
      
      private var yourPrice_bit:Bitmap;
      
      private var mouth_bit:Bitmap;
      
      private var goldMoney_mc:ScaleFrameImage;
      
      private var goldMoneyMouth_mc:ScaleFrameImage;
      
      private var goldMoney_mc_y:int;
      
      private var maxPrice_txt_y:int;
      
      private var yourPrice_bit_y:int;
      
      public function StripCurPriceView()
      {
         super();
         mouseEnabled = false;
         initView();
      }
      
      private function initView() : void
      {
         maxPrice_txt = ComponentFactory.Instance.creat("auctionHouse.StripMoneyTextI");
         addChild(maxPrice_txt);
         mouthPrice_txt = ComponentFactory.Instance.creat("auctionHouse.StripMoneyTextII");
         addChild(mouthPrice_txt);
         yourPrice_bit = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.yourPrice_bit");
         addChild(yourPrice_bit);
         mouth_bit = ComponentFactory.Instance.creatBitmap("asset.auctionHouse.mouth_bit");
         addChild(mouth_bit);
         goldMoney_mc = ComponentFactory.Instance.creat("auctionHouse.StripMoneyIconI");
         addChild(goldMoney_mc);
         goldMoneyMouth_mc = ComponentFactory.Instance.creat("auctionHouse.StripMoneyIconII");
         addChild(goldMoneyMouth_mc);
         goldMoney_mc_y = goldMoney_mc.y;
         maxPrice_txt_y = maxPrice_txt.y;
         yourPrice_bit_y = yourPrice_bit.y;
      }
      
      function set info(value:AuctionGoodsInfo) : void
      {
         _info = value;
         update();
      }
      
      private function update() : void
      {
         if(_info.AuctioneerID != PlayerManager.Instance.Self.ID && _info.BuyerID == PlayerManager.Instance.Self.ID)
         {
            yourPrice_bit.visible = true;
            maxPrice_txt.text = _info.Price.toString();
         }
         else
         {
            yourPrice_bit.visible = false;
            maxPrice_txt.text = _info.Price.toString();
         }
         mouthPrice_txt.text = _info.Mouthful.toString();
         goldMoney_mc.setFrame(_info.PayType + 1);
         goldMoneyMouth_mc.setFrame(_info.PayType + 1);
         setMouse();
      }
      
      private function setMouse() : void
      {
         if(_info.Mouthful == 0)
         {
            goldMoneyMouth_mc.visible = false;
            mouthPrice_txt.text = "";
            goldMoney_mc.y = 13;
            maxPrice_txt.y = 11;
            mouth_bit.visible = false;
            yourPrice_bit.y = 12;
         }
         else
         {
            goldMoney_mc.setFrame(_info.PayType + 1);
            goldMoneyMouth_mc.visible = true;
            goldMoney_mc.visible = true;
            mouth_bit.visible = true;
            goldMoney_mc.y = goldMoney_mc_y;
            maxPrice_txt.y = maxPrice_txt_y;
            yourPrice_bit.y = yourPrice_bit_y;
         }
         maxPrice_txt.mouseEnabled = false;
         mouthPrice_txt.mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         if(_info)
         {
            _info = null;
         }
         if(maxPrice_txt)
         {
            ObjectUtils.disposeObject(maxPrice_txt);
         }
         maxPrice_txt = null;
         if(mouthPrice_txt)
         {
            ObjectUtils.disposeObject(mouthPrice_txt);
         }
         mouthPrice_txt = null;
         if(yourPrice_bit)
         {
            ObjectUtils.disposeObject(yourPrice_bit);
         }
         yourPrice_bit = null;
         if(mouth_bit)
         {
            ObjectUtils.disposeObject(mouth_bit);
         }
         mouth_bit = null;
         if(goldMoney_mc)
         {
            ObjectUtils.disposeObject(goldMoney_mc);
         }
         goldMoney_mc = null;
         if(goldMoneyMouth_mc)
         {
            ObjectUtils.disposeObject(goldMoneyMouth_mc);
         }
         goldMoneyMouth_mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
