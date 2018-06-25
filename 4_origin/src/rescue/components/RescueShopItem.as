package rescue.components
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rescue.views.RescueQuickBuyFrame;
   
   public class RescueShopItem extends Sprite implements Disposeable
   {
       
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      protected var _dotLine:Image;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      private var _itemBmp:Bitmap;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _tipTouch:Component;
      
      private var _index:int;
      
      private var _priceArr:Array;
      
      public function RescueShopItem(index:int)
      {
         _index = index;
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemBg");
         _itemCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemCellBg");
         _dotLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemDotLine");
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         _payType.mouseChildren = false;
         _payType.mouseEnabled = false;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemName");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemPrice");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.BuyBtn");
         _itemBg.setFrame(1);
         _itemCellBg.setFrame(1);
         _payType.setFrame(2);
         addChild(_itemBg);
         addChild(_itemCellBg);
         addChild(_dotLine);
         addChild(_payType);
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_buyBtn);
         _priceArr = ServerConfigManager.instance.rescueShopItemPrice;
         _itemPriceTxt.text = _priceArr[_index];
         switch(int(_index))
         {
            case 0:
               _itemNameTxt.text = LanguageMgr.GetTranslation("rescue.arrow");
               _itemBmp = ComponentFactory.Instance.creat("rescue.arrow");
               break;
            case 1:
               _itemNameTxt.text = LanguageMgr.GetTranslation("rescue.bloodBag");
               _itemBmp = ComponentFactory.Instance.creat("rescue.bloodBag");
               break;
            case 2:
               _itemNameTxt.text = LanguageMgr.GetTranslation("rescue.kingBless");
               _itemBmp = ComponentFactory.Instance.creat("rescue.kingBless");
         }
         if(_itemBmp)
         {
            addChild(_itemBmp);
            _itemBmp.scaleX = 0.8;
            _itemBmp.scaleY = 0.8;
            _itemBmp.smoothing = true;
            _tipTouch = new Component();
            _tipTouch.graphics.beginFill(0,0);
            _tipTouch.graphics.drawRect(0,0,_itemBmp.width,_itemBmp.height);
            _tipTouch.graphics.endFill();
            _tipTouch.width = _itemBmp.width;
            _tipTouch.height = _itemBmp.height;
            _tipTouch.x = _itemBmp.x;
            _tipTouch.y = _itemBmp.y;
            _tipTouch.tipStyle = "ddt.view.tips.OneLineTip";
            _tipTouch.tipDirctions = "0";
            _tipTouch.tipData = LanguageMgr.GetTranslation("rescue.itemTip" + _index);
            addChild(_tipTouch);
         }
      }
      
      private function initEvents() : void
      {
         _buyBtn.addEventListener("click",__buyBtnClick);
      }
      
      protected function __buyBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuyFrame:RescueQuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("rescue.quickBuyFrame");
         quickBuyFrame.setData(_index,_priceArr[_index]);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      private function removeEvents() : void
      {
         _buyBtn.removeEventListener("click",__buyBtnClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemCellBg);
         _itemCellBg = null;
         ObjectUtils.disposeObject(_dotLine);
         _dotLine = null;
         ObjectUtils.disposeObject(_payType);
         _payType = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_itemPriceTxt);
         _itemPriceTxt = null;
         ObjectUtils.disposeObject(_itemBmp);
         _itemBmp = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_tipTouch);
         _tipTouch = null;
      }
   }
}
