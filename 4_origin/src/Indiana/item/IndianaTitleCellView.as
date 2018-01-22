package Indiana.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class IndianaTitleCellView extends Sprite implements Disposeable
   {
       
      
      private var group:Vector.<IndianaTitleCell>;
      
      private var _currentCell:IndianaTitleCell;
      
      public var callBack:Function;
      
      private var _bg:Bitmap;
      
      private var _cells:Array;
      
      public function IndianaTitleCellView()
      {
         super();
         group = new Vector.<IndianaTitleCell>();
         _bg = ComponentFactory.Instance.creatBitmap("asset.indiana.titleview.bg");
         addChild(_bg);
         _cells = [];
      }
      
      private function initCell() : void
      {
         var _loc1_:IndianaTitleCell = new IndianaTitleCell();
         _loc1_.setContentSize(44,44);
         _loc1_.addEventListener("click",__cellClickHandler);
         addChild(_loc1_);
         group.push(_loc1_);
         _loc1_ = new IndianaTitleCell();
         _loc1_.setContentSize(44,44);
         addChild(_loc1_);
         _loc1_.addEventListener("click",__cellClickHandler);
         group.push(_loc1_);
         _loc1_ = new IndianaTitleCell();
         _loc1_.setContentSize(44,44);
         addChild(_loc1_);
         _loc1_.addEventListener("click",__cellClickHandler);
         group.push(_loc1_);
         PositionUtils.setPos(group[0],"indiana.cell.index_1");
         PositionUtils.setPos(group[1],"indiana.cell.index_2");
         PositionUtils.setPos(group[2],"indiana.cell.index_3");
      }
      
      private function clearCells() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = _cells.length;
         while(_cells.length > 0)
         {
            _loc1_ = _cells.shift();
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      private function sortCell() : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = _cells.length;
         var _loc8_:Array = [];
         if(_loc5_ > 0)
         {
            _loc7_ = 0;
            _loc6_ = 10;
            if(_loc5_ % 2 == 0)
            {
               _loc3_ = ComponentFactory.Instance.creat("indiana.cell.index_4");
               _loc2_ = ComponentFactory.Instance.creat("indiana.cell.index_5");
               _loc7_;
               while(_loc7_ < _loc5_)
               {
                  _loc4_ = new Point();
                  if(_loc7_ % 2 == 0)
                  {
                     _loc4_.x = _loc3_.x - int(_loc7_ / 2) * (_cells[_loc7_].width + _loc6_);
                     _loc4_.y = _loc3_.y;
                  }
                  else
                  {
                     _loc4_.x = _loc2_.x + int(_loc7_ / 2) * (_cells[_loc7_].width + _loc6_);
                     _loc4_.y = _loc2_.y;
                  }
                  _loc8_.push(_loc4_);
                  _loc7_++;
               }
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat("indiana.cell.index_6");
               _loc7_;
               while(_loc7_ < _loc5_)
               {
                  _loc4_ = new Point();
                  if(_loc7_ % 2 == 0)
                  {
                     _loc4_.x = _loc1_.x - int(_loc7_ / 2) * (_cells[_loc7_].width + _loc6_);
                     _loc4_.y = _loc1_.y;
                  }
                  else
                  {
                     _loc4_.x = _loc1_.x + int(Math.ceil(_loc7_ / 2)) * (_cells[_loc7_].width + _loc6_);
                     _loc4_.y = _loc1_.y;
                  }
                  _loc8_.push(_loc4_);
                  _loc7_++;
               }
            }
            _loc8_.sort(sortPos);
            _loc7_ = 0;
            _loc7_;
            while(_loc7_ < _loc5_)
            {
               _cells[_loc7_].x = _loc8_[_loc7_].x;
               _cells[_loc7_].y = _loc8_[_loc7_].y;
               _loc7_++;
            }
         }
      }
      
      private function sortPos(param1:Point, param2:Point) : Number
      {
         if(param1.x < param2.x)
         {
            return -1;
         }
         if(param1.x > param2.x)
         {
            return 1;
         }
         return 0;
      }
      
      public function setInfos(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         clearCells();
         if(param1 != null)
         {
            _loc3_ = param1.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = new IndianaTitleCell();
               _loc2_.setContentSize(44,44);
               _loc2_.addEventListener("click",__cellClickHandler);
               _loc2_.Info = param1[_loc4_];
               _cells.push(_loc2_);
               addChild(_loc2_);
               _loc4_++;
            }
            sortCell();
         }
      }
      
      public function get currentCell() : IndianaTitleCell
      {
         return _currentCell;
      }
      
      public function get leftCell() : IndianaTitleCell
      {
         var _loc1_:int = 0;
         if(_currentCell)
         {
            _loc1_ = _cells.indexOf(_currentCell);
            if(_loc1_ > 0)
            {
               _loc1_--;
               return _cells[_loc1_];
            }
            return _cells[_cells.length - 1];
         }
         return null;
      }
      
      public function get rightCell() : IndianaTitleCell
      {
         var _loc1_:int = 0;
         if(_currentCell)
         {
            _loc1_ = _cells.indexOf(_currentCell);
            if(_loc1_ < _cells.length - 1)
            {
               _loc1_++;
               return _cells[_loc1_];
            }
            return _cells[0];
         }
         return null;
      }
      
      private function __cellClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:IndianaTitleCell = param1.currentTarget as IndianaTitleCell;
         if(_currentCell != _loc2_)
         {
            _currentCell.selected = false;
            _currentCell = _loc2_;
            _loc2_.selected = true;
            if(_currentCell.Info)
            {
               SocketManager.Instance.out.sendUpdateSysDate();
               SocketManager.Instance.out.sendIndianaEnterGame(_currentCell.Info.PeriodId);
            }
         }
      }
      
      public function updateCurrentCell(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _cells.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_cells[_loc3_].Info.PeriodId == param1)
            {
               if(_currentCell)
               {
                  if(_currentCell != _cells[_loc3_])
                  {
                     _currentCell.selected = false;
                     _cells[_loc3_].selected = true;
                     _currentCell = _cells[_loc3_];
                     return;
                  }
               }
               else
               {
                  _currentCell = _cells[_loc3_];
                  _currentCell.selected = true;
               }
            }
            _loc3_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _cells.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _cells[_loc2_].removeEventListener("click",__cellClickHandler);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         removeEvent();
         var _loc1_:int = _cells.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(_cells[_loc2_]);
            _cells[_loc2_] = null;
            _loc2_++;
         }
         _cells = null;
      }
   }
}
