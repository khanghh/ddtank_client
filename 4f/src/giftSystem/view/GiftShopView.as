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
      
      public function GiftShopView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __moneySelectBtnChangeHandler(param1:Event) : void{}
      
      private function __showLight(param1:GiftEvent) : void{}
      
      private function __timeOver(param1:TimerEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __upView(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function getType() : int{return 0;}
      
      public function dispose() : void{}
      
      protected function __soundPlay(param1:MouseEvent) : void{}
   }
}
