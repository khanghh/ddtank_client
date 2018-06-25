package explorerManual.view.page
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import explorerManual.data.model.ManualDebrisInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ManualPuzzlePageView extends Sprite implements Disposeable
   {
       
      
      private var _debrisInfo:Array;
      
      private var _count:int;
      
      private var _totalWidth:int = 328;
      
      private var _totalHeight:int = 384;
      
      private var _rows:int;
      
      private var _cols:int;
      
      private var _itemW:int;
      
      private var _itemH:int;
      
      private var _allDebris:Array;
      
      private var _allDebrisState:Array;
      
      private var _isCanClick:Boolean = false;
      
      private var _isPuzzleSucceed:Boolean = false;
      
      public function ManualPuzzlePageView()
      {
         super();
      }
      
      public function get isPuzzleSucceed() : Boolean
      {
         return _isPuzzleSucceed;
      }
      
      public function set isPuzzleSucceed(value:Boolean) : void
      {
         _isPuzzleSucceed = value;
         this.dispatchEvent(new CEvent("PuzzleSucceed",_isPuzzleSucceed));
      }
      
      public function set isCanClick(value:Boolean) : void
      {
         _isCanClick = value;
      }
      
      public function get isCanClick() : Boolean
      {
         return _isCanClick;
      }
      
      public function set debrisInfo(info:Array) : void
      {
         _debrisInfo = info;
         isCanClick = _count <= _debrisInfo.length;
         initPuzzleItem();
      }
      
      public function set totalDebrisCount(value:int) : void
      {
         _count = value;
      }
      
      public function correctionPuzzle() : void
      {
         var correction1:* = null;
         var correction2:int = 0;
         var numb:int = 0;
         var k:int = 0;
         var i:int = 0;
         var j:* = 0;
         var len:int = _debrisInfo.length;
         var temDebris:Array = [];
         if(_isCanClick)
         {
            for(k = 0; k < _debrisInfo.length; )
            {
               temDebris.push(_debrisInfo[k].Sort);
               k++;
            }
            for(i = 0; i < len; )
            {
               if(temDebris[i] != i + 1)
               {
                  for(j = i; j < len; )
                  {
                     if(temDebris[j] == i + 1)
                     {
                        correction2 = temDebris[j];
                        temDebris[j] = temDebris[i];
                        temDebris[i] = correction2;
                        numb++;
                        break;
                     }
                     j++;
                  }
               }
               i++;
            }
            if(numb % 2 > 0)
            {
               correction1 = _debrisInfo[len - 1];
               _debrisInfo[len - 1] = _debrisInfo[len - 2];
               _debrisInfo[len - 2] = correction1;
            }
         }
      }
      
      private function initPuzzleItem() : void
      {
         var piecesItem:* = null;
         var temIndex:int = 0;
         var j:int = 0;
         var k:int = 0;
         _rows = Math.sqrt(_count + 1);
         _cols = _rows;
         _allDebrisState = new Array(_rows);
         _allDebris = [];
         _itemW = _totalWidth / _rows;
         _itemH = _totalHeight / _cols;
         correctionPuzzle();
         for(j = 0; j < _rows; )
         {
            _allDebrisState[j] = new Array(_cols);
            for(k = 0; k < _cols; )
            {
               temIndex = j * _cols + k;
               if(temIndex < _debrisInfo.length)
               {
                  piecesItem = new ManualPiecesItem(temIndex,_itemW,_itemH);
                  piecesItem.info = _debrisInfo[temIndex];
                  piecesItem.x = k * _itemW;
                  piecesItem.y = j * _itemH;
                  piecesItem.xOffset = k;
                  piecesItem.yOffset = j;
                  addChild(piecesItem);
                  _allDebrisState[j][k] = 0;
                  piecesItem.addEventListener("click",__itemClickHandler);
                  _allDebris.push(piecesItem);
               }
               else
               {
                  _allDebrisState[j][k] = 1;
               }
               k++;
            }
            j++;
         }
         if(isCanClick)
         {
            checkPuzzleResult();
         }
      }
      
      private function __itemClickHandler(evt:MouseEvent) : void
      {
         if(!_isCanClick)
         {
            return;
         }
         var item:ManualPiecesItem = evt.target as ManualPiecesItem;
         var left:int = item.xOffset - 1;
         var right:int = item.xOffset + 1;
         var top:int = item.yOffset - 1;
         var bottom:int = item.yOffset + 1;
         if(left != -1 && _allDebrisState[left][item.yOffset] == 1)
         {
            _allDebrisState[left][item.yOffset] = 0;
            _allDebrisState[item.xOffset][item.yOffset] = 1;
            item.xOffset = left;
            item.x = left * _itemW;
            item.index = item.index - 1;
         }
         else if(right < _rows && _allDebrisState[right][item.yOffset] == 1)
         {
            _allDebrisState[item.xOffset][item.yOffset] = 1;
            _allDebrisState[right][item.yOffset] = 0;
            item.xOffset = right;
            item.x = right * _itemW;
            item.index = item.index + 1;
         }
         else if(top != -1 && _allDebrisState[item.xOffset][top] == 1)
         {
            _allDebrisState[item.xOffset][item.yOffset] = 1;
            _allDebrisState[item.xOffset][top] = 0;
            item.yOffset = top;
            item.y = top * _itemH;
            item.index = item.index - _rows;
         }
         else if(bottom < _cols && _allDebrisState[item.xOffset][bottom] == 1)
         {
            _allDebrisState[item.xOffset][item.yOffset] = 1;
            _allDebrisState[item.xOffset][bottom] = 0;
            item.yOffset = bottom;
            item.y = bottom * _itemH;
            item.index = item.index + _rows;
         }
         checkPuzzleResult();
      }
      
      private function checkPuzzleResult() : void
      {
         var item:* = null;
         var i:int = 0;
         var isSucceed:Boolean = true;
         for(i = 0; i < _allDebris.length; )
         {
            if(!(_allDebris[i] as ManualPiecesItem).isRight)
            {
               isSucceed = false;
               break;
            }
            i++;
         }
         if(isSucceed)
         {
            isPuzzleSucceed = isSucceed;
            isCanClick = false;
         }
      }
      
      public function akey() : void
      {
         var item:* = null;
         var xOffset:int = 0;
         var yOffset:int = 0;
         var i:int = 0;
         var rows:int = Math.sqrt(_count + 1);
         var cols:int = _rows;
         var itemW:int = _totalWidth / _rows;
         var itemH:int = _totalHeight / _cols;
         for(i = 0; i < _allDebris.length; )
         {
            item = _allDebris[i] as ManualPiecesItem;
            xOffset = (item.info.Sort - 1) % rows;
            yOffset = (item.info.Sort - 1) / rows;
            item.x = xOffset * itemW;
            item.y = yOffset * itemH;
            item.index = yOffset * cols + xOffset;
            i++;
         }
         checkPuzzleResult();
      }
      
      public function clear() : void
      {
         var item:* = null;
         if(_allDebris && _allDebris.length > 0)
         {
            while(_allDebris.length > 0)
            {
               item = _allDebris.shift();
               item.removeEventListener("click",__itemClickHandler);
               ObjectUtils.disposeObject(item);
            }
         }
         _allDebris = null;
      }
      
      public function dispose() : void
      {
         clear();
         _isCanClick = false;
         _isPuzzleSucceed = false;
         _debrisInfo = null;
         _allDebrisState = null;
      }
   }
}
