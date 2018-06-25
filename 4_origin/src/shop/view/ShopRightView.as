package shop.view
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.TweenProxy;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.ShopType;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.ShopController;
   import trainer.view.NewHandContainer;
   
   public class ShopRightView extends Sprite implements Disposeable
   {
      
      public static const TOP_RECOMMEND:uint = 0;
      
      public static const SHOP_ITEM_NUM:uint = 8;
      
      public static var CURRENT_GENDER:int = -1;
      
      public static var CURRENT_MONEY_TYPE:int = 1;
      
      public static var CURRENT_PAGE:int = 1;
      
      public static var TOP_TYPE:int = 0;
      
      public static var SUB_TYPE:int = 2;
      
      public static const SHOW_LIGHT:String = "SHOW_LIGHT";
      
      private static var isDiscountType:Boolean = false;
       
      
      private var _bg:Image;
      
      private var _bg1:Bitmap;
      
      private var _controller:ShopController;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _femaleBtn:SelectedButton;
      
      private var _genderContainer:VBox;
      
      private var _genderGroup:SelectedButtonGroup;
      
      private var _rightViewTitleBg:Bitmap;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _goodItemContainerBg:Image;
      
      private var _goodItemContainerTwoLine:Image;
      
      private var _goodItemGroup:SelectedButtonGroup;
      
      private var _goodItems:Vector.<ShopGoodItem>;
      
      private var _maleBtn:SelectedButton;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _subBtns:Vector.<SelectedTextButton>;
      
      private var _subBtnsContainers:Vector.<HBox>;
      
      private var _subBtnsGroups:Vector.<SelectedButtonGroup>;
      
      private var _currentSubBtnContainerIndex:int;
      
      private var _topBtns:Vector.<SelectedTextButton>;
      
      private var _topBtnsContainer:HBox;
      
      private var _topBtnsGroup:SelectedButtonGroup;
      
      private var _shopSearchBox:Sprite;
      
      private var _shopSearchEndBtnBg:Bitmap;
      
      private var _shopSearchColseBtn:BaseButton;
      
      private var _rightItemLightMc:MovieClip;
      
      private var _shopMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopDDTMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopMoneyGroup:SelectedButtonGroup;
      
      private var _moneyBg:Bitmap;
      
      private var _moneySeperateLine:Image;
      
      private var _tempTopType:int = -1;
      
      private var _tempCurrentPage:int = -1;
      
      private var _tempSubBtnHBox:HBox;
      
      private var _isSearch:Boolean;
      
      private var _searchShopItemList:Vector.<ShopItemInfo>;
      
      private var _searchItemTotalPage:int;
      
      public function ShopRightView()
      {
         super();
      }
      
      public function get genderGroup() : SelectedButtonGroup
      {
         return _genderGroup;
      }
      
      public function setup(controller:ShopController) : void
      {
         _controller = controller;
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("ddtshop.RightViewBg");
         addChild(_bg);
         _rightViewTitleBg = ComponentFactory.Instance.creatBitmap("asset.ddtshop.RightViewTitleBg");
         addChild(_rightViewTitleBg);
         initBtns();
         initEvent();
         if(CURRENT_GENDER < 0)
         {
            setCurrentSex(!!PlayerManager.Instance.Self.Sex?1:2);
         }
      }
      
      private function initBtns() : void
      {
         var k:uint = 0;
         var i:uint = 0;
         _topBtns = new Vector.<SelectedTextButton>();
         _topBtnsGroup = new SelectedButtonGroup();
         _subBtns = new Vector.<SelectedTextButton>();
         _subBtnsContainers = new Vector.<HBox>();
         _subBtnsGroups = new Vector.<SelectedButtonGroup>();
         _genderGroup = new SelectedButtonGroup();
         _goodItems = new Vector.<ShopGoodItem>();
         _goodItemGroup = new SelectedButtonGroup();
         _firstPage = ComponentFactory.Instance.creat("ddtshop.BtnFirstPage");
         _prePageBtn = ComponentFactory.Instance.creat("ddtshop.BtnPrePage");
         _nextPageBtn = ComponentFactory.Instance.creat("ddtshop.BtnNextPage");
         _endPageBtn = ComponentFactory.Instance.creat("ddtshop.BtnEndPage");
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CurrentPage");
         _currentPageInput = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CurrentPageInput");
         _topBtnsContainer = ComponentFactory.Instance.creat("ddtshop.TopBtnContainer");
         var topBtnStyleName:Array = ["ddtshop.TopBtnRecommend","ddtshop.TopBtnEquipment","ddtshop.TopBtnBeautyup","ddtshop.TopBtnProp","ddtshop.TopBtnDisCount"];
         var topBtnTextTranslation:Array = ["shop.ShopRightView.TopBtn.recommend","shop.ShopRightView.TopBtn.equipment","shop.ShopRightView.TopBtn.beautyup","shop.ShopRightView.TopBtn.prop","shop.ShopRightView.TopBtn.discount"];
         topBtnStyleName.forEach(function(pItem:*, pIndex:int, pArray:Array):void
         {
            var btn:SelectedTextButton = ComponentFactory.Instance.creat(pItem as String);
            btn.text = LanguageMgr.GetTranslation(topBtnTextTranslation[pIndex]);
            _topBtns.push(btn);
         });
         _genderContainer = ComponentFactory.Instance.creat("ddtshop.GenderBtnContainer");
         _maleBtn = ComponentFactory.Instance.creat("ddtshop.GenderBtnMale");
         _femaleBtn = ComponentFactory.Instance.creat("ddtshop.GenderBtnFemale");
         _rightItemLightMc = ComponentFactory.Instance.creatCustomObject("ddtshop.RightItemLightMc");
         _goodItemContainerBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemContainerBg");
         _goodItemContainerTwoLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.TwoLine");
         _goodItemContainerAll = ComponentFactory.Instance.creatCustomObject("ddtshop.GoodItemContainerAll");
         for(i = 0; i < 8; )
         {
            _goodItems[i] = ComponentFactory.Instance.creatCustomObject("ddtshop.GoodItem");
            var dx:Number = _goodItems[i].width;
            var dy:Number = _goodItems[i].height;
            dx = dx * (int(i % 2));
            dy = dy * (int(i / 2));
            _goodItems[i].x = dx;
            _goodItems[i].y = dy + i / 2 * 2;
            _goodItemContainerAll.addChild(_goodItems[i]);
            _goodItems[i].setItemLight(_rightItemLightMc);
            _goodItems[i].addEventListener("itemClick",__itemClick);
            _goodItems[i].addEventListener("itemSelect",__itemSelect);
            i = Number(i) + 1;
         }
         var _loc2_:Boolean = false;
         _femaleBtn.displacement = _loc2_;
         _maleBtn.displacement = _loc2_;
         _genderContainer.addChild(_femaleBtn);
         _genderContainer.addChild(_maleBtn);
         _genderGroup.addSelectItem(_maleBtn);
         _genderGroup.addSelectItem(_femaleBtn);
         for(i = 0; i < _topBtns.length; )
         {
            _topBtns[i].addEventListener("click",__topBtnClick);
            _topBtnsContainer.addChild(_topBtns[i]);
            _topBtnsGroup.addSelectItem(_topBtns[i]);
            if(i == 0)
            {
               _topBtnsGroup.selectIndex = i;
            }
            _subBtnsGroups[i] = new SelectedButtonGroup();
            i = Number(i) + 1;
         }
         _subBtnsContainers.push(ComponentFactory.Instance.creat("ddtshop.SubBtnContainerRecommend"));
         _subBtnsContainers.push(ComponentFactory.Instance.creat("ddtshop.SubBtnContainerEquipment"));
         _subBtnsContainers.push(ComponentFactory.Instance.creat("ddtshop.SubBtnContainerBeautyup"));
         _subBtnsContainers.push(ComponentFactory.Instance.creat("ddtshop.SubBtnContainerProp"));
         _subBtnsContainers.push(ComponentFactory.Instance.creat("ddtshop.SubBtnContainerExchange"));
         var subBtnStyleName:Array = ["ddtshop.SubBtnHotSaleIcon","ddtshop.SubBtnRecommend","ddtshop.SubBtnDiscount","ddtshop.SubBtnGiftMedalWeapon","ddtshop.SubBtnCloth","ddtshop.SubBtnHat","ddtshop.SubBtnGlasses","ddtshop.SubBtnRing","ddtshop.SubBtnHair","ddtshop.SubBtnEye","ddtshop.SubBtnFace","ddtshop.SubBtnSuit","ddtshop.SubBtnWing","ddtshop.SubBtnFunc","ddtshop.SubBtnSpecial","ddtshop.SubBtnGiftMedalAll"];
         var subBtnTextTranslation:Array = ["shop.ShopRightView.SubBtn.hotSale","shop.ShopRightView.SubBtn.recommend","shop.ShopRightView.SubBtn.discount","shop.ShopRightView.SubBtn.weapon","shop.ShopRightView.SubBtn.cloth","shop.ShopRightView.SubBtn.hat","shop.ShopRightView.SubBtn.glasses","shop.ShopRightView.SubBtn.ring","shop.ShopRightView.SubBtn.hair","shop.ShopRightView.SubBtn.eye","shop.ShopRightView.SubBtn.face","shop.ShopRightView.SubBtn.suit","shop.ShopRightView.SubBtn.wing","shop.ShopRightView.SubBtn.func","shop.ShopRightView.SubBtn.special","shop.ShopRightView.SubBtn.giftMedalAll"];
         subBtnStyleName.forEach(function(pItem:*, pIndex:int, pArray:Array):void
         {
            var btn:SelectedTextButton = ComponentFactory.Instance.creat(pItem as String);
            btn.text = LanguageMgr.GetTranslation(subBtnTextTranslation[pIndex]);
            _subBtns.push(btn);
         });
         var controlArr:Array = [3,8,13,15];
         k = 0;
         for(i = 0; i < _subBtns.length; )
         {
            if(i == controlArr[k])
            {
               k = Number(k) + 1;
            }
            if(_subBtnsContainers[k] == null)
            {
               k = Number(k) + 1;
            }
            _subBtns[i].addEventListener("click",__subBtnClick);
            _subBtnsContainers[k].addChild(_subBtns[i]);
            _subBtnsGroups[k].addSelectItem(_subBtns[i]);
            if(i == 0)
            {
               _subBtnsGroups[k].selectIndex = i;
            }
            _subBtnsGroups[k].addEventListener("change",subButtonSelectedChangeHandler);
            i = Number(i) + 1;
         }
         addChild(_firstPage);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_endPageBtn);
         addChild(_currentPageInput);
         addChild(_currentPageTxt);
         addChild(_genderContainer);
         addChild(_goodItemContainerBg);
         addChild(_goodItemContainerTwoLine);
         addChild(_goodItemContainerAll);
         addChild(_topBtnsContainer);
         for(i = 0; i < _subBtnsContainers.length; )
         {
            if(_subBtnsContainers[i])
            {
               addChild(_subBtnsContainers[i]);
               _subBtnsContainers[i].visible = false;
               if(i == 0)
               {
                  _subBtnsContainers[i].visible = true;
               }
            }
            i = Number(i) + 1;
         }
         _shopSearchBox = ComponentFactory.Instance.creatCustomObject("ddtshop.SearchBox");
         _shopSearchEndBtnBg = ComponentFactory.Instance.creatBitmap("asset.ddtshop.SearchResultImage");
         _shopSearchBox.addChild(_shopSearchEndBtnBg);
         _shopSearchColseBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.ShopSearchColseBtn");
         _shopSearchBox.addChild(_shopSearchColseBtn);
         addChild(_shopSearchBox);
         _shopSearchBox.visible = false;
         _moneyBg = ComponentFactory.Instance.creatBitmap("asset.shop.moneybg");
         addChild(_moneyBg);
         _moneySeperateLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.moneySeperateLine");
         addChild(_moneySeperateLine);
         _shopMoneySelectedCkBtn = ComponentFactory.Instance.creatComponentByStylename("ddtShop.moneySelectedCkBtn");
         _shopDDTMoneySelectedCkBtn = ComponentFactory.Instance.creatComponentByStylename("ddtShop.ddtMoneySelectedCkBtn");
         _shopMoneyGroup = new SelectedButtonGroup();
         _shopMoneyGroup.addSelectItem(_shopMoneySelectedCkBtn);
         _shopMoneyGroup.addSelectItem(_shopDDTMoneySelectedCkBtn);
         addChild(_shopMoneySelectedCkBtn);
         addChild(_shopDDTMoneySelectedCkBtn);
         _shopMoneyGroup.selectIndex = CURRENT_MONEY_TYPE - 1;
         if(CURRENT_MONEY_TYPE == 2 && TOP_TYPE == 0)
         {
            SUB_TYPE = 0;
         }
         _currentSubBtnContainerIndex = SUB_TYPE;
         updateBtn();
         _topBtnsContainer.arrange();
      }
      
      private function updateBtn() : void
      {
         if(_topBtns)
         {
            _topBtns[4].visible = false;
         }
         if(!_topBtns[4].visible)
         {
            if(TOP_TYPE == 4)
            {
               TOP_TYPE = 0;
               SUB_TYPE = CURRENT_MONEY_TYPE == 1?2:0;
               isDiscountType = false;
               _topBtnsGroup.selectIndex = TOP_TYPE;
               showSubBtns(TOP_TYPE);
            }
         }
      }
      
      private function subButtonSelectedChangeHandler(evt:Event) : void
      {
         _subBtnsContainers[_currentSubBtnContainerIndex].arrange();
      }
      
      private function initEvent() : void
      {
         _topBtnsGroup.addEventListener("change",__topBtnChangeHandler);
         _maleBtn.addEventListener("click",__genderClick);
         _femaleBtn.addEventListener("click",__genderClick);
         _firstPage.addEventListener("click",__pageBtnClick);
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
         _shopSearchColseBtn.addEventListener("click",__shopSearchColseBtnClick);
         addEventListener("addedToStage",__userGuide);
         _shopMoneyGroup.addEventListener("change",__moneySelectBtnChangeHandler);
      }
      
      protected function __moneySelectBtnChangeHandler(e:Event) : void
      {
         var idx:int = _shopMoneyGroup.selectIndex + 1;
         if(CURRENT_MONEY_TYPE == idx)
         {
            return;
         }
         if(!_isSearch)
         {
            CURRENT_PAGE = 1;
         }
         CURRENT_MONEY_TYPE = idx;
         if(!ShopManager.Instance.isHasDisCountGoods(CURRENT_MONEY_TYPE) && TOP_TYPE == 4)
         {
            TOP_TYPE = 0;
            _topBtnsGroup.selectIndex = 0;
            showSubBtns(TOP_TYPE);
            SUB_TYPE = 0;
            _subBtnsGroups[TOP_TYPE].selectIndex = 0;
            isDiscountType = false;
         }
         if(idx == 2 && TOP_TYPE == 0)
         {
            SUB_TYPE = 0;
            _subBtnsGroups[TOP_TYPE].selectIndex = 0;
         }
         updateBtn();
         loadList();
         SoundManager.instance.play("008");
      }
      
      protected function __topBtnChangeHandler(event:Event) : void
      {
         _topBtnsContainer.arrange();
      }
      
      private function __userGuide(evt:Event) : void
      {
         removeEventListener("addedToStage",__userGuide);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(73) && PlayerManager.Instance.Self.Grade >= 9)
         {
            NewHandContainer.Instance.showArrow(17,180,"trainer.shopGiftArrowPos","asset.trainer.txtShopGift","trainer.shopGiftTipPos",null,5);
         }
      }
      
      private function reoveArrow() : void
      {
         NewHandContainer.Instance.clearArrowByID(17);
      }
      
      protected function __shopSearchColseBtnClick(event:MouseEvent) : void
      {
         _isSearch = false;
         _shopSearchBox.visible = false;
         TOP_TYPE = _tempTopType;
         _tempTopType = -1;
         _topBtnsGroup.selectIndex = TOP_TYPE;
         if(!_tempSubBtnHBox)
         {
            _tempSubBtnHBox = _subBtnsContainers[0];
         }
         _tempSubBtnHBox.visible = true;
         CURRENT_PAGE = _tempCurrentPage;
         _tempCurrentPage = -1;
         if(TOP_TYPE == 0 && CURRENT_MONEY_TYPE == 2)
         {
            SUB_TYPE = 0;
            _subBtnsGroups[TOP_TYPE].selectIndex = 0;
         }
         loadList();
         SoundManager.instance.play("008");
      }
      
      public function loadList() : void
      {
         if(_isSearch)
         {
            return;
         }
         if(!isDiscountType)
         {
            setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),CURRENT_PAGE));
         }
         else
         {
            setList(ShopManager.Instance.getDisCountGoods(CURRENT_MONEY_TYPE,CURRENT_PAGE));
         }
      }
      
      private function getType() : int
      {
         var shopType:Array = [];
         if(CURRENT_MONEY_TYPE == 1)
         {
            shopType = CURRENT_GENDER == 1?ShopType.MALE_MONEY_TYPE:ShopType.FEMALE_MONEY_TYPE;
            _subBtns[1].visible = true;
            _subBtns[2].visible = true;
         }
         else if(CURRENT_MONEY_TYPE == 2)
         {
            shopType = CURRENT_GENDER == 1?ShopType.MALE_DDTMONEY_TYPE:ShopType.FEMALE_DDTMONEY_TYPE;
            _subBtns[1].visible = false;
            _subBtns[2].visible = false;
         }
         var result:* = shopType[TOP_TYPE];
         if(result is Array && SUB_TYPE > -1)
         {
            result = result[SUB_TYPE];
         }
         return int(result);
      }
      
      public function setCurrentSex(sex:int) : void
      {
         CURRENT_GENDER = sex;
         _genderGroup.selectIndex = CURRENT_GENDER - 1;
      }
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         clearitems();
         for(i = 0; i < 8; )
         {
            _goodItems[i].selected = false;
            if(list)
            {
               if(i < list.length && list[i])
               {
                  _goodItems[i].shopItemInfo = list[i];
               }
               i++;
               continue;
            }
            break;
         }
         if(!isDiscountType)
         {
            _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getResultPages(getType());
         }
         else
         {
            _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE);
         }
      }
      
      public function searchList($list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         var hBox:* = null;
         if(_searchShopItemList == $list && _isSearch)
         {
            return;
         }
         _searchShopItemList = $list;
         if(!_isSearch)
         {
            _tempTopType = TOP_TYPE;
            _tempCurrentPage = CURRENT_PAGE;
         }
         _isSearch = true;
         TOP_TYPE = -1;
         _topBtnsGroup.selectIndex = -1;
         _topBtnsContainer.arrange();
         CURRENT_PAGE = 1;
         for(i = 0; i < _subBtnsContainers.length; )
         {
            hBox = _subBtnsContainers[i] as HBox;
            if(hBox)
            {
               hBox.visible = false;
            }
            i++;
         }
         _shopSearchBox.visible = true;
         runSearch();
      }
      
      private function runSearch() : void
      {
         var startIndex:int = 0;
         var len:int = 0;
         var i:int = 0;
         clearitems();
         _searchItemTotalPage = Math.ceil(_searchShopItemList.length / 8);
         if(CURRENT_PAGE > 0 && CURRENT_PAGE <= _searchItemTotalPage)
         {
            startIndex = 8 * (CURRENT_PAGE - 1);
            len = Math.min(_searchShopItemList.length - startIndex,8);
            for(i = 0; i < len; )
            {
               _goodItems[i].selected = false;
               if(_searchShopItemList[i + startIndex])
               {
                  _goodItems[i].shopItemInfo = _searchShopItemList[i + startIndex];
               }
               i++;
            }
         }
         _currentPageTxt.text = CURRENT_PAGE + "/" + _searchItemTotalPage;
      }
      
      private function __genderClick(evt:MouseEvent) : void
      {
         var idx:int = evt.currentTarget as SelectedButton == _maleBtn?1:2;
         if(CURRENT_GENDER == idx)
         {
            return;
         }
         setCurrentSex(idx);
         if(!_isSearch)
         {
            CURRENT_PAGE = 1;
         }
         _controller.setFittingModel(CURRENT_GENDER == 1);
         SoundManager.instance.play("008");
      }
      
      private function __itemSelect(evt:ItemEvent) : void
      {
         evt.stopImmediatePropagation();
         var item:ShopGoodItem = evt.currentTarget as ShopGoodItem;
         var _loc5_:int = 0;
         var _loc4_:* = _goodItems;
         for each(var j in _goodItems)
         {
            j.selected = false;
         }
         item.selected = true;
      }
      
      private function __itemClick(evt:ItemEvent) : void
      {
         var isAdd:Boolean = false;
         var sexId:int = 0;
         var shopItem:* = null;
         var isColorEditorVisble:Boolean = false;
         var item:ShopGoodItem = evt.currentTarget as ShopGoodItem;
         if(_controller.model.isOverCount(item.shopItemInfo))
         {
            var _loc10_:int = 0;
            var _loc9_:* = _goodItems;
            for each(var i in _goodItems)
            {
               i.selected = i == item;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIModel.GoodsNumberLimit"));
            return;
         }
         if(item.shopItemInfo && item.shopItemInfo.TemplateInfo)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _goodItems;
            for each(var j in _goodItems)
            {
               j.selected = j == item;
            }
            if(EquipType.dressAble(item.shopItemInfo.TemplateInfo))
            {
               sexId = item.shopItemInfo.TemplateInfo.NeedSex != 2?0:1;
               if(item.shopItemInfo.TemplateInfo.NeedSex != 0 && _genderGroup.selectIndex != sexId)
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
            itemClick(item);
            isColorEditorVisble = _controller.leftView.getColorEditorVisble();
            if(isAdd && !isColorEditorVisble)
            {
               addCartEffects(item.itemCell);
            }
         }
         dispatchEvent(new Event("SHOW_LIGHT"));
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
      
      private function itemClick(item:ShopGoodItem) : void
      {
         if(item.shopItemInfo.TemplateInfo != null)
         {
            if(CURRENT_GENDER != item.shopItemInfo.TemplateInfo.NeedSex && item.shopItemInfo.TemplateInfo.NeedSex != 0)
            {
               setCurrentSex(item.shopItemInfo.TemplateInfo.NeedSex);
               _controller.setFittingModel(CURRENT_GENDER == 1);
            }
         }
      }
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_isSearch)
         {
            if(!isDiscountType)
            {
               if(ShopManager.Instance.getResultPages(getType()) == 0)
               {
                  return;
               }
            }
            else if(ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE) == 0)
            {
               return;
            }
            var _loc2_:* = evt.currentTarget;
            if(_firstPage !== _loc2_)
            {
               if(_prePageBtn !== _loc2_)
               {
                  if(_nextPageBtn !== _loc2_)
                  {
                     if(_endPageBtn === _loc2_)
                     {
                        if(!isDiscountType)
                        {
                           if(CURRENT_PAGE != ShopManager.Instance.getResultPages(getType()))
                           {
                              CURRENT_PAGE = ShopManager.Instance.getResultPages(getType());
                           }
                        }
                        else if(CURRENT_PAGE != ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE))
                        {
                           CURRENT_PAGE = ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE);
                        }
                     }
                  }
                  else
                  {
                     if(!isDiscountType)
                     {
                        if(CURRENT_PAGE == ShopManager.Instance.getResultPages(getType()))
                        {
                           CURRENT_PAGE = 0;
                        }
                     }
                     else if(CURRENT_PAGE == ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE))
                     {
                        CURRENT_PAGE = 0;
                     }
                     CURRENT_PAGE = Number(CURRENT_PAGE) + 1;
                  }
               }
               else
               {
                  if(CURRENT_PAGE == 1)
                  {
                     if(!isDiscountType)
                     {
                        CURRENT_PAGE = ShopManager.Instance.getResultPages(getType()) + 1;
                     }
                     else
                     {
                        CURRENT_PAGE = ShopManager.Instance.getDisCountResultPages(CURRENT_MONEY_TYPE) + 1;
                     }
                  }
                  CURRENT_PAGE = Number(CURRENT_PAGE) - 1;
               }
            }
            else if(CURRENT_PAGE != 1)
            {
               CURRENT_PAGE = 1;
            }
            loadList();
         }
         else
         {
            _loc2_ = evt.currentTarget;
            if(_firstPage !== _loc2_)
            {
               if(_prePageBtn !== _loc2_)
               {
                  if(_nextPageBtn !== _loc2_)
                  {
                     if(_endPageBtn === _loc2_)
                     {
                        if(CURRENT_PAGE != _searchItemTotalPage)
                        {
                           CURRENT_PAGE = _searchItemTotalPage;
                        }
                     }
                  }
                  else
                  {
                     if(CURRENT_PAGE == _searchItemTotalPage)
                     {
                        CURRENT_PAGE = 0;
                     }
                     CURRENT_PAGE = Number(CURRENT_PAGE) + 1;
                  }
               }
               else
               {
                  if(CURRENT_PAGE == 1)
                  {
                     CURRENT_PAGE = _searchItemTotalPage + 1;
                  }
                  CURRENT_PAGE = Number(CURRENT_PAGE) - 1;
               }
            }
            else if(CURRENT_PAGE != 1)
            {
               CURRENT_PAGE = 1;
            }
            runSearch();
         }
      }
      
      private function __subBtnClick(event:MouseEvent) : void
      {
         reoveArrow();
         var idx:int = _subBtnsContainers[TOP_TYPE].getChildIndex(event.currentTarget as SelectedButton);
         if(idx != SUB_TYPE)
         {
            SUB_TYPE = idx;
            CURRENT_PAGE = 1;
            loadList();
            SoundManager.instance.play("008");
         }
      }
      
      private function __topBtnClick(event:MouseEvent) : void
      {
         _topBtnsContainer.arrange();
         var idx:int = _topBtns.indexOf(event.currentTarget as SelectedTextButton);
         _isSearch = false;
         _shopSearchBox.visible = false;
         _tempTopType = -1;
         _tempCurrentPage = -1;
         if(idx != TOP_TYPE)
         {
            TOP_TYPE = idx;
            SUB_TYPE = 0;
            CURRENT_PAGE = 1;
            showSubBtns(idx);
            _currentSubBtnContainerIndex = idx;
            if(TOP_TYPE == 4)
            {
               isDiscountType = true;
               if(!PlayerManager.Instance.Self.IsWeakGuildFinish(73) && PlayerManager.Instance.Self.Grade >= 9)
               {
                  NewHandContainer.Instance.clearArrowByID(17);
                  SocketManager.Instance.out.syncWeakStep(73);
               }
            }
            else
            {
               isDiscountType = false;
               disposeUserGuide();
            }
            loadList();
            SoundManager.instance.play("008");
         }
      }
      
      private function disposeUserGuide() : void
      {
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i < 8; )
         {
            _goodItems[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         var i:* = 0;
         _topBtnsGroup.removeEventListener("change",__topBtnChangeHandler);
         _maleBtn.removeEventListener("click",__genderClick);
         _femaleBtn.removeEventListener("click",__genderClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         for(i = uint(0); i < 8; )
         {
            _goodItems[i].removeEventListener("itemClick",__itemClick);
            _goodItems[i].removeEventListener("itemSelect",__itemSelect);
            i++;
         }
         for(i = uint(0); i < _topBtns.length; )
         {
            _topBtns[i].removeEventListener("click",__topBtnClick);
            i++;
         }
         for(i = uint(0); i < _subBtns.length; )
         {
            _subBtns[i].removeEventListener("click",__subBtnClick);
            i++;
         }
         removeEventListener("addedToStage",__userGuide);
         _shopSearchColseBtn.removeEventListener("click",__shopSearchColseBtnClick);
         _shopMoneyGroup.removeEventListener("change",__moneySelectBtnChangeHandler);
      }
      
      private function showSubBtns(topIdx:int) : void
      {
         var i:int = 0;
         var hBox:* = null;
         for(i = 0; i < _subBtnsContainers.length; )
         {
            hBox = _subBtnsContainers[i] as HBox;
            if(hBox)
            {
               hBox.visible = false;
            }
            i++;
         }
         if(_subBtnsContainers[topIdx])
         {
            _subBtnsContainers[topIdx].visible = true;
            _tempSubBtnHBox = _subBtnsContainers[topIdx];
            _subBtnsGroups[topIdx].selectIndex = SUB_TYPE;
            _subBtnsContainers[topIdx].arrange();
         }
      }
      
      public function gotoPage(topType:int = -1, subType:int = -1, currentPage:int = 1, currentGender:int = 1) : void
      {
         var i:int = 0;
         var hBox:* = null;
         if(topType == 4 && !ShopManager.Instance.isHasDisCountGoods(CURRENT_MONEY_TYPE))
         {
            topType = 0;
            subType = 2;
         }
         if(topType != -1)
         {
            TOP_TYPE = topType;
         }
         if(subType != -1)
         {
            SUB_TYPE = subType;
         }
         CURRENT_PAGE = currentPage;
         CURRENT_GENDER = currentGender;
         _topBtnsGroup.selectIndex = TOP_TYPE;
         _subBtnsGroups[TOP_TYPE].selectIndex = SUB_TYPE;
         _genderGroup.selectIndex = CURRENT_GENDER - 1;
         setCurrentSex(CURRENT_GENDER);
         _currentPageTxt.text = CURRENT_PAGE + "/" + _searchItemTotalPage;
         for(i = 0; i < _subBtnsContainers.length; )
         {
            hBox = _subBtnsContainers[i] as HBox;
            if(hBox)
            {
               hBox.visible = false;
            }
            i++;
         }
         if(_subBtnsContainers[TOP_TYPE])
         {
            _subBtnsContainers[TOP_TYPE].visible = true;
            _subBtnsContainers[TOP_TYPE].arrange();
            _tempSubBtnHBox = _subBtnsContainers[TOP_TYPE];
         }
         loadList();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         if(_tempCurrentPage > -1)
         {
            CURRENT_PAGE = _tempCurrentPage;
         }
         if(_tempTopType > -1)
         {
            TOP_TYPE = _tempTopType;
         }
         removeEvent();
         disposeUserGuide();
         ObjectUtils.disposeAllChildren(this);
         if(_currentPageTxt)
         {
            _currentPageTxt.dispose();
         }
         _currentPageTxt = null;
         for(i = 0; i < _goodItems.length; )
         {
            ObjectUtils.disposeObject(_goodItems[i]);
            _goodItems[i] = null;
            i++;
         }
         _goodItems = null;
         for(i = 0; i < _topBtns.length; )
         {
            ObjectUtils.disposeObject(_topBtns[i]);
            _topBtns[i] = null;
            i++;
         }
         _topBtns = null;
         for(i = 0; i < _subBtns.length; )
         {
            ObjectUtils.disposeObject(_subBtns[i]);
            _subBtns[i] = null;
            i++;
         }
         _subBtns = null;
         for(i = 0; i < _subBtnsGroups.length; )
         {
            ObjectUtils.disposeObject(_subBtnsGroups[i]);
            _subBtnsGroups[i] = null;
            ObjectUtils.disposeObject(_subBtnsContainers[i]);
            _subBtnsContainers[i] = null;
            i++;
         }
         _subBtnsContainers = null;
         _subBtnsGroups = null;
         _controller = null;
         _goodItemGroup = null;
         _nextPageBtn = null;
         _prePageBtn = null;
         _topBtnsGroup = null;
         _tempSubBtnHBox = null;
         if(_shopDDTMoneySelectedCkBtn)
         {
            ObjectUtils.disposeObject(_shopDDTMoneySelectedCkBtn);
            _shopDDTMoneySelectedCkBtn = null;
         }
         if(_shopMoneySelectedCkBtn)
         {
            ObjectUtils.disposeObject(_shopMoneySelectedCkBtn);
            _shopMoneySelectedCkBtn = null;
         }
         if(_moneyBg)
         {
            ObjectUtils.disposeObject(_moneyBg);
            _moneyBg = null;
         }
         _shopMoneyGroup = null;
         ObjectUtils.disposeObject(_moneySeperateLine);
         _moneySeperateLine = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_currentPageInput);
         _currentPageInput = null;
         ObjectUtils.disposeObject(_femaleBtn);
         _femaleBtn = null;
         ObjectUtils.disposeObject(_genderContainer);
         _genderContainer = null;
         ObjectUtils.disposeObject(_genderGroup);
         _genderGroup = null;
         ObjectUtils.disposeObject(_rightViewTitleBg);
         _rightViewTitleBg = null;
         ObjectUtils.disposeObject(_goodItemContainerAll);
         _goodItemContainerAll = null;
         ObjectUtils.disposeObject(_maleBtn);
         _maleBtn = null;
         ObjectUtils.disposeObject(_firstPage);
         _firstPage = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_endPageBtn);
         _endPageBtn = null;
         ObjectUtils.disposeObject(_topBtnsContainer);
         _topBtnsContainer = null;
         ObjectUtils.disposeObject(_rightItemLightMc);
         _rightItemLightMc = null;
         ObjectUtils.disposeObject(_shopSearchEndBtnBg);
         _shopSearchEndBtnBg = null;
         ObjectUtils.disposeObject(_shopSearchColseBtn);
         _shopSearchColseBtn = null;
         ObjectUtils.disposeObject(_shopSearchBox);
         _shopSearchBox = null;
         ObjectUtils.disposeObject(_goodItemContainerBg);
         _goodItemContainerBg = null;
         ObjectUtils.disposeObject(_goodItemContainerTwoLine);
         _goodItemContainerTwoLine = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
