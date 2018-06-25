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
         var i:int = 0;
         var dx:Number = NaN;
         var dy:Number = NaN;
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
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            _goodItems[i] = ComponentFactory.Instance.creatCustomObject("pyramid.view.pyramidShopItem");
            dx = _goodItems[i].width;
            dy = _goodItems[i].height;
            dx = dx * (int(i % 2));
            dy = dy * (int(i / 2));
            _goodItems[i].x = dx;
            _goodItems[i].y = dy + i / 2 * 2;
            _goodItemContainerAll.addChild(_goodItems[i]);
            i++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),CURRENT_PAGE));
      }
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         clearitems();
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
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
      
      private function __stopScoreUpdateHandler(event:PyramidEvent) : void
      {
         updateShopItemGreyState();
      }
      
      private function __dataChangeHandler(event:PyramidEvent) : void
      {
         updateShopItemGreyState();
      }
      
      private function updateShopItemGreyState() : void
      {
         var i:int = 0;
         if(_goodItems)
         {
            for(i = 0; i < _goodItems.length; )
            {
               _goodItems[i].updateGreyState();
               i++;
            }
         }
      }
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(getType()) == 0)
         {
            return;
         }
         var _loc2_:* = evt.currentTarget;
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
         var i:int = 0;
         for(i = 0; i < SHOP_ITEM_NUM; )
         {
            _goodItems[i].shopItemInfo = null;
            i++;
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
         var i:int = 0;
         for(i = 0; i < _goodItems.length; )
         {
            ObjectUtils.disposeObject(_goodItems[i]);
            _goodItems[i] = null;
            i++;
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
