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
      
      public function ShopRankingView(){super();}
      
      public function setup(param1:ShopController) : void{}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function payPaneAskHander(param1:MouseEvent) : void{}
      
      private function __payPaneGivingBtnClick(param1:Event) : void{}
      
      private function __payPaneBuyBtnClick(param1:Event) : void{}
      
      protected function __shopSearchTextKeyDown(param1:KeyboardEvent) : void{}
      
      protected function __shopSearchTextFousIn(param1:FocusEvent) : void{}
      
      protected function __shopSearchTextFousOut(param1:FocusEvent) : void{}
      
      protected function __shopSearchBtnClick(param1:MouseEvent = null) : void{}
      
      public function loadList() : void{}
      
      private function getType() : int{return 0;}
      
      public function setList(param1:Vector.<ShopItemInfo>) : void{}
      
      private function clearitems() : void{}
      
      private function __itemClick(param1:MouseEvent) : void{}
      
      private function addCartEffects(param1:DisplayObject) : void{}
      
      private function twComplete(param1:TimelineLite, param2:TweenProxy, param3:Bitmap) : void{}
      
      protected function __rankingItemsMouseOver(param1:MouseEvent) : void{}
      
      protected function __rankingItemsMouseOut(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
