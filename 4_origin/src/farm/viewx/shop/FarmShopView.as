package farm.viewx.shop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   
   public class FarmShopView extends Frame
   {
      
      public static const SEEDTYPE:int = 0;
      
      public static const MANURETYPE:int = 1;
      
      public static var CURRENT_PAGE:int = 1;
      
      public static const SHOP_ITEM_NUM:uint = 10;
       
      
      private var _goodItems:Vector.<FarmShopItem>;
      
      private var _currentType:int = 88;
      
      private var _seedBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _goodItemContainerAll:SimpleTileList;
      
      private var _titleShop:DisplayObject;
      
      private var _pageInputBg:DisplayObject;
      
      public function FarmShopView()
      {
         super();
         _goodItems = new Vector.<FarmShopItem>();
         initView();
         initEvent();
         escEnable = true;
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _titleShop = ComponentFactory.Instance.creat("assets.farmShop.title");
         addToContent(_titleShop);
         _pageInputBg = ComponentFactory.Instance.creat("farm.farmShopView.fontBG");
         addToContent(_pageInputBg);
         _seedBtn = ComponentFactory.Instance.creatComponentByStylename("farmShop.button.seed");
         addToContent(_seedBtn);
         _firstPage = ComponentFactory.Instance.creat("farmshop.btnFirstPage");
         addToContent(_firstPage);
         _prePageBtn = ComponentFactory.Instance.creat("farmshop.btnPrePage");
         addToContent(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creat("farmshop.btnNextPage");
         addToContent(_nextPageBtn);
         _endPageBtn = ComponentFactory.Instance.creat("farmshop.btnEndPage");
         addToContent(_endPageBtn);
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.shopCurrent");
         addToContent(_currentPageTxt);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_seedBtn);
         _btnGroup.selectIndex = 0;
         _goodItemContainerAll = ComponentFactory.Instance.creat("farm.simpleTileList.farmShop",[5]);
         addToContent(_goodItemContainerAll);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _goodItems[_loc1_] = ComponentFactory.Instance.creatCustomObject("farmShop.farmShopItem");
            _goodItemContainerAll.addChild(_goodItems[_loc1_]);
            _goodItems[_loc1_].addEventListener("itemClick",__itemClick);
            _loc1_++;
         }
         if(PetsBagManager.instance().petModel.IsFinishTask5)
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(113);
            PetsBagManager.instance().petModel.IsFinishTask5 = false;
         }
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _firstPage.addEventListener("click",__pageBtnClick);
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         _firstPage.removeEventListener("click",__pageBtnClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
      }
      
      private function __itemClick(param1:ItemEvent) : void
      {
         var _loc2_:FarmShopItem = param1.currentTarget as FarmShopItem;
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _currentType = 88;
               break;
            case 1:
               _currentType = 89;
         }
         CURRENT_PAGE = 1;
         loadList();
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_firstPage !== _loc2_)
         {
            if(_prePageBtn !== _loc2_)
            {
               if(_nextPageBtn !== _loc2_)
               {
                  if(_endPageBtn === _loc2_)
                  {
                     if(CURRENT_PAGE != ShopManager.Instance.getResultPages(getType(),10))
                     {
                        CURRENT_PAGE = ShopManager.Instance.getResultPages(getType(),10);
                     }
                  }
               }
               else
               {
                  if(CURRENT_PAGE == ShopManager.Instance.getResultPages(getType(),10))
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
                  CURRENT_PAGE = ShopManager.Instance.getResultPages(getType(),10) + 1;
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
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(getType(),CURRENT_PAGE,10));
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            if(_loc2_ < param1.length && param1[_loc2_])
            {
               _goodItems[_loc2_].shopItemInfo = param1[_loc2_];
            }
            else
            {
               _goodItems[_loc2_].shopItemInfo = null;
            }
            _loc2_++;
         }
         _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getResultPages(getType(),10);
      }
      
      private function getType() : int
      {
         var _loc1_:int = _currentType;
         return _loc1_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         loadList();
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = 0;
         _loc1_ = uint(0);
         while(_loc1_ < 10)
         {
            _goodItems[_loc1_].removeEventListener("itemClick",__itemClick);
            _goodItems[_loc1_].dispose();
            _goodItems[_loc1_] = null;
            _loc1_++;
         }
         _goodItems.splice(0,_goodItems.length);
         if(_goodItemContainerAll)
         {
            ObjectUtils.disposeObject(_goodItemContainerAll);
            _goodItemContainerAll = null;
         }
         if(_endPageBtn)
         {
            ObjectUtils.disposeObject(_endPageBtn);
            _endPageBtn = null;
         }
         if(_currentPageTxt)
         {
            ObjectUtils.disposeObject(_currentPageTxt);
            _currentPageTxt = null;
         }
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
            _nextPageBtn = null;
         }
         if(_prePageBtn)
         {
            ObjectUtils.disposeObject(_prePageBtn);
            _prePageBtn = null;
         }
         if(_firstPage)
         {
            ObjectUtils.disposeObject(_firstPage);
            _firstPage = null;
         }
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
            _btnGroup = null;
         }
         if(_seedBtn)
         {
            ObjectUtils.disposeObject(_seedBtn);
            _seedBtn = null;
         }
         if(_titleShop)
         {
            ObjectUtils.disposeObject(_titleShop);
            _titleShop = null;
         }
         if(_pageInputBg)
         {
            ObjectUtils.disposeObject(_pageInputBg);
            _pageInputBg = null;
         }
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
