package labyrinth.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LabyrinthShopFrame extends BaseAlerFrame
   {
      
      public static const SHOP_ITEM_NUM:uint = 8;
      
      public static var CURRENT_MONEY_TYPE:int = 1;
       
      
      private var CURRENT_PAGE:int = 1;
      
      private var _goodItems:Vector.<LabyrinthShopItem>;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _rightItemLightMc:MovieClip;
      
      protected var _goodItemContainerBg:Image;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _navigationBarContainer:Sprite;
      
      private var _coinNumBG:Scale9CornerImage;
      
      private var _coinText:FilterFrameText;
      
      private var _coinNumText:FilterFrameText;
      
      private var _lable:FilterFrameText;
      
      public function LabyrinthShopFrame(){super();}
      
      override protected function init() : void{}
      
      private function initEvent() : void{}
      
      private function upDateStoneHander(param1:BuriedEvent) : void{}
      
      public function removeEvent() : void{}
      
      protected function __onUpdate(param1:PlayerPropertyEvent) : void{}
      
      private function clearitems() : void{}
      
      public function loadList() : void{}
      
      public function setList(param1:Vector.<ShopItemInfo>) : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      public function getType() : int{return 0;}
      
      public function show() : void{}
      
      private function disposeItems() : void{}
      
      override public function dispose() : void{}
   }
}
