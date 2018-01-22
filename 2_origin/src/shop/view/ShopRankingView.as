package shop.view
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenProxy;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.ShopController;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopGiftsManager;
   
   public class ShopRankingView extends Sprite implements Disposeable
   {
       
      
      private var _controller:ShopController;
      
      private var _shopSearchBg:Image;
      
      private var _rankingTitleBg:Bitmap;
      
      private var _rankingTitle:Bitmap;
      
      private var _rankingBackBg:Scale9CornerImage;
      
      private var _rankingFrontBg:Scale9CornerImage;
      
      private var _rankingFrontTexture:ScaleBitmapImage;
      
      private var _rankingBg:Image;
      
      private var _shopSearchBtn:TextButton;
      
      private var _shopSearchText:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _rankingItems:Vector.<ShopRankingCellItem>;
      
      private var _rankingLightMc:MovieClip;
      
      private var _separator:Vector.<Bitmap>;
      
      private var _currentShopSearchText:String;
      
      private var _currentList:Vector.<ShopItemInfo>;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      public function ShopRankingView()
      {
         super();
      }
      
      public function setup(param1:ShopController) : void
      {
         _controller = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _shopSearchBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ShopSearchBg");
         addChild(_shopSearchBg);
         _rankingBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingViewBg");
         addChild(_rankingBg);
         _rankingTitleBg = ComponentFactory.Instance.creatBitmap("asset.ddtshop.RankingTitleBg");
         addChild(_rankingTitleBg);
         _rankingTitle = ComponentFactory.Instance.creatBitmap("asset.ddtshop.RankingTitle");
         addChild(_rankingTitle);
         _shopSearchBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ShopSearchBtn");
         _shopSearchBtn.text = LanguageMgr.GetTranslation("shop.ShopRankingView.SearchBtnText");
         addChild(_shopSearchBtn);
         _shopSearchText = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ShopSearchText");
         _shopSearchText.text = LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText");
         addChild(_shopSearchText);
         _rankingItems = new Vector.<ShopRankingCellItem>();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingItemsContainer");
         addChild(_vBox);
         _rankingLightMc = ComponentFactory.Instance.creatCustomObject("ddtshop.RankingLightMc");
         _separator = new Vector.<Bitmap>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _rankingItems[_loc2_] = ComponentFactory.Instance.creatCustomObject("ddtshop.ShopRankingCellItem");
            _rankingItems[_loc2_].itemCellBtn.addEventListener("click",__itemClick);
            _rankingItems[_loc2_].itemCellBtn.addEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[_loc2_].itemCellBtn.addEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[_loc2_].itemBg.addEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[_loc2_].itemBg.addEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[_loc2_].payPaneGivingBtn.addEventListener("click",__payPaneGivingBtnClick);
            _rankingItems[_loc2_].payPaneBuyBtn.addEventListener("click",__payPaneBuyBtnClick);
            _rankingItems[_loc2_].payPaneAskBtn.addEventListener("click",payPaneAskHander);
            _vBox.addChild(_rankingItems[_loc2_]);
            if(_loc2_ != 0)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.ddtshop.RankingSeparator");
               PositionUtils.setPos(_loc1_,ComponentFactory.Instance.creatCustomObject("ddtshop.RankingViewSeparator_" + _loc2_));
               addChild(_loc1_);
               _separator.push(_loc1_);
            }
            _loc2_++;
         }
         loadList();
      }
      
      private function addEvent() : void
      {
         _shopSearchText.addEventListener("focusIn",__shopSearchTextFousIn);
         _shopSearchText.addEventListener("focusOut",__shopSearchTextFousOut);
         _shopSearchText.addEventListener("keyDown",__shopSearchTextKeyDown);
         _shopSearchBtn.addEventListener("click",__shopSearchBtnClick);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _shopSearchText.removeEventListener("focusIn",__shopSearchTextFousIn);
         _shopSearchText.removeEventListener("focusOut",__shopSearchTextFousOut);
         _shopSearchText.removeEventListener("keyDown",__shopSearchTextKeyDown);
         _shopSearchBtn.removeEventListener("click",__shopSearchBtnClick);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _rankingItems[_loc1_].itemCellBtn.removeEventListener("click",__itemClick);
            _rankingItems[_loc1_].itemCellBtn.removeEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[_loc1_].itemCellBtn.removeEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[_loc1_].itemBg.removeEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[_loc1_].itemBg.removeEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[_loc1_].payPaneGivingBtn.removeEventListener("click",__payPaneGivingBtnClick);
            _rankingItems[_loc1_].payPaneBuyBtn.removeEventListener("click",__payPaneBuyBtnClick);
            _rankingItems[_loc1_].payPaneAskBtn.removeEventListener("click",payPaneAskHander);
            _loc1_++;
         }
      }
      
      private function payPaneAskHander(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         var _loc3_:ShopItemInfo = _loc2_.shopItemInfo;
         if(_loc3_ && _loc3_.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_loc3_ != null)
         {
            SoundManager.instance.play("008");
            if(_loc3_.isDiscount == 2 && ShopManager.Instance.getDisCountShopItemByGoodsID(_loc3_.GoodsID) == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.shop.discount.exit"));
               return;
            }
            ShopBuyManager.Instance.buy(_loc3_.GoodsID,_loc3_.isDiscount,3);
         }
      }
      
      private function __payPaneGivingBtnClick(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         if(_loc2_.shopItemInfo && _loc2_.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_loc2_.shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            ShopGiftsManager.Instance.buy(_loc2_.shopItemInfo.GoodsID,false,2);
            var _loc5_:int = 0;
            var _loc4_:* = _rankingItems;
            for each(var _loc3_ in _rankingItems)
            {
               _loc3_.selected = false;
            }
            _loc2_.selected = true;
         }
      }
      
      private function __payPaneBuyBtnClick(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         if(_loc2_.shopItemInfo && _loc2_.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_loc2_.shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            ShopBuyManager.Instance.buy(_loc2_.shopItemInfo.GoodsID);
            var _loc5_:int = 0;
            var _loc4_:* = _rankingItems;
            for each(var _loc3_ in _rankingItems)
            {
               _loc3_.selected = false;
            }
            _loc2_.selected = true;
         }
      }
      
      protected function __shopSearchTextKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __shopSearchBtnClick();
         }
      }
      
      protected function __shopSearchTextFousIn(param1:FocusEvent) : void
      {
         if(_shopSearchText.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText"))
         {
            _shopSearchText.text = "";
         }
      }
      
      protected function __shopSearchTextFousOut(param1:FocusEvent) : void
      {
         if(_shopSearchText.text.length == 0)
         {
            _shopSearchText.text = LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText");
         }
      }
      
      protected function __shopSearchBtnClick(param1:MouseEvent = null) : void
      {
         var _loc2_:* = undefined;
         SoundManager.instance.play("008");
         if(_shopSearchText.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText") || _shopSearchText.text.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.ShopRankingView.PleaseEnterTheKeywords"));
            return;
         }
         if(_currentShopSearchText != _shopSearchText.text)
         {
            _currentShopSearchText = _shopSearchText.text;
            _loc2_ = ShopManager.Instance.getDesignatedAllShopItem();
            _loc2_ = ShopManager.Instance.fuzzySearch(_loc2_,_currentShopSearchText);
            _currentList = _loc2_;
         }
         else
         {
            _loc2_ = _currentList;
         }
         if(_loc2_.length > 0)
         {
            _controller.rightView.searchList(_loc2_);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.ShopRankingView.NoSearchResults"));
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),1,5));
      }
      
      private function getType() : int
      {
         var _loc2_:Array = [85,86];
         var _loc1_:int = _controller.rightView.genderGroup.selectIndex;
         return int(_loc2_[_loc1_]);
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:int = 0;
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(_loc2_ < param1.length && param1[_loc2_])
            {
               _rankingItems[_loc2_].shopItemInfo = param1[_loc2_];
            }
            _loc2_++;
         }
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _rankingItems[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc7_:Boolean = false;
         var _loc4_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         if(!_loc4_.shopItemInfo)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_loc4_.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_controller.model.isOverCount(_loc4_.shopItemInfo))
         {
            var _loc10_:int = 0;
            var _loc9_:* = _rankingItems;
            for each(var _loc8_ in _rankingItems)
            {
               _loc8_.selected = _loc8_ == _loc4_;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.GoodsNumberLimit"));
            return;
         }
         if(_loc4_.shopItemInfo && _loc4_.shopItemInfo.TemplateInfo)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _rankingItems;
            for each(var _loc6_ in _rankingItems)
            {
               _loc6_.selected = _loc6_ == _loc4_;
            }
            if(EquipType.dressAble(_loc4_.shopItemInfo.TemplateInfo))
            {
               _loc2_ = _loc4_.shopItemInfo.TemplateInfo.NeedSex != 2?0:1;
               if(_loc4_.shopItemInfo.TemplateInfo.NeedSex != 0 && _controller.rightView.genderGroup.selectIndex != _loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.changeColor.sexAlert"));
                  return;
               }
               _controller.addTempEquip(_loc4_.shopItemInfo);
            }
            else
            {
               _loc5_ = new ShopCarItemInfo(_loc4_.shopItemInfo.GoodsID,_loc4_.shopItemInfo.TemplateID);
               ObjectUtils.copyProperties(_loc5_,_loc4_.shopItemInfo);
               _loc3_ = _controller.addToCar(_loc5_);
            }
            _loc7_ = _controller.leftView.getColorEditorVisble();
            if(_loc3_ && !_loc7_)
            {
               addCartEffects(_loc4_.itemCell);
            }
         }
      }
      
      private function addCartEffects(param1:DisplayObject) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc7_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc7_.draw(param1);
         var _loc2_:Bitmap = new Bitmap(_loc7_,"auto",true);
         parent.addChild(_loc2_);
         _loc5_ = TweenProxy.create(_loc2_);
         _loc5_.registrationX = _loc5_.width / 2;
         _loc5_.registrationY = _loc5_.height / 2;
         var _loc8_:Point = DisplayUtils.localizePoint(parent,param1);
         _loc5_.x = _loc8_.x + _loc5_.width / 2;
         _loc5_.y = _loc8_.y + _loc5_.height / 2;
         _loc6_ = new TimelineLite();
         _loc6_.vars.onComplete = twComplete;
         _loc6_.vars.onCompleteParams = [_loc6_,_loc5_,_loc2_];
         _loc3_ = new TweenLite(_loc5_,0.3,{
            "x":220,
            "y":430
         });
         _loc4_ = new TweenLite(_loc5_,0.3,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         _loc6_.append(_loc3_);
         _loc6_.append(_loc4_,-0.2);
      }
      
      private function twComplete(param1:TimelineLite, param2:TweenProxy, param3:Bitmap) : void
      {
         if(param1)
         {
            param1.kill();
         }
         if(param2)
         {
            param2.destroy();
         }
         if(param3.parent)
         {
            param3.parent.removeChild(param3);
            param3.bitmapData.dispose();
         }
         param2 = null;
         param3 = null;
         param1 = null;
      }
      
      protected function __rankingItemsMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         _loc2_.setItemLight(_rankingLightMc);
         _loc2_.mouseOver();
      }
      
      protected function __rankingItemsMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:ShopRankingCellItem = param1.currentTarget.parent as ShopRankingCellItem;
         _loc2_.mouseOut();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(_separator)
         {
            _loc1_ = 0;
            while(_loc1_ < _separator.length)
            {
               if(_separator[_loc1_])
               {
                  ObjectUtils.disposeObject(_separator[_loc1_]);
               }
               _separator[_loc1_] = null;
               _loc1_++;
            }
         }
         _separator = null;
         ObjectUtils.disposeObject(_rankingTitleBg);
         _rankingTitleBg = null;
         ObjectUtils.disposeObject(_rankingTitle);
         _rankingTitle = null;
         ObjectUtils.disposeObject(_rankingBg);
         _rankingBg = null;
         ObjectUtils.disposeObject(_rankingLightMc);
         _rankingLightMc = null;
         ObjectUtils.disposeObject(_shopSearchBg);
         _shopSearchBg = null;
         ObjectUtils.disposeObject(_rankingBackBg);
         _rankingBackBg = null;
         ObjectUtils.disposeObject(_rankingFrontBg);
         _rankingFrontBg = null;
         ObjectUtils.disposeObject(_rankingBackBg);
         _rankingBackBg = null;
         ObjectUtils.disposeObject(_rankingFrontTexture);
         _rankingFrontTexture = null;
         ObjectUtils.disposeObject(_shopSearchBtn);
         _shopSearchBtn = null;
         ObjectUtils.disposeObject(_shopSearchText);
         _shopSearchText = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
