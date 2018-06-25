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
      
      public function set itemList(value:*) : void
      {
         if(value == null)
         {
            return;
         }
         _itemList = value;
         _itemLengthPerPage = _itemList.length;
         if(_itemDataArr != null)
         {
            _totalPage = Math.max(1,Math.ceil(_itemDataArr.length / _itemLengthPerPage));
            _pageNum.text = "1/" + _totalPage.toString();
            setPageArr();
         }
      }
      
      public function set itemDataArr(value:Array) : void
      {
         _itemDataArr = value;
         if(_itemLengthPerPage > 0)
         {
            _totalPage = Math.max(1,Math.ceil(_itemDataArr.length / _itemLengthPerPage));
            _pageNum.text = "1/" + _totalPage.toString();
            setPageArr();
         }
      }
      
      public function set updateItemDataArr(value:Array) : void
      {
         _itemDataArr = value;
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
      
      public function setRightBtn($btnString:String) : void
      {
         _rightBtn = ComponentFactory.Instance.creat($btnString);
         addChild(_rightBtn);
         _rightBtn.addEventListener("click",mouseClickHander);
      }
      
      public function setLeftBtn($btnString:String) : void
      {
         _leftBtn = ComponentFactory.Instance.creat($btnString);
         addChild(_leftBtn);
         _leftBtn.addEventListener("click",mouseClickHander);
      }
      
      public function setNumBG($numBGString:String) : void
      {
         _numBG = ComponentFactory.Instance.creat($numBGString);
         addChild(_numBG);
      }
      
      public function setPageNumber($numString:String) : void
      {
         _pageNum = ComponentFactory.Instance.creatComponentByStylename($numString);
         _pageNum.autoSize = "center";
         _pageNum.text = "1/1";
         addChild(_pageNum);
      }
      
      public function updateByIndex($index:int) : void
      {
         var startIndex:int = (_curPage - 1) * _itemLengthPerPage;
         var endIndex:int = Math.min(_curPage * _itemLengthPerPage,_itemDataArr.length) - 1;
         if(startIndex <= $index && $index <= endIndex)
         {
            (_itemList[$index - startIndex] as IPageItem).updateItem(_itemDataArr[$index]);
         }
      }
      
      private function mouseClickHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_itemDataArr)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
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
         var arr:* = null;
         var i:int = 0;
         var startIndex:int = (_curPage - 1) * _itemLengthPerPage;
         var endIndex:int = Math.min(_curPage * _itemLengthPerPage,_itemDataArr.length);
         arr = _itemDataArr.slice(startIndex,endIndex);
         clearAllItemData();
         var len:int = arr.length;
         for(i = 0; i < len; )
         {
            (_itemList[i] as IPageItem).updateItem(arr[i]);
            i++;
         }
      }
      
      private function clearAllItemData() : void
      {
         var i:int = 0;
         if(_itemList == null)
         {
            return;
         }
         var len:int = _itemList.length;
         for(i = 0; i < len; )
         {
            _itemList[i].updateItem();
            i++;
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
