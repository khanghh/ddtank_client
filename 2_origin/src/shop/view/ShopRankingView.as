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
      
      public function setup($controller:ShopController) : void
      {
         _controller = $controller;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var separator:* = null;
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
         for(i = 0; i < 5; )
         {
            _rankingItems[i] = ComponentFactory.Instance.creatCustomObject("ddtshop.ShopRankingCellItem");
            _rankingItems[i].itemCellBtn.addEventListener("click",__itemClick);
            _rankingItems[i].itemCellBtn.addEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[i].itemCellBtn.addEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[i].itemBg.addEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[i].itemBg.addEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[i].payPaneGivingBtn.addEventListener("click",__payPaneGivingBtnClick);
            _rankingItems[i].payPaneBuyBtn.addEventListener("click",__payPaneBuyBtnClick);
            _rankingItems[i].payPaneAskBtn.addEventListener("click",payPaneAskHander);
            _vBox.addChild(_rankingItems[i]);
            if(i != 0)
            {
               separator = ComponentFactory.Instance.creatBitmap("asset.ddtshop.RankingSeparator");
               PositionUtils.setPos(separator,ComponentFactory.Instance.creatCustomObject("ddtshop.RankingViewSeparator_" + i));
               addChild(separator);
               _separator.push(separator);
            }
            i++;
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
         var i:int = 0;
         _shopSearchText.removeEventListener("focusIn",__shopSearchTextFousIn);
         _shopSearchText.removeEventListener("focusOut",__shopSearchTextFousOut);
         _shopSearchText.removeEventListener("keyDown",__shopSearchTextKeyDown);
         _shopSearchBtn.removeEventListener("click",__shopSearchBtnClick);
         for(i = 0; i < 5; )
         {
            _rankingItems[i].itemCellBtn.removeEventListener("click",__itemClick);
            _rankingItems[i].itemCellBtn.removeEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[i].itemCellBtn.removeEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[i].itemBg.removeEventListener("mouseOver",__rankingItemsMouseOver);
            _rankingItems[i].itemBg.removeEventListener("mouseOut",__rankingItemsMouseOut);
            _rankingItems[i].payPaneGivingBtn.removeEventListener("click",__payPaneGivingBtnClick);
            _rankingItems[i].payPaneBuyBtn.removeEventListener("click",__payPaneBuyBtnClick);
            _rankingItems[i].payPaneAskBtn.removeEventListener("click",payPaneAskHander);
            i++;
         }
      }
      
      private function payPaneAskHander(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         var cell:ShopRankingCellItem = e.currentTarget.parent as ShopRankingCellItem;
         var shopItemInfo:ShopItemInfo = cell.shopItemInfo;
         if(shopItemInfo && shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            if(shopItemInfo.isDiscount == 2 && ShopManager.Instance.getDisCountShopItemByGoodsID(shopItemInfo.GoodsID) == null)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.shop.discount.exit"));
               return;
            }
            ShopBuyManager.Instance.buy(shopItemInfo.GoodsID,shopItemInfo.isDiscount,3);
         }
      }
      
      private function __payPaneGivingBtnClick(event:Event) : void
      {
         event.stopImmediatePropagation();
         var item:ShopRankingCellItem = event.currentTarget.parent as ShopRankingCellItem;
         if(item.shopItemInfo && item.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(item.shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            ShopGiftsManager.Instance.buy(item.shopItemInfo.GoodsID,false,2);
            var _loc5_:int = 0;
            var _loc4_:* = _rankingItems;
            for each(var j in _rankingItems)
            {
               j.selected = false;
            }
            item.selected = true;
         }
      }
      
      private function __payPaneBuyBtnClick(event:Event) : void
      {
         event.stopImmediatePropagation();
         var item:ShopRankingCellItem = event.currentTarget.parent as ShopRankingCellItem;
         if(item.shopItemInfo && item.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(item.shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            ShopBuyManager.Instance.buy(item.shopItemInfo.GoodsID);
            var _loc5_:int = 0;
            var _loc4_:* = _rankingItems;
            for each(var j in _rankingItems)
            {
               j.selected = false;
            }
            item.selected = true;
         }
      }
      
      protected function __shopSearchTextKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            __shopSearchBtnClick();
         }
      }
      
      protected function __shopSearchTextFousIn(event:FocusEvent) : void
      {
         if(_shopSearchText.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText"))
         {
            _shopSearchText.text = "";
         }
      }
      
      protected function __shopSearchTextFousOut(event:FocusEvent) : void
      {
         if(_shopSearchText.text.length == 0)
         {
            _shopSearchText.text = LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText");
         }
      }
      
      protected function __shopSearchBtnClick(event:MouseEvent = null) : void
      {
         var list:* = undefined;
         SoundManager.instance.play("008");
         if(_shopSearchText.text == LanguageMgr.GetTranslation("shop.view.ShopRankingView.shopSearchText") || _shopSearchText.text.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.ShopRankingView.PleaseEnterTheKeywords"));
            return;
         }
         if(_currentShopSearchText != _shopSearchText.text)
         {
            _currentShopSearchText = _shopSearchText.text;
            list = ShopManager.Instance.getDesignatedAllShopItem();
            list = ShopManager.Instance.fuzzySearch(list,_currentShopSearchText);
            _currentList = list;
         }
         else
         {
            list = _currentList;
         }
         if(list.length > 0)
         {
            _controller.rightView.searchList(list);
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
         var popularityRankingType:Array = [85,86];
         var sex:int = _controller.rightView.genderGroup.selectIndex;
         return int(popularityRankingType[sex]);
      }
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         clearitems();
         for(i = 0; i < 5; )
         {
            if(i < list.length && list[i])
            {
               _rankingItems[i].shopItemInfo = list[i];
            }
            i++;
         }
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            _rankingItems[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function __itemClick(evt:MouseEvent) : void
      {
         var isAdd:Boolean = false;
         var sexId:int = 0;
         var shopItem:* = null;
         var isColorEditorVisble:Boolean = false;
         var item:ShopRankingCellItem = evt.currentTarget.parent as ShopRankingCellItem;
         if(!item.shopItemInfo)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(item.shopItemInfo.LimitCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.countOver"));
            return;
         }
         if(_controller.model.isOverCount(item.shopItemInfo))
         {
            var _loc10_:int = 0;
            var _loc9_:* = _rankingItems;
            for each(var i in _rankingItems)
            {
               i.selected = i == item;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.GoodsNumberLimit"));
            return;
         }
         if(item.shopItemInfo && item.shopItemInfo.TemplateInfo)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _rankingItems;
            for each(var j in _rankingItems)
            {
               j.selected = j == item;
            }
            if(EquipType.dressAble(item.shopItemInfo.TemplateInfo))
            {
               sexId = item.shopItemInfo.TemplateInfo.NeedSex != 2?0:1;
               if(item.shopItemInfo.TemplateInfo.NeedSex != 0 && _controller.rightView.genderGroup.selectIndex != sexId)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.changeColor.sexAlert"));
                  return;
               }
               _controller.addTempEquip(item.shopItemInfo);
            }
            else
            {
               shopItem = new ShopCarItemInfo(item.shopItemInfo.GoodsID,item.shopItemInfo.TemplateID);
               ObjectUtils.copyProperties(shopItem,item.shopItemInfo);
               isAdd = _controller.addToCar(shopItem);
            }
            isColorEditorVisble = _controller.leftView.getColorEditorVisble();
            if(isAdd && !isColorEditorVisble)
            {
               addCartEffects(item.itemCell);
            }
         }
      }
      
      private function addCartEffects($item:DisplayObject) : void
      {
         var tp:* = null;
         var timeline:* = null;
         var tw:* = null;
         var tw1:* = null;
         if(!$item)
         {
            return;
         }
         var tempBitmapD:BitmapData = new BitmapData($item.width,$item.height,true,0);
         tempBitmapD.draw($item);
         var bitmap:Bitmap = new Bitmap(tempBitmapD,"auto",true);
         parent.addChild(bitmap);
         tp = TweenProxy.create(bitmap);
         tp.registrationX = tp.width / 2;
         tp.registrationY = tp.height / 2;
         var pos:Point = DisplayUtils.localizePoint(parent,$item);
         tp.x = pos.x + tp.width / 2;
         tp.y = pos.y + tp.height / 2;
         timeline = new TimelineLite();
         timeline.vars.onComplete = twComplete;
         timeline.vars.onCompleteParams = [timeline,tp,bitmap];
         tw = new TweenLite(tp,0.3,{
            "x":220,
            "y":430
         });
         tw1 = new TweenLite(tp,0.3,{
            "scaleX":0.1,
            "scaleY":0.1
         });
         timeline.append(tw);
         timeline.append(tw1,-0.2);
      }
      
      private function twComplete(timeline:TimelineLite, tp:TweenProxy, bitmap:Bitmap) : void
      {
         if(timeline)
         {
            timeline.kill();
         }
         if(tp)
         {
            tp.destroy();
         }
         if(bitmap.parent)
         {
            bitmap.parent.removeChild(bitmap);
            bitmap.bitmapData.dispose();
         }
         tp = null;
         bitmap = null;
         timeline = null;
      }
      
      protected function __rankingItemsMouseOver(event:MouseEvent) : void
      {
         var item:ShopRankingCellItem = event.currentTarget.parent as ShopRankingCellItem;
         item.setItemLight(_rankingLightMc);
         item.mouseOver();
      }
      
      protected function __rankingItemsMouseOut(event:MouseEvent) : void
      {
         var item:ShopRankingCellItem = event.currentTarget.parent as ShopRankingCellItem;
         item.mouseOut();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         if(_separator)
         {
            for(i = 0; i < _separator.length; )
            {
               if(_separator[i])
               {
                  ObjectUtils.disposeObject(_separator[i]);
               }
               _separator[i] = null;
               i++;
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
