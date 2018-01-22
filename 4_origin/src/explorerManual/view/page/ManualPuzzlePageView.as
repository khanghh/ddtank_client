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
      
      public function set isPuzzleSucceed(param1:Boolean) : void
      {
         _isPuzzleSucceed = param1;
         this.dispatchEvent(new CEvent("PuzzleSucceed",_isPuzzleSucceed));
      }
      
      public function set isCanClick(param1:Boolean) : void
      {
         _isCanClick = param1;
      }
      
      public function get isCanClick() : Boolean
      {
         return _isCanClick;
      }
      
      public function set debrisInfo(param1:Array) : void
      {
         _debrisInfo = param1;
         isCanClick = _count <= _debrisInfo.length;
         initPuzzleItem();
      }
      
      public function set totalDebrisCount(param1:int) : void
      {
         _count = param1;
      }
      
      public function correctionPuzzle() : void
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = 0;
         var _loc3_:int = _debrisInfo.length;
         var _loc7_:Array = [];
         if(_isCanClick)
         {
            _loc5_ = 0;
            while(_loc5_ < _debrisInfo.length)
            {
               _loc7_.push(_debrisInfo[_loc5_].Sort);
               _loc5_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               if(_loc7_[_loc8_] != _loc8_ + 1)
               {
                  _loc4_ = _loc8_;
                  while(_loc4_ < _loc3_)
                  {
                     if(_loc7_[_loc4_] == _loc8_ + 1)
                     {
                        _loc6_ = _loc7_[_loc4_];
                        _loc7_[_loc4_] = _loc7_[_loc8_];
                        _loc7_[_loc8_] = _loc6_;
                        _loc1_++;
                        break;
                     }
                     _loc4_++;
                  }
               }
               _loc8_++;
            }
            if(_loc1_ % 2 > 0)
            {
               _loc2_ = _debrisInfo[_loc3_ - 1];
               _debrisInfo[_loc3_ - 1] = _debrisInfo[_loc3_ - 2];
               _debrisInfo[_loc3_ - 2] = _loc2_;
            }
         }
      }
      
      private function initPuzzleItem() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _rows = Math.sqrt(_count + 1);
         _cols = _rows;
         _allDebrisState = new Array(_rows);
         _allDebris = [];
         _itemW = _totalWidth / _rows;
         _itemH = _totalHeight / _cols;
         correctionPuzzle();
         _loc2_ = 0;
         while(_loc2_ < _rows)
         {
            _allDebrisState[_loc2_] = new Array(_cols);
            _loc3_ = 0;
            while(_loc3_ < _cols)
            {
               _loc4_ = _loc2_ * _cols + _loc3_;
               if(_loc4_ < _debrisInfo.length)
               {
                  _loc1_ = new ManualPiecesItem(_loc4_,_itemW,_itemH);
                  _loc1_.info = _debrisInfo[_loc4_];
                  _loc1_.x = _loc3_ * _itemW;
                  _loc1_.y = _loc2_ * _itemH;
                  _loc1_.xOffset = _loc3_;
                  _loc1_.yOffset = _loc2_;
                  addChild(_loc1_);
                  _allDebrisState[_loc2_][_loc3_] = 0;
                  _loc1_.addEventListener("click",__itemClickHandler);
                  _allDebris.push(_loc1_);
               }
               else
               {
                  _allDebrisState[_loc2_][_loc3_] = 1;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(isCanClick)
         {
            checkPuzzleResult();
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_isCanClick)
         {
            return;
         }
         var _loc2_:ManualPiecesItem = param1.target as ManualPiecesItem;
         var _loc4_:int = _loc2_.xOffset - 1;
         var _loc5_:int = _loc2_.xOffset + 1;
         var _loc6_:int = _loc2_.yOffset - 1;
         var _loc3_:int = _loc2_.yOffset + 1;
         if(_loc4_ != -1 && _allDebrisState[_loc4_][_loc2_.yOffset] == 1)
         {
            _allDebrisState[_loc4_][_loc2_.yOffset] = 0;
            _allDebrisState[_loc2_.xOffset][_loc2_.yOffset] = 1;
            _loc2_.xOffset = _loc4_;
            _loc2_.x = _loc4_ * _itemW;
            _loc2_.index = _loc2_.index - 1;
         }
         else if(_loc5_ < _rows && _allDebrisState[_loc5_][_loc2_.yOffset] == 1)
         {
            _allDebrisState[_loc2_.xOffset][_loc2_.yOffset] = 1;
            _allDebrisState[_loc5_][_loc2_.yOffset] = 0;
            _loc2_.xOffset = _loc5_;
            _loc2_.x = _loc5_ * _itemW;
            _loc2_.index = _loc2_.index + 1;
         }
         else if(_loc6_ != -1 && _allDebrisState[_loc2_.xOffset][_loc6_] == 1)
         {
            _allDebrisState[_loc2_.xOffset][_loc2_.yOffset] = 1;
            _allDebrisState[_loc2_.xOffset][_loc6_] = 0;
            _loc2_.yOffset = _loc6_;
            _loc2_.y = _loc6_ * _itemH;
            _loc2_.index = _loc2_.index - _rows;
         }
         else if(_loc3_ < _cols && _allDebrisState[_loc2_.xOffset][_loc3_] == 1)
         {
            _allDebrisState[_loc2_.xOffset][_loc2_.yOffset] = 1;
            _allDebrisState[_loc2_.xOffset][_loc3_] = 0;
            _loc2_.yOffset = _loc3_;
            _loc2_.y = _loc3_ * _itemH;
            _loc2_.index = _loc2_.index + _rows;
         }
         checkPuzzleResult();
      }
      
      private function checkPuzzleResult() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _allDebris.length)
         {
            if(!(_allDebris[_loc3_] as ManualPiecesItem).isRight)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            isPuzzleSucceed = _loc1_;
            isCanClick = false;
         }
      }
      
      public function akey() : void
      {
         var _loc6_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = Math.sqrt(_count + 1);
         var _loc2_:int = _rows;
         var _loc5_:int = _totalWidth / _rows;
         var _loc4_:int = _totalHeight / _cols;
         _loc7_ = 0;
         while(_loc7_ < _allDebris.length)
         {
            _loc6_ = _allDebris[_loc7_] as ManualPiecesItem;
            _loc3_ = (_loc6_.info.Sort - 1) % _loc8_;
            _loc1_ = (_loc6_.info.Sort - 1) / _loc8_;
            _loc6_.x = _loc3_ * _loc5_;
            _loc6_.y = _loc1_ * _loc4_;
            _loc6_.index = _loc1_ * _loc2_ + _loc3_;
            _loc7_++;
         }
         checkPuzzleResult();
      }
      
      public function clear() : void
      {
         var _loc1_:* = null;
         if(_allDebris && _allDebris.length > 0)
         {
            while(_allDebris.length > 0)
            {
               _loc1_ = _allDebris.shift();
               _loc1_.removeEventListener("click",__itemClickHandler);
               ObjectUtils.disposeObject(_loc1_);
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
