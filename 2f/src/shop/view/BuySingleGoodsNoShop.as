package shop.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class BuySingleGoodsNoShop extends BuySingleGoodsView
   {
       
      
      private var _itemCell:BagCell;
      
      private var _itemName:FilterFrameText;
      
      private var _priceCheck:SelectedCheckButton;
      
      public var onBuy:Function;
      
      public function BuySingleGoodsNoShop(param1:int = 1){super(null);}
      
      override protected function initView() : void{}
      
      override public function set goodsID(param1:int) : void{}
      
      override protected function updateCommodityPrices() : void{}
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void{}
      
      override protected function onCheckComplete() : void{}
   }
}
