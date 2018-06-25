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
         var i:int = 0;
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
         for(i = 0; i < 10; )
         {
            _goodItems[i] = ComponentFactory.Instance.creatCustomObject("farmShop.farmShopItem");
            _goodItemContainerAll.addChild(_goodItems[i]);
            _goodItems[i].addEventListener("itemClick",__itemClick);
            i++;
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
      
      private function __itemClick(evt:ItemEvent) : void
      {
         var item:FarmShopItem = evt.currentTarget as FarmShopItem;
      }
      
      private function __changeHandler(event:Event) : void
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
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = evt.currentTarget;
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
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         for(i = 0; i < 10; )
         {
            if(i < list.length && list[i])
            {
               _goodItems[i].shopItemInfo = list[i];
            }
            else
            {
               _goodItems[i].shopItemInfo = null;
            }
            i++;
         }
         _currentPageTxt.text = CURRENT_PAGE + "/" + ShopManager.Instance.getResultPages(getType(),10);
      }
      
      private function getType() : int
      {
         var shopType:int = _currentType;
         return shopType;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         loadList();
      }
      
      override public function dispose() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 10; )
         {
            _goodItems[i].removeEventListener("itemClick",__itemClick);
            _goodItems[i].dispose();
            _goodItems[i] = null;
            i++;
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
