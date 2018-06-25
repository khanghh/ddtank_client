package giftSystem.view
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ShopType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import giftSystem.GiftEvent;
   import giftSystem.GiftManager;
   import giftSystem.element.TurnPage;
   
   public class GiftShopView extends Sprite implements Disposeable
   {
      
      public static const HOT_GOODS:int = 0;
      
      public static const FLOWER:int = 1;
      
      public static const DESSERT:int = 2;
      
      public static const TOY:int = 3;
      
      public static const RARE:int = 4;
      
      public static const FESTIVAL:int = 5;
      
      public static const WEDDING:int = 6;
      
      public static var CURRENT_MONEY_TYPE:int = 1;
       
      
      private var _title:Bitmap;
      
      private var _BG1:MovieImage;
      
      private var _BG2:MutipleImage;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hotGoodsBtn:SelectedTextButton;
      
      private var _flowerBtn:SelectedTextButton;
      
      private var _dessertBtn:SelectedTextButton;
      
      private var _toyBtn:SelectedTextButton;
      
      private var _rareBtn:SelectedTextButton;
      
      private var _festivalBtn:SelectedTextButton;
      
      private var _weddingBtn:SelectedTextButton;
      
      private var _prompt:FilterFrameText;
      
      private var _turnPage:TurnPage;
      
      private var _goodsList:GiftGoodsListView;
      
      private var _thisShine:IEffect;
      
      private var container:Sprite;
      
      private var _shopMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopDDTMoneySelectedCkBtn:SelectedCheckButton;
      
      private var _shopMoneyGroup:SelectedButtonGroup;
      
      private var _moneyBg:Bitmap;
      
      private var time:Timer;
      
      public function GiftShopView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         container = new Sprite();
         _BG1 = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.BG1");
         _BG2 = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.BG2");
         _title = ComponentFactory.Instance.creatBitmap("asset.giftShop.title");
         _hotGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.hotGoods");
         _hotGoodsBtn.text = LanguageMgr.GetTranslation("shop.ShopRightView.TopBtn.recommend");
         _flowerBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.flower");
         _flowerBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.xianhua");
         _dessertBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.dessert");
         _dessertBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.dianxin");
         _toyBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.toy");
         _toyBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.wanju");
         _rareBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.rare");
         _rareBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.xiyou");
         _festivalBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.festival");
         _festivalBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.jieri");
         _weddingBtn = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.wedding");
         _weddingBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.shop.hunqing");
         _prompt = ComponentFactory.Instance.creatComponentByStylename("GiftShopView.prompt");
         _turnPage = ComponentFactory.Instance.creatCustomObject("turnPage");
         _goodsList = ComponentFactory.Instance.creatCustomObject("giftGoodListView");
         _btnGroup = new SelectedButtonGroup();
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ddtgiftSystem.Preview.ruleview.hbox");
         _btnGroup.addSelectItem(_hotGoodsBtn);
         _btnGroup.addSelectItem(_flowerBtn);
         _btnGroup.addSelectItem(_dessertBtn);
         _btnGroup.addSelectItem(_toyBtn);
         _btnGroup.addSelectItem(_rareBtn);
         _btnGroup.addSelectItem(_festivalBtn);
         _btnGroup.addSelectItem(_weddingBtn);
         if(GiftManager.Instance.inChurch)
         {
            _btnGroup.selectIndex = 6;
         }
         else
         {
            _btnGroup.selectIndex = 0;
         }
         addChild(container);
         container.addChild(_BG1);
         addChild(_BG2);
         container.addChild(_title);
         addChild(_hbox);
         _hbox.addChild(_hotGoodsBtn);
         _hbox.addChild(_flowerBtn);
         _hbox.addChild(_dessertBtn);
         _hbox.addChild(_toyBtn);
         _hbox.addChild(_rareBtn);
         _hbox.addChild(_festivalBtn);
         _hbox.addChild(_weddingBtn);
         addChild(_prompt);
         addChild(_turnPage);
         addChild(_goodsList);
         var data:Object = {};
         data["blurWidth"] = 12;
         data["color"] = "gold";
         _thisShine = EffectManager.Instance.creatEffect(3,container,data);
         _thisShine.stop();
         _prompt.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftShopView.chooseGiftForFriend");
         __changeHandler(null);
         _moneyBg = ComponentFactory.Instance.creatBitmap("asset.giftShop.moneybg");
         _shopMoneySelectedCkBtn = ComponentFactory.Instance.creatComponentByStylename("giftShop.moneySelectedCkBtn");
         _shopDDTMoneySelectedCkBtn = ComponentFactory.Instance.creatComponentByStylename("giftShop.ddtMoneySelectedCkBtn");
         _shopMoneyGroup = new SelectedButtonGroup();
         _shopMoneyGroup.addSelectItem(_shopMoneySelectedCkBtn);
         _shopMoneyGroup.addSelectItem(_shopDDTMoneySelectedCkBtn);
         _shopMoneyGroup.selectIndex = CURRENT_MONEY_TYPE - 1;
      }
      
      private function initEvent() : void
      {
         _hotGoodsBtn.addEventListener("click",__soundPlay);
         _flowerBtn.addEventListener("click",__soundPlay);
         _dessertBtn.addEventListener("click",__soundPlay);
         _toyBtn.addEventListener("click",__soundPlay);
         _rareBtn.addEventListener("click",__soundPlay);
         _festivalBtn.addEventListener("click",__soundPlay);
         _weddingBtn.addEventListener("click",__soundPlay);
         _btnGroup.addEventListener("change",__changeHandler);
         _turnPage.addEventListener("currentPageChange",__upView);
         GiftManager.Instance.addEventListener("rebackGift",__showLight);
         _shopMoneyGroup.addEventListener("change",__moneySelectBtnChangeHandler);
      }
      
      private function __moneySelectBtnChangeHandler(e:Event) : void
      {
         var idx:int = _shopMoneyGroup.selectIndex + 1;
         if(CURRENT_MONEY_TYPE == idx)
         {
            return;
         }
         CURRENT_MONEY_TYPE = idx;
         __upView(null);
         SoundManager.instance.play("008");
      }
      
      private function __showLight(event:GiftEvent) : void
      {
         _thisShine.play();
         time = new Timer(4500,1);
         time.start();
         time.addEventListener("timerComplete",__timeOver);
      }
      
      private function __timeOver(event:TimerEvent) : void
      {
         time.removeEventListener("timerComplete",__timeOver);
         _thisShine.stop();
      }
      
      private function __changeHandler(event:Event) : void
      {
         _turnPage.current = 1;
         _turnPage.total = ShopManager.Instance.getResultPages(getType(),6);
         __upView(null);
         _hbox.arrange();
      }
      
      private function __upView(evt:Event) : void
      {
         _goodsList.setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),_turnPage.current,6));
      }
      
      private function removeEvent() : void
      {
         _hotGoodsBtn.removeEventListener("click",__soundPlay);
         _flowerBtn.removeEventListener("click",__soundPlay);
         _dessertBtn.removeEventListener("click",__soundPlay);
         _toyBtn.removeEventListener("click",__soundPlay);
         _rareBtn.removeEventListener("click",__soundPlay);
         _festivalBtn.removeEventListener("click",__soundPlay);
         _weddingBtn.removeEventListener("click",__soundPlay);
         _btnGroup.removeEventListener("change",__changeHandler);
         _turnPage.removeEventListener("currentPageChange",__upView);
         GiftManager.Instance.removeEventListener("rebackGift",__showLight);
         if(time)
         {
            time.removeEventListener("timerComplete",__timeOver);
         }
         _shopMoneyGroup.removeEventListener("change",__moneySelectBtnChangeHandler);
      }
      
      private function getType() : int
      {
         var shopType:Array = CURRENT_MONEY_TYPE == 2?ShopType.GIFT_DDTMONEY_TYPE:ShopType.GIFT_MONEY_TYPE;
         return _btnGroup.selectIndex > -1?shopType[_btnGroup.selectIndex]:-1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         time = null;
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
         if(container)
         {
            ObjectUtils.disposeObject(container);
         }
         container = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_BG1)
         {
            ObjectUtils.disposeObject(_BG1);
         }
         _BG1 = null;
         if(_BG2)
         {
            ObjectUtils.disposeObject(_BG2);
         }
         _BG2 = null;
         if(_hotGoodsBtn)
         {
            ObjectUtils.disposeObject(_hotGoodsBtn);
         }
         _hotGoodsBtn = null;
         if(_flowerBtn)
         {
            ObjectUtils.disposeObject(_flowerBtn);
         }
         _flowerBtn = null;
         if(_dessertBtn)
         {
            ObjectUtils.disposeObject(_dessertBtn);
         }
         _dessertBtn = null;
         if(_toyBtn)
         {
            ObjectUtils.disposeObject(_toyBtn);
         }
         _toyBtn = null;
         if(_rareBtn)
         {
            ObjectUtils.disposeObject(_rareBtn);
         }
         _rareBtn = null;
         if(_festivalBtn)
         {
            ObjectUtils.disposeObject(_festivalBtn);
         }
         _festivalBtn = null;
         if(_weddingBtn)
         {
            ObjectUtils.disposeObject(_weddingBtn);
         }
         _weddingBtn = null;
         if(_prompt)
         {
            ObjectUtils.disposeObject(_prompt);
         }
         _prompt = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_thisShine)
         {
            EffectManager.Instance.removeEffect(_thisShine);
         }
         _thisShine = null;
         if(_goodsList)
         {
            ObjectUtils.disposeObject(_goodsList);
         }
         _goodsList = null;
         if(_turnPage)
         {
            ObjectUtils.disposeObject(_turnPage);
         }
         _turnPage = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
   }
}
