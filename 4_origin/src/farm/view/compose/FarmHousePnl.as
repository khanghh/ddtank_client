package farm.view.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import farm.view.compose.item.FarmHouseItem;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FarmHousePnl extends Sprite implements Disposeable
   {
      
      public static var CURRENT_PAGE:int = 1;
      
      public static const House_ITEM_NUM:uint = 10;
       
      
      private var _firstPage:BaseButton;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _PageBg:DisplayObject;
      
      private var _currentPageTxt:FilterFrameText;
      
      private var _endPageBtn:BaseButton;
      
      private var _listView:SimpleTileList;
      
      protected var _bagdata:BagInfo;
      
      protected var _cells:Vector.<FarmHouseItem>;
      
      private var _bgBottom:DisplayObject;
      
      private var _bgHouseItem:DisplayObject;
      
      private var _bgPageTxt:DisplayObject;
      
      private var _totalPage:int;
      
      private var _currentPage:int;
      
      public function FarmHousePnl()
      {
         super();
         _cells = new Vector.<FarmHouseItem>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bgBottom = ComponentFactory.Instance.creat("assets.farmHouse.BottomBg");
         addChild(_bgBottom);
         _bgHouseItem = ComponentFactory.Instance.creat("asset.farmHouse.houseBg");
         addChild(_bgHouseItem);
         _firstPage = ComponentFactory.Instance.creat("farmHouse.btnFirstPage");
         addChild(_firstPage);
         _prePageBtn = ComponentFactory.Instance.creat("farmHouse.btnPrePage");
         addChild(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creat("farmHouse.btnNextPage");
         addChild(_nextPageBtn);
         _endPageBtn = ComponentFactory.Instance.creat("farmHouse.btnEndPage");
         addChild(_endPageBtn);
         _bgPageTxt = ComponentFactory.Instance.creat("farmHouse.farmHouse.pageBG");
         addChild(_bgPageTxt);
         _currentPageTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.HouseCurrent");
         addChild(_currentPageTxt);
         _listView = ComponentFactory.Instance.creat("farm.simpleTileList.farmHouse",[5]);
         addChild(_listView);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new FarmHouseItem(_loc2_);
            _listView.addChild(_loc1_);
            _cells.push(_loc1_);
            _loc2_++;
         }
         _bagdata = PlayerManager.Instance.Self.getBag(14);
         _totalPage = _bagdata.items.list.length % 10 == 0?_bagdata.items.list.length / 10 == 0?1:Number(_bagdata.items.list.length / 10):Number(_bagdata.items.list.length / 10 + 1);
         _currentPage = 1;
         update();
      }
      
      private function initEvent() : void
      {
         _firstPage.addEventListener("click",__pageBtnClick);
         _prePageBtn.addEventListener("click",__pageBtnClick);
         _nextPageBtn.addEventListener("click",__pageBtnClick);
         _endPageBtn.addEventListener("click",__pageBtnClick);
         _bagdata.addEventListener("update",__updateGoods);
      }
      
      private function removeEvent() : void
      {
         _firstPage.removeEventListener("click",__pageBtnClick);
         _prePageBtn.removeEventListener("click",__pageBtnClick);
         _nextPageBtn.removeEventListener("click",__pageBtnClick);
         _endPageBtn.removeEventListener("click",__pageBtnClick);
         _bagdata.removeEventListener("update",__updateGoods);
      }
      
      private function __updateGoods(param1:BagEvent) : void
      {
         _totalPage = _bagdata.items.list.length % 10 == 0?_bagdata.items.list.length / 10 == 0?1:Number(_bagdata.items.list.length / 10):Number(_bagdata.items.list.length / 10 + 1);
         update();
      }
      
      private function update() : void
      {
         var _loc3_:* = 0;
         clearitems();
         var _loc1_:int = (_currentPage - 1) * 10;
         var _loc2_:int = _bagdata.items.list.length < _currentPage * 10?_bagdata.items.list.length:_currentPage * 10;
         _loc3_ = _loc1_;
         while(_loc3_ < _loc2_)
         {
            _cells[_loc3_ - _loc1_].info = _bagdata.items.list[_loc3_];
            _loc3_++;
         }
         _currentPageTxt.text = _currentPage + "/" + _totalPage;
      }
      
      private function __pageBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_totalPage == 1)
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
                     _currentPage = _totalPage;
                  }
               }
               else if(_currentPage + 1 <= _totalPage)
               {
                  _currentPage = _currentPage + 1;
               }
            }
            else if(_currentPage - 1 >= 1)
            {
               _currentPage = _currentPage - 1;
            }
         }
         else
         {
            _currentPage = 1;
         }
         update();
      }
      
      private function clearitems() : void
      {
         var _loc1_:int = 0;
         if(_cells.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               _cells[_loc1_].info = null;
               _loc1_++;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearitems();
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            if(_loc1_)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
         _cells.splice(0,_cells.length);
         _bagdata = null;
         _totalPage = 0;
         _currentPage = 1;
         if(_firstPage)
         {
            ObjectUtils.disposeObject(_firstPage);
            _firstPage = null;
         }
         if(_prePageBtn)
         {
            ObjectUtils.disposeObject(_prePageBtn);
            _prePageBtn = null;
         }
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
            _nextPageBtn = null;
         }
         if(_PageBg)
         {
            ObjectUtils.disposeObject(_PageBg);
            _PageBg = null;
         }
         if(_currentPageTxt)
         {
            ObjectUtils.disposeObject(_currentPageTxt);
            _currentPageTxt = null;
         }
         if(_endPageBtn)
         {
            ObjectUtils.disposeObject(_endPageBtn);
            _endPageBtn = null;
         }
         if(_listView)
         {
            ObjectUtils.disposeObject(_listView);
            _listView = null;
         }
         if(_bgBottom)
         {
            ObjectUtils.disposeObject(_bgBottom);
            _bgBottom = null;
         }
         if(_bgHouseItem)
         {
            ObjectUtils.disposeObject(_bgHouseItem);
            _bgHouseItem = null;
         }
         if(_bgPageTxt)
         {
            ObjectUtils.disposeObject(_bgPageTxt);
            _bgPageTxt = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
