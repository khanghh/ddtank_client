package sanXiao.model
{
   import sanXiao.game.SXCellItem;
   
   public class SXModel
   {
      
      public static const PROP_NONE:int = 0;
      
      public static const PROP_CROSS_BOMB:int = 1;
      
      public static const PROP_SQUARE_BOMB:int = 2;
      
      public static const PROP_CLEAR_COLOR:int = 3;
      
      public static const PROP_CHANGE_COLOR:int = 4;
       
      
      public var ROW_COUNT:Number = 7;
      
      public var COLUMN_COUNT:Number = 7;
      
      public var tweenDuration:Number = 0.5;
      
      public var boomLength:int = 3;
      
      public var typeCount:int = 5;
      
      public var curProp:int = 0;
      
      private var _map:Vector.<Vector.<SXCellData>>;
      
      private var _row:Number = 0;
      
      private var _column:Number = 0;
      
      public function SXModel()
      {
         super();
      }
      
      public function initMap($row:Number = 7, $column:Number = 7) : void
      {
         var i:int = 0;
         var j:int = 0;
         _row = $row;
         _column = $column;
         _map = new Vector.<Vector.<SXCellData>>();
         for(i = 0; i < $row; )
         {
            _map[i] = new Vector.<SXCellData>();
            for(j = 0; j < $column; )
            {
               _map[i][j] = new SXCellData(i,j);
               j++;
            }
            i++;
         }
      }
      
      public function createNewMap() : void
      {
         var i:int = 0;
         var j:int = 0;
         var tempType:int = 0;
         var preType:int = 0;
         for(i = 0; i < _row; )
         {
            for(j = 0; j < _column; )
            {
               tempType = Math.random() * typeCount + 1;
               preType = _map[Math.max(0,i - 1)][j].type;
               if(preType == tempType)
               {
                  tempType = (preType + 2) % typeCount + 1;
               }
               preType = _map[i][Math.max(0,j - 2)].type;
               if(preType == tempType)
               {
                  tempType = (tempType + 2) % typeCount + 1;
               }
               _map[i][j].type = tempType;
               j++;
            }
            i++;
         }
      }
      
      public function setMap(mapInfo:Array) : void
      {
         var i:int = 0;
         var len:int = mapInfo.length;
         for(i = 2; i < len; )
         {
            _map[mapInfo[i - 2]][mapInfo[i - 1]].type = mapInfo[i];
            i = i + 3;
         }
      }
      
      public function getData(r:int, c:int) : SXCellData
      {
         return _map[r][c];
      }
      
      public function map() : Vector.<Vector.<SXCellData>>
      {
         return _map;
      }
      
      public function mapInfo() : Array
      {
         var i:int = 0;
         var j:int = 0;
         var _mapInfo:Array = [];
         for(i = 0; i < _row; )
         {
            for(j = 0; j < _column; )
            {
               _mapInfo.push(i);
               _mapInfo.push(j);
               _mapInfo.push(_map[i][j].type);
               j++;
            }
            i++;
         }
         return _mapInfo;
      }
      
      public function mapDataArray() : Vector.<SXCellData>
      {
         var i:int = 0;
         var j:int = 0;
         var _mapDataArr:Vector.<SXCellData> = new Vector.<SXCellData>();
         for(i = 0; i < _row; )
         {
            for(j = 0; j < _column; )
            {
               _mapDataArr.push(new SXCellData(i,j,_map[i][j].type));
               j++;
            }
            i++;
         }
         return _mapDataArr;
      }
      
      public function cellTypeExchange(pos1:Pos, type1:int, pos2:Pos, type2:int) : Boolean
      {
         var xDis:int = pos1.row - pos2.row;
         var yDis:int = pos1.column - pos2.column;
         if((xDis == 1 || xDis == -1) && yDis == 0 || (yDis == 1 || yDis == -1) && xDis == 0)
         {
            _map[pos1.row][pos1.column].type = type2;
            _map[pos2.row][pos2.column].type = type1;
            return true;
         }
         return false;
      }
      
      public function cellPropCrossBomb(pos:Pos) : Vector.<SXCellData>
      {
         var r:* = 0;
         var c:* = 0;
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var pR:int = pos.row;
         var pC:int = pos.column;
         r = pR;
         c = 0;
         while(c < COLUMN_COUNT)
         {
            boomList.push(_map[r][c]);
            c++;
         }
         r = 0;
         c = pC;
         while(r < pR)
         {
            boomList.push(_map[r][c]);
            r++;
         }
         for(r++; r < ROW_COUNT; )
         {
            boomList.push(_map[r][c]);
            r++;
         }
         return boomList;
      }
      
      public function cellPropSquareBomb(pos:Pos) : Vector.<SXCellData>
      {
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var pR:int = pos.row;
         var pC:int = pos.column;
         var pCAdd1:* = COLUMN_COUNT > pC + 1;
         var pCSubtract1:* = 0 < pC;
         var pRAdd1:* = ROW_COUNT > pR + 1;
         var pRSubtract1:* = 0 < pR;
         pRSubtract1 && pCSubtract1 && boomList.push(_map[pR - 1][pC - 1]);
         pCSubtract1 && boomList.push(_map[pR][pC - 1]);
         pRAdd1 && pCSubtract1 && boomList.push(_map[pR + 1][pC - 1]);
         pRSubtract1 && boomList.push(_map[pR - 1][pC]);
         boomList.push(_map[pR][pC]);
         pRAdd1 && boomList.push(_map[pR + 1][pC]);
         pRSubtract1 && pCAdd1 && boomList.push(_map[pR - 1][pC + 1]);
         pCAdd1 && boomList.push(_map[pR][pC + 1]);
         pRAdd1 && pCAdd1 && boomList.push(_map[pR + 1][pC + 1]);
         return boomList;
      }
      
      public function cellPropClearColor(pos:Pos) : Vector.<SXCellData>
      {
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var type:int = _map[pos.row][pos.column].type;
         var _loc9_:int = 0;
         var _loc8_:* = _map;
         for each(var dataVec in _map)
         {
            var _loc7_:int = 0;
            var _loc6_:* = dataVec;
            for each(var data in dataVec)
            {
               if(data.type == type)
               {
                  boomList.push(data);
               }
            }
         }
         return boomList;
      }
      
      public function cellPropChangeColor(pos:Pos) : Vector.<SXCellData>
      {
         var newType:int = 0;
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var type:int = _map[pos.row][pos.column].type;
         do
         {
            newType = Math.random() * typeCount + 1;
         }
         while(newType == type);
         
         var _loc10_:int = 0;
         var _loc9_:* = _map;
         for each(var dataVec in _map)
         {
            var _loc8_:int = 0;
            var _loc7_:* = dataVec;
            for each(var data in dataVec)
            {
               if(data.type == type)
               {
                  data.type = newType;
                  boomList.push(data);
               }
            }
         }
         return boomList;
      }
      
      private function checkBoomList(pos:Pos) : Vector.<SXCellData>
      {
         var curData:* = null;
         var i:int = 0;
         var type:int = _map[pos.row][pos.column].type;
         var verticalCellList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var horizontalCellList:Vector.<SXCellData> = new Vector.<SXCellData>();
         i = pos.row - 1;
         while(i >= 0)
         {
            curData = _map[i][pos.column];
            var _loc10_:* = curData.type;
            if(type !== _loc10_)
            {
               i = 0;
            }
            else if(!curData.isLocked)
            {
               curData.isLocked = true;
               verticalCellList.push(curData);
            }
            i = i - 1;
         }
         i = pos.row + 1;
         while(i < _row)
         {
            curData = _map[i][pos.column];
            _loc10_ = curData.type;
            if(type !== _loc10_)
            {
               i = _row;
            }
            else if(!curData.isLocked)
            {
               curData.isLocked = true;
               verticalCellList.push(curData);
            }
            i = i + 1;
         }
         i = pos.column - 1;
         while(i >= 0)
         {
            curData = _map[pos.row][i];
            _loc10_ = curData.type;
            if(type !== _loc10_)
            {
               i = 0;
            }
            else if(!curData.isLocked)
            {
               curData.isLocked = true;
               horizontalCellList.push(curData);
            }
            i = i - 1;
         }
         i = pos.column + 1;
         while(i < _column)
         {
            curData = _map[pos.row][i];
            _loc10_ = curData.type;
            if(type !== _loc10_)
            {
               i = _column;
            }
            else if(!curData.isLocked)
            {
               curData.isLocked = true;
               horizontalCellList.push(curData);
            }
            i = i + 1;
         }
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         if(verticalCellList.length >= boomLength - 1)
         {
            boomList = boomList.concat(verticalCellList);
         }
         else
         {
            var _loc12_:int = 0;
            var _loc11_:* = verticalCellList;
            for each(var v in verticalCellList)
            {
               v.isLocked = false;
            }
         }
         if(horizontalCellList.length >= boomLength - 1)
         {
            boomList = boomList.concat(horizontalCellList);
         }
         else
         {
            var _loc14_:int = 0;
            var _loc13_:* = horizontalCellList;
            for each(var h in horizontalCellList)
            {
               h.isLocked = false;
            }
         }
         if(boomList.length > 0 && _map[pos.row][pos.column].isLocked == false)
         {
            _map[pos.row][pos.column].isLocked = true;
            boomList.push(_map[pos.row][pos.column]);
         }
         curData = null;
         return boomList;
      }
      
      public function canBoomCellsList(posArr:Array) : Vector.<SXCellData>
      {
         var boomList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc6_:int = 0;
         var _loc5_:* = posArr;
         for each(var v in posArr)
         {
            boomList = boomList.concat(checkBoomList(v.curPos));
         }
         var _loc8_:int = 0;
         var _loc7_:* = boomList;
         for each(var sx in boomList)
         {
            sx.isLocked = false;
         }
         return boomList;
      }
      
      private function spread(boomList:Vector.<SXCellData>) : Vector.<SXCellData>
      {
         boomList = boomList;
         check = function($data:SXCellData):void
         {
            var cellData:* = null;
            var i:int = 0;
            var type:int = $data.type;
            i = $data.row - 1;
            if(i >= 0)
            {
               cellData = _map[i][$data.column];
               if(cellData.type == type && cellData.isLocked == false)
               {
                  cellData.isLocked = true;
                  spreadList.push(cellData);
                  check(cellData);
               }
            }
            i = $data.row + 1;
            if(i < _row)
            {
               cellData = _map[i][$data.column];
               if(cellData.type == type && cellData.isLocked == false)
               {
                  cellData.isLocked = true;
                  spreadList.push(cellData);
                  check(cellData);
               }
            }
            i = $data.column - 1;
            if(i >= 0)
            {
               cellData = _map[$data.row][i];
               if(cellData.type == type && cellData.isLocked == false)
               {
                  cellData.isLocked = true;
                  spreadList.push(cellData);
                  check(cellData);
               }
            }
            i = $data.column + 1;
            if(i < _column)
            {
               cellData = _map[$data.row][i];
               if(cellData.type == type && cellData.isLocked == false)
               {
                  cellData.isLocked = true;
                  spreadList.push(cellData);
                  check(cellData);
               }
            }
         };
         var spreadList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var len:int = boomList.length;
         for(var k:int = 0; k < len; )
         {
            check(boomList[k]);
            k = Number(k) + 1;
         }
         if(spreadList.length > 0)
         {
            var boomList:Vector.<SXCellData> = boomList.concat(spreadList);
         }
         return boomList;
      }
      
      public function boomAndFall(posArr:Vector.<SXCellData>) : Vector.<SXCellData>
      {
         var a:int = 0;
         var b:int = 0;
         var tempCellData:* = null;
         var arrCol:* = undefined;
         var j:int = 0;
         var i:int = 0;
         for(a = 0; a < 7; )
         {
            for(b = 0; b < 7; )
            {
               trace("==->",a,b,_map[a][b].type);
               b++;
            }
            a++;
         }
         var _loc11_:int = 0;
         var _loc10_:* = posArr;
         for each(var v in posArr)
         {
            v.type = 0;
         }
         var newCellDataList:Vector.<SXCellData> = new Vector.<SXCellData>();
         for(j = 0; j < COLUMN_COUNT; )
         {
            arrCol = new Vector.<int>();
            for(i = ROW_COUNT - 1; i >= 0; )
            {
               tempCellData = _map[i][j];
               if(tempCellData.type != 0)
               {
                  arrCol.push(tempCellData.type);
               }
               tempCellData.type = 0;
               i--;
            }
            for(i = ROW_COUNT - 1; i >= 0; )
            {
               if(arrCol.length == 0)
               {
                  _map[i][j].type = int(Math.random() * typeCount + 1);
                  newCellDataList.push(_map[i][j]);
               }
               else
               {
                  _map[i][j].type = arrCol.shift();
               }
               i--;
            }
            j++;
         }
         tempCellData = null;
         arrCol = null;
         return newCellDataList;
      }
      
      public function isDieMap() : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < ROW_COUNT; )
         {
            for(j = 0; j < COLUMN_COUNT; )
            {
               _map[i][j].row = i;
               _map[i][j].column = j;
               if(isDie(i,j) == false)
               {
                  return false;
               }
               j++;
            }
            i++;
         }
         return true;
      }
      
      private function isDie($x:Number, $y:Number) : Boolean
      {
         var lx1:* = $x - 1 > -1;
         var lx2:* = $x - 2 > -1;
         var lx3:* = $x - 3 > -1;
         var bx1:* = $x + 1 < ROW_COUNT;
         var bx2:* = $x + 2 < ROW_COUNT;
         var bx3:* = $x + 3 < ROW_COUNT;
         var ly1:* = $y - 1 > -1;
         var ly2:* = $y - 2 > -1;
         var ly3:* = $y - 3 > -1;
         var by1:* = $y + 1 < COLUMN_COUNT;
         var by2:* = $y + 2 < COLUMN_COUNT;
         var by3:* = $y + 3 < COLUMN_COUNT;
         var type:int = _map[$x][$y].type;
         if(bx1)
         {
            if(_map[$x + 1][$y].type == type)
            {
               if(bx3)
               {
                  if(_map[$x + 3][$y].type == type)
                  {
                     return false;
                  }
               }
               if(bx2 && by1)
               {
                  if(_map[$x + 2][$y + 1].type == type)
                  {
                     return false;
                  }
               }
               if(bx2 && ly1)
               {
                  if(_map[$x + 2][$y - 1].type == type)
                  {
                     return false;
                  }
               }
               if(lx2)
               {
                  if(_map[$x - 2][$y].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && ly1)
               {
                  if(_map[$x - 1][$y - 1].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && by1)
               {
                  if(_map[$x - 1][$y + 1].type == type)
                  {
                     return false;
                  }
               }
            }
            if(ly1 && by1)
            {
               if(_map[$x + 1][$y - 1].type == type && _map[$x + 1][$y + 1].type == type)
               {
                  return false;
               }
            }
         }
         if(lx1)
         {
            if(_map[$x - 1][$y].type == type)
            {
               if(lx3)
               {
                  if(_map[$x - 3][$y].type == type)
                  {
                     return false;
                  }
               }
               if(lx2 && by1)
               {
                  if(_map[$x - 2][$y + 1].type == type)
                  {
                     return false;
                  }
               }
               if(lx2 && ly1)
               {
                  if(_map[$x - 2][$y - 1].type == type)
                  {
                     return false;
                  }
               }
               if(bx2)
               {
                  if(_map[$x + 2][$y].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && ly1)
               {
                  if(_map[$x + 1][$y - 1].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && by1)
               {
                  if(_map[$x + 1][$y + 1].type == type)
                  {
                     return false;
                  }
               }
            }
            if(ly1 && by1)
            {
               if(_map[$x - 1][$y - 1].type == type && _map[$x - 1][$y + 1].type == type)
               {
                  return false;
               }
            }
         }
         if(by1)
         {
            if(_map[$x][$y + 1].type == type)
            {
               if(by3)
               {
                  if(_map[$x][$y + 3].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && by2)
               {
                  if(_map[$x - 1][$y + 2].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && by2)
               {
                  if(_map[$x + 1][$y + 2].type == type)
                  {
                     return false;
                  }
               }
               if(ly2)
               {
                  if(_map[$x][$y - 2].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && ly1)
               {
                  if(_map[$x + 1][$y - 1].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && ly1)
               {
                  if(_map[$x - 1][$y - 1].type == type)
                  {
                     return false;
                  }
               }
            }
            if(lx1 && bx1)
            {
               if(_map[$x - 1][$y + 1].type == type && _map[$x + 1][$y + 1].type == type)
               {
                  return false;
               }
            }
         }
         if(ly1)
         {
            if(_map[$x][$y - 1].type == type)
            {
               if(ly3)
               {
                  if(_map[$x][$y - 3].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && ly2)
               {
                  if(_map[$x - 1][$y - 2].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && ly2)
               {
                  if(_map[$x + 1][$y - 2].type == type)
                  {
                     return false;
                  }
               }
               if(by2)
               {
                  if(_map[$x][$y + 2].type == type)
                  {
                     return false;
                  }
               }
               if(bx1 && by1)
               {
                  if(_map[$x + 1][$y + 1].type == type)
                  {
                     return false;
                  }
               }
               if(lx1 && by1)
               {
                  if(_map[$x - 1][$y + 1].type == type)
                  {
                     return false;
                  }
               }
            }
            if(lx1 && bx1)
            {
               if(_map[$x - 1][$y - 1].type == type && _map[$x + 1][$y - 1].type == type)
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}
