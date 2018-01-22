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
      
      public function StripCurBuyPriceView(){super();}
      
      public function setup(param1:int) : void{}
      
      private function initView() : void{}
      
      function set info(param1:AuctionGoodsInfo) : void{}
      
      private function update() : void{}
      
      private function setMouth() : void{}
      
      public function dispose() : void{}
   }
}
