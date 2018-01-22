package panicBuying.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import panicBuying.data.PBuyingItemInfo;
   import panicBuying.views.PanicBuyingBuyView;
   import panicBuying.views.PanicBuyingCell;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopGiftsManager;
   
   public class PanicBuyingItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _bagCell:PanicBuyingCell;
      
      private var _originalPrice:FilterFrameText;
      
      private var _delLine:Shape;
      
      private var _price:FilterFrameText;
      
      private var _payType:ScaleFrameImage;
      
      private var _entireRemainTxt:FilterFrameText;
      
      private var _giveBtn:SimpleBitmapButton;
      
      private var _askForBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _tipSprite:Component;
      
      private var _vip:Bitmap;
      
      private var _tag:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _templateId:int;
      
      private var _info:PBuyingItemInfo;
      
      public function PanicBuyingItem(){super();}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      protected function __giveBtnClick(param1:MouseEvent) : void{}
      
      protected function __askForBtnClick(param1:MouseEvent) : void{}
      
      protected function __buyBtnClick(param1:MouseEvent) : void{}
      
      public function setData(param1:PBuyingItemInfo, param2:int) : void{}
      
      private function checkBtnEnable() : void{}
      
      private function createTag() : void{}
      
      public function dispose() : void{}
      
      private function removeEvents() : void{}
   }
}
