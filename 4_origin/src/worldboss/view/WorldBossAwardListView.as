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
         var i:int = 0;
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
         for(i = 0; i < 8; )
         {
            _goodItems[i] = ComponentFactory.Instance.creatCustomObject("worldbossAwardRoom.GoodItem");
            _goodItemContainerAll.addChild(_goodItems[i]);
            _goodItems[i].addEventListener("itemClick",__itemClick);
            _goodItems[i].addEventListener("itemSelect",__itemSelect);
            i++;
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
         var i:int = 0;
         for(i = 0; i < _goodItems.length; )
         {
            _goodItems[i].updata();
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         var i:* = 0;
         _firstPage.removeEventListener("click",__pageBtnClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
         for(i = uint(0); i < 8; )
         {
            _goodItems[i].removeEventListener("itemClick",__itemClick);
            i++;
         }
      }
      
      public function loadList() : void
      {
         setList(ShopManager.Instance.getValidSortedGoodsByType(91,_currentPage));
      }
      
      public function setList(list:Vector.<ShopItemInfo>) : void
      {
         var i:int = 0;
         _list = list;
         clearitems();
         for(i = 0; i < 8; )
         {
            _goodItems[i].selected = false;
            if(i < list.length && list[i])
            {
               _goodItems[i].shopItemInfo = list[i];
            }
            i++;
         }
         _currentPageTxt.text = _currentPage + "/" + ShopManager.Instance.getResultPages(91);
      }
      
      private function clearitems() : void
      {
         var i:int = 0;
         for(i = 0; i < 8; )
         {
            _goodItems[i].shopItemInfo = null;
            i++;
         }
      }
      
      private function __pageBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(ShopManager.Instance.getResultPages(91) == 0)
         {
            return;
         }
         var _loc2_:* = evt.currentTarget;
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
      
      private function __itemClick(evt:ItemEvent) : void
      {
      }
      
      private function __itemSelect(evt:ItemEvent) : void
      {
         evt.stopImmediatePropagation();
         var item:ShopGoodItem = evt.currentTarget as ShopGoodItem;
         var _loc5_:int = 0;
         var _loc4_:* = _goodItems;
         for each(var j in _goodItems)
         {
            j.selected = false;
         }
         item.selected = true;
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
