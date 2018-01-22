package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BuyJewelryExperienceView extends BuySingleGoodsView
   {
       
      
      private var _moneyPrice:Number;
      
      private var _bindMoneyPrice:Number;
      
      private var _itemName:FilterFrameText;
      
      private var _upToNextLevel:SelectedCheckButton;
      
      private var _upToNextLevelText:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _priceCheck0:SelectedCheckButton;
      
      private var _priceCheck1:SelectedCheckButton;
      
      private var _curExp:int;
      
      private var _NextLvExp:int;
      
      public var onBuy:Function;
      
      private var moneyValue:int;
      
      public function BuyJewelryExperienceView(param1:int = 1){super(null);}
      
      override protected function initView() : void{}
      
      public function goodsData(param1:int, param2:int) : void{}
      
      protected function onUpToNxtLvChange(param1:Event) : void{}
      
      protected function onNumberSelecterChange(param1:Event) : void{}
      
      protected function __cartItemGroupChange(param1:Event) : void{}
      
      override protected function updateCommodityPrices() : void{}
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void{}
      
      override protected function onCheckComplete() : void{}
      
      override public function dispose() : void{}
   }
}
