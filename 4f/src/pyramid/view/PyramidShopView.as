package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.PyramidManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PyramidShopView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _goodItemContainerAll:Sprite;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _firstPageBtn:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _navigationBarContainer:Sprite;
      
      private var _goodItems:Vector.<PyramidShopItem>;
      
      private var SHOP_ITEM_NUM:int = 8;
      
      private var CURRENT_PAGE:int = 1;
      
      public function PyramidShopView(){super();}
      
      private function initView() : void{}
      
      public function loadList() : void{}
      
      public function setList(param1:Vector.<ShopItemInfo>) : void{}
      
      private function initEvent() : void{}
      
      private function __stopScoreUpdateHandler(param1:PyramidEvent) : void{}
      
      private function __dataChangeHandler(param1:PyramidEvent) : void{}
      
      private function updateShopItemGreyState() : void{}
      
      private function __pageBtnClick(param1:MouseEvent) : void{}
      
      private function clearitems() : void{}
      
      public function getType() : int{return 0;}
      
      private function removeEvent() : void{}
      
      private function disposeItems() : void{}
      
      public function dispose() : void{}
   }
}
