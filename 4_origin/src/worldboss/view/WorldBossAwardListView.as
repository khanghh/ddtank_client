package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopGoodItem;
   
   public class WorldBossAwardListView extends Sprite implements Disposeable
   {
      
      public static const AWARD_ITEM_NUM:uint = 8;
       
      
      private var _goodItemContainerAll:Sprite;
      
      private var _goodItems:Vector.<AwardGoodItem>;
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _endPageBtn:BaseButton;
      
      private var _currentPage:int;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _noteDesc:Bitmap;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _list:Vector.<ShopItemInfo>;
      
      public function WorldBossAwardListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _noteDesc = ComponentFactory.Instance.creat("asset.worldbossAwardRoom.ScoreNote");
         addChild(_noteDesc);
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG5");
         addChild(_pageBg);
         _firstPage = ComponentFactory.Instance.creat("worldbossAwardRoom.BtnFirstPage");
         _prePageBtn = ComponentFactory.Instance.creat("worldbossAwardRoom.BtnPrePage");
         _nextPageBtn = ComponentFactory.Instance.creat("worldbossAwardRoom.BtnNextPage");
         _endPageBtn = ComponentFactory.Instance.creat("worldbossAwardRoom.BtnEndPage");
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("worldbossAwardRoom.CurrentPage");
         _goodItems = new Vector.<AwardGoodItem>();
         _goodItemContainerAll = new Sprite();
         PositionUtils.setPos(_goodItemContainerAll,"worldbossAwardRoom.goodItemContainer.pos");
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _goodItems[_loc1_] = ComponentFactory.Instance.creatCustomObject("worldbossAwardRoom.GoodItem");
            _goodItemContainerAll.addChild(_goodItems[_loc1_]);
            _goodItems[_loc1_].addEventListener("itemClick",__itemClick);
            _goodItems[_loc1_].addEventListener("itemSelect",__itemSelect);
            _loc1_++;
         }
         DisplayUtils.horizontalArrange(_goodItemContainerAll,2,-10);
         addChild(_firstPage);
         addChild(_prePageBtn);
         addChild(_nextPageBtn);
         addChild(_endPageBtn);
         addChild(_currentPageTxt);
         addChild(_goodItemContainerAll);
         _currentPage = 1;
         loadList();
      }
      
      private function addEvent() : void
      {
         _firstPage.addEventListener("click",__pageBtnClick);
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
      }
      
      public function updata() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _goodItems.length)
         {
            _goodItems[_loc1_].updata();
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:* = 0;
         _firstPage.removeEventListener("click",__pageBtnClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
         _loc1_ = uint(0);
         while(_loc1_ < 8)
         {
            _goodItems[_loc1_].removeEventListener("itemClick",__itemClick);
            _loc1_++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(91,_currentPage));
      }
      
      public function setList(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:int = 0;
         _list = param1;
         clearitems();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _goodItems[_loc2_].selected = false;
            if(_loc2_ < param1.length && param1[_loc2_])
            {
               _goodItems[_loc2_].shopItemInfo = param1[_loc2_];
            }
            _loc2_++;
         }
         _currentPageTxt.text = _currentPage + "/" + ShopManager.Instance.getResultPages(91);
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _goodItems[_loc1_].shopItemInfo = null;
            _loc1_++;
         }
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(91) == 0)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_firstPage !== _loc2_)
         {
            if(_prePageBtn !== _loc2_)
            {
               if(_nextPageBtn !== _loc2_)
               {
                  if(_endPageBtn === _loc2_)
                  {
                     if(_currentPage != ShopManager.Instance.getResultPages(91))
                     {
                        _currentPage = ShopManager.Instance.getResultPages(91);
                     }
                  }
               }
               else
               {
                  if(_currentPage == ShopManager.Instance.getResultPages(91))
                  {
                     _currentPage = 0;
                  }
                  _currentPage = Number(_currentPage) + 1;
               }
            }
            else
            {
               if(_currentPage == 1)
               {
                  _currentPage = ShopManager.Instance.getResultPages(91) + 1;
               }
               _currentPage = Number(_currentPage) - 1;
            }
         }
         else if(_currentPage != 1)
         {
            _currentPage = 1;
         }
         loadList();
      }
      
      private function __itemClick(param1:ItemEvent) : void
      {
      }
      
      private function __itemSelect(param1:ItemEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:ShopGoodItem = param1.currentTarget as ShopGoodItem;
         var _loc5_:int = 0;
         var _loc4_:* = _goodItems;
         for each(var _loc3_ in _goodItems)
         {
            _loc3_.selected = false;
         }
         _loc2_.selected = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_goodItemContainerAll);
         ObjectUtils.disposeAllChildren(this);
         _goodItemContainerAll = null;
         _goodItems = null;
         _firstPage = null;
         _prePageBtn = null;
         _endPageBtn = null;
         _nextPageBtn = null;
         _currentPageTxt = null;
         _noteDesc = null;
         _pageBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
