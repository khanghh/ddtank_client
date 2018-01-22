package ddt.view.pageSelector
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PageSelector extends Sprite implements Disposeable
   {
       
      
      private var _itemList;
      
      private var _itemDataArr:Array;
      
      private var _curPage:Number = 1;
      
      protected var _rightBtn:BaseButton;
      
      protected var _leftBtn:BaseButton;
      
      protected var _numBG:Scale9CornerImage;
      
      protected var _pageNum:FilterFrameText;
      
      private var _totalPage:Number = 1;
      
      private var _itemLengthPerPage:Number = 0;
      
      public function PageSelector()
      {
         super();
      }
      
      public function set itemList(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         _itemList = param1;
         _itemLengthPerPage = _itemList.length;
         if(_itemDataArr != null)
         {
            _totalPage = Math.max(1,Math.ceil(_itemDataArr.length / _itemLengthPerPage));
            _pageNum.text = "1/" + _totalPage.toString();
            setPageArr();
         }
      }
      
      public function set itemDataArr(param1:Array) : void
      {
         _itemDataArr = param1;
         if(_itemLengthPerPage > 0)
         {
            _totalPage = Math.max(1,Math.ceil(_itemDataArr.length / _itemLengthPerPage));
            _pageNum.text = "1/" + _totalPage.toString();
            setPageArr();
         }
      }
      
      public function set updateItemDataArr(param1:Array) : void
      {
         _itemDataArr = param1;
         if(_itemLengthPerPage > 0)
         {
            _totalPage = Math.max(1,Math.ceil(_itemDataArr.length / _itemLengthPerPage));
            _pageNum.text = _curPage + "/" + _totalPage.toString();
         }
      }
      
      public function get curPage() : Number
      {
         return _curPage;
      }
      
      public function setRightBtn(param1:String) : void
      {
         _rightBtn = ComponentFactory.Instance.creat(param1);
         addChild(_rightBtn);
         _rightBtn.addEventListener("click",mouseClickHander);
      }
      
      public function setLeftBtn(param1:String) : void
      {
         _leftBtn = ComponentFactory.Instance.creat(param1);
         addChild(_leftBtn);
         _leftBtn.addEventListener("click",mouseClickHander);
      }
      
      public function setNumBG(param1:String) : void
      {
         _numBG = ComponentFactory.Instance.creat(param1);
         addChild(_numBG);
      }
      
      public function setPageNumber(param1:String) : void
      {
         _pageNum = ComponentFactory.Instance.creatComponentByStylename(param1);
         _pageNum.autoSize = "center";
         _pageNum.text = "1/1";
         addChild(_pageNum);
      }
      
      public function updateByIndex(param1:int) : void
      {
         var _loc2_:int = (_curPage - 1) * _itemLengthPerPage;
         var _loc3_:int = Math.min(_curPage * _itemLengthPerPage,_itemDataArr.length) - 1;
         if(_loc2_ <= param1 && param1 <= _loc3_)
         {
            (_itemList[param1 - _loc2_] as IPageItem).updateItem(_itemDataArr[param1]);
         }
      }
      
      private function mouseClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_itemDataArr)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(_rightBtn !== _loc2_)
         {
            if(_leftBtn === _loc2_)
            {
               _curPage = Number(_curPage) - 1;
               if(_curPage < 1)
               {
                  _curPage = _totalPage;
               }
            }
         }
         else
         {
            _curPage = Number(_curPage) + 1;
            if(_curPage > _totalPage)
            {
               _curPage = 1;
            }
         }
         _pageNum.text = _curPage + "/" + _totalPage;
         setPageArr();
      }
      
      public function setPageArr() : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc1_:int = (_curPage - 1) * _itemLengthPerPage;
         var _loc4_:int = Math.min(_curPage * _itemLengthPerPage,_itemDataArr.length);
         _loc2_ = _itemDataArr.slice(_loc1_,_loc4_);
         clearAllItemData();
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            (_itemList[_loc5_] as IPageItem).updateItem(_loc2_[_loc5_]);
            _loc5_++;
         }
      }
      
      private function clearAllItemData() : void
      {
         var _loc2_:int = 0;
         if(_itemList == null)
         {
            return;
         }
         var _loc1_:int = _itemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _itemList[_loc2_].updateItem();
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         if(_leftBtn != null)
         {
            _leftBtn.removeEventListener("click",mouseClickHander);
            ObjectUtils.disposeObject(_leftBtn);
            _leftBtn = null;
         }
         if(_rightBtn != null)
         {
            _rightBtn.removeEventListener("click",mouseClickHander);
            ObjectUtils.disposeObject(_rightBtn);
            _rightBtn = null;
         }
         if(_pageNum != null)
         {
            ObjectUtils.disposeObject(_pageNum);
            _pageNum = null;
         }
         if(_numBG != null)
         {
            ObjectUtils.disposeObject(_numBG);
            _numBG = null;
         }
      }
   }
}
