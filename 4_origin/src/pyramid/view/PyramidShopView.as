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
      
      public function PyramidShopView()
      {
         super();
         initView();
         initEvent();
         loadList();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _bg = ComponentFactory.Instance.creatBitmap("assets.pyramid.shopViewBg");
         addChild(_bg);
         _goodItemContainerAll = ComponentFactory.Instance.creatCustomObject("pyramid.view.goodItemContainerAll");
         addChild(_goodItemContainerAll);
         _navigationBarContainer = ComponentFactory.Instance.creatCustomObject("pyramid.view.navigationBarContainer");
         addChild(_navigationBarContainer);
         _firstPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnFirstPage",_navigationBarContainer);
         _prePageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnPrePage",_navigationBarContainer);
         _nextPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnNextPage",_navigationBarContainer);
         _endPageBtn = UICreatShortcut.creatAndAdd("ddtshop.BtnEndPage",_navigationBarContainer);
         _currentPageInput = UICreatShortcut.creatAndAdd("ddtshop.CurrentPageInput",_navigationBarContainer);
         _currentPageTxt = UICreatShortcut.creatAndAdd("ddtshop.CurrentPage",_navigationBarContainer);
         _goodItems = new Vector.<PyramidShopItem>();
         _loc3_ = 0;
         while(_loc3_ < SHOP_ITEM_NUM)
         {
            _goodItems[_loc3_] = ComponentFactory.Instance.creatCustomObject("pyramid.view.pyramidShopItem");
            _loc1_ = _goodItems[_loc3_].width;
            _loc2_ = _goodItems[_loc3_].height;
            _loc1_ = _loc1_ * (int(_loc3_ % 2));
            _loc2_ = _loc2_ * (int(_loc3_ / 2));
            _goodItems[_loc3_].x = _loc1_;
            _goodItems[_loc3_].y = _loc2_ + _loc3_ / 2 * 2;
            _goodItemContainerAll.addChild(_goodItems[_loc3_]);
            _loc3_++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),CURRENT_PAGE));
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:int = 0;
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < SHOP_ITEM_NUM)
         {
            if(param1)
            {
               if(_loc2_ < param1.length && param1[_loc2_])
               {
                  _goodItems[_loc2_].shopItemInfo = param1[_loc2_];
               }
               _loc2_++;
               continue;
            }
            break;
         }
         _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getResultPages(getType());
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _firstPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
         PyramidManager.instance.model.addEventListener("start_or_stop",__stopScoreUpdateHandler);
         PyramidManager.instance.model.addEventListener("dataChange",__dataChangeHandler);
      }
      
      private function __stopScoreUpdateHandler(param1:PyramidEvent) : void
      {
         updateShopItemGreyState();
      }
      
      private function __dataChangeHandler(param1:PyramidEvent) : void
      {
         updateShopItemGreyState();
      }
      
      private function updateShopItemGreyState() : void
      {
         var _loc1_:int = 0;
         if(_goodItems)
         {
            _loc1_ = 0;
            while(_loc1_ < _goodItems.length)
            {
               _goodItems[_loc1_].updateGreyState();
               _loc1_++;
            }
         }
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(getType()) == 0)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_firstPageBtn !== _loc2_)
         {
            if(_prePageBtn !== _loc2_)
            {
               if(_nextPageBtn !== _loc2_)
               {
                  if(_endPageBtn === _loc2_)
                  {
                     if(CURRENT_PAGE != ShopManager.Instance.getResultPages(getType()))
                     {
                        CURRENT_PAGE = ShopManager.Instance.getResultPages(getType());
                     }
                  }
               }
               else
               {
                  if(CURRENT_PAGE == ShopManager.Instance.getResultPages(getType()))
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
                  CURRENT_PAGE = ShopManager.Instance.getResultPages(getType()) + 1;
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
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SHOP_ITEM_NUM)
         {
            _goodItems[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      public function getType() : int
      {
         return 98;
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _firstPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
         PyramidManager.instance.model.removeEventListener("start_or_stop",__stopScoreUpdateHandler);
         PyramidManager.instance.model.removeEventListener("dataChange",__dataChangeHandler);
      }
      
      private function disposeItems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _goodItems.length)
         {
            ObjectUtils.disposeObject(_goodItems[_loc1_]);
            _goodItems[_loc1_] = null;
            _loc1_++;
         }
         _goodItems = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         disposeItems();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_goodItemContainerAll);
         ObjectUtils.disposeObject(_goodItemContainerAll);
         _goodItemContainerAll = null;
         ObjectUtils.disposeObject(_currentPageInput);
         _currentPageInput = null;
         ObjectUtils.disposeObject(_currentPageTxt);
         _currentPageTxt = null;
         ObjectUtils.disposeObject(_firstPageBtn);
         _firstPageBtn = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_endPageBtn);
         _endPageBtn = null;
         ObjectUtils.disposeAllChildren(_navigationBarContainer);
         ObjectUtils.disposeObject(_navigationBarContainer);
         _navigationBarContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
