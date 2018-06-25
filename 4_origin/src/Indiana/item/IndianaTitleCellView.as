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
         var cell:IndianaTitleCell = new IndianaTitleCell();
         cell.setContentSize(44,44);
         cell.addEventListener("click",__cellClickHandler);
         addChild(cell);
         group.push(cell);
         cell = new IndianaTitleCell();
         cell.setContentSize(44,44);
         addChild(cell);
         cell.addEventListener("click",__cellClickHandler);
         group.push(cell);
         cell = new IndianaTitleCell();
         cell.setContentSize(44,44);
         addChild(cell);
         cell.addEventListener("click",__cellClickHandler);
         group.push(cell);
         PositionUtils.setPos(group[0],"indiana.cell.index_1");
         PositionUtils.setPos(group[1],"indiana.cell.index_2");
         PositionUtils.setPos(group[2],"indiana.cell.index_3");
      }
      
      private function clearCells() : void
      {
         var item:* = null;
         var len:int = _cells.length;
         while(_cells.length > 0)
         {
            item = _cells.shift();
            ObjectUtils.disposeObject(item);
            item = null;
         }
      }
      
      private function sortCell() : void
      {
         var i:int = 0;
         var space:int = 0;
         var item:* = null;
         var leftpos:* = null;
         var rightpos:* = null;
         var centerpos:* = null;
         var len:int = _cells.length;
         var pos:Array = [];
         if(len > 0)
         {
            i = 0;
            space = 10;
            if(len % 2 == 0)
            {
               leftpos = ComponentFactory.Instance.creat("indiana.cell.index_4");
               rightpos = ComponentFactory.Instance.creat("indiana.cell.index_5");
               i;
               while(i < len)
               {
                  item = new Point();
                  if(i % 2 == 0)
                  {
                     item.x = leftpos.x - int(i / 2) * (_cells[i].width + space);
                     item.y = leftpos.y;
                  }
                  else
                  {
                     item.x = rightpos.x + int(i / 2) * (_cells[i].width + space);
                     item.y = rightpos.y;
                  }
                  pos.push(item);
                  i++;
               }
            }
            else
            {
               centerpos = ComponentFactory.Instance.creat("indiana.cell.index_6");
               i;
               while(i < len)
               {
                  item = new Point();
                  if(i % 2 == 0)
                  {
                     item.x = centerpos.x - int(i / 2) * (_cells[i].width + space);
                     item.y = centerpos.y;
                  }
                  else
                  {
                     item.x = centerpos.x + int(Math.ceil(i / 2)) * (_cells[i].width + space);
                     item.y = centerpos.y;
                  }
                  pos.push(item);
                  i++;
               }
            }
            pos.sort(sortPos);
            i = 0;
            i;
            while(i < len)
            {
               _cells[i].x = pos[i].x;
               _cells[i].y = pos[i].y;
               i++;
            }
         }
      }
      
      private function sortPos(x:Point, y:Point) : Number
      {
         if(x.x < y.x)
         {
            return -1;
         }
         if(x.x > y.x)
         {
            return 1;
         }
         return 0;
      }
      
      public function setInfos(infos:Array) : void
      {
         var len:int = 0;
         var cell:* = null;
         var i:int = 0;
         clearCells();
         if(infos != null)
         {
            len = infos.length;
            for(i = 0; i < len; )
            {
               cell = new IndianaTitleCell();
               cell.setContentSize(44,44);
               cell.addEventListener("click",__cellClickHandler);
               cell.Info = infos[i];
               _cells.push(cell);
               addChild(cell);
               i++;
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
         var index:int = 0;
         if(_currentCell)
         {
            index = _cells.indexOf(_currentCell);
            if(index > 0)
            {
               index--;
               return _cells[index];
            }
            return _cells[_cells.length - 1];
         }
         return null;
      }
      
      public function get rightCell() : IndianaTitleCell
      {
         var index:int = 0;
         if(_currentCell)
         {
            index = _cells.indexOf(_currentCell);
            if(index < _cells.length - 1)
            {
               index++;
               return _cells[index];
            }
            return _cells[0];
         }
         return null;
      }
      
      private function __cellClickHandler(evt:MouseEvent) : void
      {
         var target:IndianaTitleCell = evt.currentTarget as IndianaTitleCell;
         if(_currentCell != target)
         {
            _currentCell.selected = false;
            _currentCell = target;
            target.selected = true;
            if(_currentCell.Info)
            {
               SocketManager.Instance.out.sendUpdateSysDate();
               SocketManager.Instance.out.sendIndianaEnterGame(_currentCell.Info.PeriodId);
            }
         }
      }
      
      public function updateCurrentCell(id:int) : void
      {
         var i:int = 0;
         var len:int = _cells.length;
         for(i = 0; i < len; )
         {
            if(_cells[i].Info.PeriodId == id)
            {
               if(_currentCell)
               {
                  if(_currentCell != _cells[i])
                  {
                     _currentCell.selected = false;
                     _cells[i].selected = true;
                     _currentCell = _cells[i];
                     return;
                  }
               }
               else
               {
                  _currentCell = _cells[i];
                  _currentCell.selected = true;
               }
            }
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         var len:int = _cells.length;
         for(i = 0; i < len; )
         {
            _cells[i].removeEventListener("click",__cellClickHandler);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         var len:int = _cells.length;
         for(i = 0; i < len; )
         {
            ObjectUtils.disposeObject(_cells[i]);
            _cells[i] = null;
            i++;
         }
         _cells = null;
      }
   }
}
