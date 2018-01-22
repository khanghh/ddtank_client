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
      
      public function initMap(param1:Number = 7, param2:Number = 7) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _row = param1;
         _column = param2;
         _map = new Vector.<Vector.<SXCellData>>();
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _map[_loc4_] = new Vector.<SXCellData>();
            _loc3_ = 0;
            while(_loc3_ < param2)
            {
               _map[_loc4_][_loc3_] = new SXCellData(_loc4_,_loc3_);
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      public function createNewMap() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _row)
         {
            _loc3_ = 0;
            while(_loc3_ < _column)
            {
               _loc2_ = Math.random() * typeCount + 1;
               _loc1_ = _map[Math.max(0,_loc4_ - 1)][_loc3_].type;
               if(_loc1_ == _loc2_)
               {
                  _loc2_ = (_loc1_ + 2) % typeCount + 1;
               }
               _loc1_ = _map[_loc4_][Math.max(0,_loc3_ - 2)].type;
               if(_loc1_ == _loc2_)
               {
                  _loc2_ = (_loc2_ + 2) % typeCount + 1;
               }
               _map[_loc4_][_loc3_].type = _loc2_;
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      public function setMap(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 2;
         while(_loc3_ < _loc2_)
         {
            _map[param1[_loc3_ - 2]][param1[_loc3_ - 1]].type = param1[_loc3_];
            _loc3_ = _loc3_ + 3;
         }
      }
      
      public function getData(param1:int, param2:int) : SXCellData
      {
         return _map[param1][param2];
      }
      
      public function map() : Vector.<Vector.<SXCellData>>
      {
         return _map;
      }
      
      public function mapInfo() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _row)
         {
            _loc2_ = 0;
            while(_loc2_ < _column)
            {
               _loc1_.push(_loc3_);
               _loc1_.push(_loc2_);
               _loc1_.push(_map[_loc3_][_loc2_].type);
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function mapDataArray() : Vector.<SXCellData>
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Vector.<SXCellData> = new Vector.<SXCellData>();
         _loc3_ = 0;
         while(_loc3_ < _row)
         {
            _loc2_ = 0;
            while(_loc2_ < _column)
            {
               _loc1_.push(new SXCellData(_loc3_,_loc2_,_map[_loc3_][_loc2_].type));
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function cellTypeExchange(param1:Pos, param2:int, param3:Pos, param4:int) : Boolean
      {
         var _loc5_:int = param1.row - param3.row;
         var _loc6_:int = param1.column - param3.column;
         if((_loc5_ == 1 || _loc5_ == -1) && _loc6_ == 0 || (_loc6_ == 1 || _loc6_ == -1) && _loc5_ == 0)
         {
            _map[param1.row][param1.column].type = param4;
            _map[param3.row][param3.column].type = param2;
            return true;
         }
         return false;
      }
      
      public function cellPropCrossBomb(param1:Pos) : Vector.<SXCellData>
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc5_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc6_:int = param1.row;
         var _loc4_:int = param1.column;
         _loc3_ = _loc6_;
         _loc2_ = 0;
         while(_loc2_ < COLUMN_COUNT)
         {
            _loc5_.push(_map[_loc3_][_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         _loc2_ = _loc4_;
         while(_loc3_ < _loc6_)
         {
            _loc5_.push(_map[_loc3_][_loc2_]);
            _loc3_++;
         }
         _loc3_++;
         while(_loc3_ < ROW_COUNT)
         {
            _loc5_.push(_map[_loc3_][_loc2_]);
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function cellPropSquareBomb(param1:Pos) : Vector.<SXCellData>
      {
         var _loc6_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc7_:int = param1.row;
         var _loc5_:int = param1.column;
         var _loc2_:* = COLUMN_COUNT > _loc5_ + 1;
         var _loc3_:* = 0 < _loc5_;
         var _loc8_:* = ROW_COUNT > _loc7_ + 1;
         var _loc4_:* = 0 < _loc7_;
         _loc4_ && _loc3_ && _loc6_.push(_map[_loc7_ - 1][_loc5_ - 1]);
         _loc3_ && _loc6_.push(_map[_loc7_][_loc5_ - 1]);
         _loc8_ && _loc3_ && _loc6_.push(_map[_loc7_ + 1][_loc5_ - 1]);
         _loc4_ && _loc6_.push(_map[_loc7_ - 1][_loc5_]);
         _loc6_.push(_map[_loc7_][_loc5_]);
         _loc8_ && _loc6_.push(_map[_loc7_ + 1][_loc5_]);
         _loc4_ && _loc2_ && _loc6_.push(_map[_loc7_ - 1][_loc5_ + 1]);
         _loc2_ && _loc6_.push(_map[_loc7_][_loc5_ + 1]);
         _loc8_ && _loc2_ && _loc6_.push(_map[_loc7_ + 1][_loc5_ + 1]);
         return _loc6_;
      }
      
      public function cellPropClearColor(param1:Pos) : Vector.<SXCellData>
      {
         var _loc3_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc5_:int = _map[param1.row][param1.column].type;
         var _loc9_:int = 0;
         var _loc8_:* = _map;
         for each(var _loc2_ in _map)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc2_;
            for each(var _loc4_ in _loc2_)
            {
               if(_loc4_.type == _loc5_)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function cellPropChangeColor(param1:Pos) : Vector.<SXCellData>
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc6_:int = _map[param1.row][param1.column].type;
         do
         {
            _loc5_ = Math.random() * typeCount + 1;
         }
         while(_loc5_ == _loc6_);
         
         var _loc10_:int = 0;
         var _loc9_:* = _map;
         for each(var _loc2_ in _map)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for each(var _loc4_ in _loc2_)
            {
               if(_loc4_.type == _loc6_)
               {
                  _loc4_.type = _loc5_;
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      private function checkBoomList(param1:Pos) : Vector.<SXCellData>
      {
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = _map[param1.row][param1.column].type;
         var _loc3_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc9_:Vector.<SXCellData> = new Vector.<SXCellData>();
         _loc8_ = param1.row - 1;
         while(_loc8_ >= 0)
         {
            _loc4_ = _map[_loc8_][param1.column];
            var _loc10_:* = _loc4_.type;
            if(_loc6_ !== _loc10_)
            {
               _loc8_ = 0;
            }
            else if(!_loc4_.isLocked)
            {
               _loc4_.isLocked = true;
               _loc3_.push(_loc4_);
            }
            _loc8_ = _loc8_ - 1;
         }
         _loc8_ = param1.row + 1;
         while(_loc8_ < _row)
         {
            _loc4_ = _map[_loc8_][param1.column];
            _loc10_ = _loc4_.type;
            if(_loc6_ !== _loc10_)
            {
               _loc8_ = _row;
            }
            else if(!_loc4_.isLocked)
            {
               _loc4_.isLocked = true;
               _loc3_.push(_loc4_);
            }
            _loc8_ = _loc8_ + 1;
         }
         _loc8_ = param1.column - 1;
         while(_loc8_ >= 0)
         {
            _loc4_ = _map[param1.row][_loc8_];
            _loc10_ = _loc4_.type;
            if(_loc6_ !== _loc10_)
            {
               _loc8_ = 0;
            }
            else if(!_loc4_.isLocked)
            {
               _loc4_.isLocked = true;
               _loc9_.push(_loc4_);
            }
            _loc8_ = _loc8_ - 1;
         }
         _loc8_ = param1.column + 1;
         while(_loc8_ < _column)
         {
            _loc4_ = _map[param1.row][_loc8_];
            _loc10_ = _loc4_.type;
            if(_loc6_ !== _loc10_)
            {
               _loc8_ = _column;
            }
            else if(!_loc4_.isLocked)
            {
               _loc4_.isLocked = true;
               _loc9_.push(_loc4_);
            }
            _loc8_ = _loc8_ + 1;
         }
         var _loc5_:Vector.<SXCellData> = new Vector.<SXCellData>();
         if(_loc3_.length >= boomLength - 1)
         {
            _loc5_ = _loc5_.concat(_loc3_);
         }
         else
         {
            var _loc12_:int = 0;
            var _loc11_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               _loc2_.isLocked = false;
            }
         }
         if(_loc9_.length >= boomLength - 1)
         {
            _loc5_ = _loc5_.concat(_loc9_);
         }
         else
         {
            var _loc14_:int = 0;
            var _loc13_:* = _loc9_;
            for each(var _loc7_ in _loc9_)
            {
               _loc7_.isLocked = false;
            }
         }
         if(_loc5_.length > 0 && _map[param1.row][param1.column].isLocked == false)
         {
            _map[param1.row][param1.column].isLocked = true;
            _loc5_.push(_map[param1.row][param1.column]);
         }
         _loc4_ = null;
         return _loc5_;
      }
      
      public function canBoomCellsList(param1:Array) : Vector.<SXCellData>
      {
         var _loc3_:Vector.<SXCellData> = new Vector.<SXCellData>();
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = _loc3_.concat(checkBoomList(_loc2_.curPos));
         }
         var _loc8_:int = 0;
         var _loc7_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.isLocked = false;
         }
         return _loc3_;
      }
      
      private function spread(param1:Vector.<SXCellData>) : Vector.<SXCellData>
      {
         boomList = param1;
         check = function(param1:SXCellData):void
         {
            var _loc2_:* = null;
            var _loc4_:int = 0;
            var _loc3_:int = param1.type;
            _loc4_ = param1.row - 1;
            if(_loc4_ >= 0)
            {
               _loc2_ = _map[_loc4_][param1.column];
               if(_loc2_.type == _loc3_ && _loc2_.isLocked == false)
               {
                  _loc2_.isLocked = true;
                  spreadList.push(_loc2_);
                  check(_loc2_);
               }
            }
            _loc4_ = param1.row + 1;
            if(_loc4_ < _row)
            {
               _loc2_ = _map[_loc4_][param1.column];
               if(_loc2_.type == _loc3_ && _loc2_.isLocked == false)
               {
                  _loc2_.isLocked = true;
                  spreadList.push(_loc2_);
                  check(_loc2_);
               }
            }
            _loc4_ = param1.column - 1;
            if(_loc4_ >= 0)
            {
               _loc2_ = _map[param1.row][_loc4_];
               if(_loc2_.type == _loc3_ && _loc2_.isLocked == false)
               {
                  _loc2_.isLocked = true;
                  spreadList.push(_loc2_);
                  check(_loc2_);
               }
            }
            _loc4_ = param1.column + 1;
            if(_loc4_ < _column)
            {
               _loc2_ = _map[param1.row][_loc4_];
               if(_loc2_.type == _loc3_ && _loc2_.isLocked == false)
               {
                  _loc2_.isLocked = true;
                  spreadList.push(_loc2_);
                  check(_loc2_);
               }
            }
         };
         var spreadList:Vector.<SXCellData> = new Vector.<SXCellData>();
         var len:int = boomList.length;
         var k:int = 0;
         while(k < len)
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
      
      public function boomAndFall(param1:Vector.<SXCellData>) : Vector.<SXCellData>
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc4_ = 0;
            while(_loc4_ < 7)
            {
               trace("==->",_loc5_,_loc4_,_map[_loc5_][_loc4_].type);
               _loc4_++;
            }
            _loc5_++;
         }
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc2_.type = 0;
         }
         var _loc8_:Vector.<SXCellData> = new Vector.<SXCellData>();
         _loc7_ = 0;
         while(_loc7_ < COLUMN_COUNT)
         {
            _loc6_ = new Vector.<int>();
            _loc9_ = ROW_COUNT - 1;
            while(_loc9_ >= 0)
            {
               _loc3_ = _map[_loc9_][_loc7_];
               if(_loc3_.type != 0)
               {
                  _loc6_.push(_loc3_.type);
               }
               _loc3_.type = 0;
               _loc9_--;
            }
            _loc9_ = ROW_COUNT - 1;
            while(_loc9_ >= 0)
            {
               if(_loc6_.length == 0)
               {
                  _map[_loc9_][_loc7_].type = int(Math.random() * typeCount + 1);
                  _loc8_.push(_map[_loc9_][_loc7_]);
               }
               else
               {
                  _map[_loc9_][_loc7_].type = _loc6_.shift();
               }
               _loc9_--;
            }
            _loc7_++;
         }
         _loc3_ = null;
         _loc6_ = null;
         return _loc8_;
      }
      
      public function isDieMap() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < ROW_COUNT)
         {
            _loc1_ = 0;
            while(_loc1_ < COLUMN_COUNT)
            {
               _map[_loc2_][_loc1_].row = _loc2_;
               _map[_loc2_][_loc1_].column = _loc1_;
               if(isDie(_loc2_,_loc1_) == false)
               {
                  return false;
               }
               _loc1_++;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function isDie(param1:Number, param2:Number) : Boolean
      {
         var _loc7_:* = param1 - 1 > -1;
         var _loc9_:* = param1 - 2 > -1;
         var _loc8_:* = param1 - 3 > -1;
         var _loc10_:* = param1 + 1 < ROW_COUNT;
         var _loc14_:* = param1 + 2 < ROW_COUNT;
         var _loc15_:* = param1 + 3 < ROW_COUNT;
         var _loc6_:* = param2 - 1 > -1;
         var _loc5_:* = param2 - 2 > -1;
         var _loc4_:* = param2 - 3 > -1;
         var _loc11_:* = param2 + 1 < COLUMN_COUNT;
         var _loc12_:* = param2 + 2 < COLUMN_COUNT;
         var _loc13_:* = param2 + 3 < COLUMN_COUNT;
         var _loc3_:int = _map[param1][param2].type;
         if(_loc10_)
         {
            if(_map[param1 + 1][param2].type == _loc3_)
            {
               if(_loc15_)
               {
                  if(_map[param1 + 3][param2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc14_ && _loc11_)
               {
                  if(_map[param1 + 2][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc14_ && _loc6_)
               {
                  if(_map[param1 + 2][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc9_)
               {
                  if(_map[param1 - 2][param2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc6_)
               {
                  if(_map[param1 - 1][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc11_)
               {
                  if(_map[param1 - 1][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
            }
            if(_loc6_ && _loc11_)
            {
               if(_map[param1 + 1][param2 - 1].type == _loc3_ && _map[param1 + 1][param2 + 1].type == _loc3_)
               {
                  return false;
               }
            }
         }
         if(_loc7_)
         {
            if(_map[param1 - 1][param2].type == _loc3_)
            {
               if(_loc8_)
               {
                  if(_map[param1 - 3][param2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc9_ && _loc11_)
               {
                  if(_map[param1 - 2][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc9_ && _loc6_)
               {
                  if(_map[param1 - 2][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc14_)
               {
                  if(_map[param1 + 2][param2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc6_)
               {
                  if(_map[param1 + 1][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc11_)
               {
                  if(_map[param1 + 1][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
            }
            if(_loc6_ && _loc11_)
            {
               if(_map[param1 - 1][param2 - 1].type == _loc3_ && _map[param1 - 1][param2 + 1].type == _loc3_)
               {
                  return false;
               }
            }
         }
         if(_loc11_)
         {
            if(_map[param1][param2 + 1].type == _loc3_)
            {
               if(_loc13_)
               {
                  if(_map[param1][param2 + 3].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc12_)
               {
                  if(_map[param1 - 1][param2 + 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc12_)
               {
                  if(_map[param1 + 1][param2 + 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc5_)
               {
                  if(_map[param1][param2 - 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc6_)
               {
                  if(_map[param1 + 1][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc6_)
               {
                  if(_map[param1 - 1][param2 - 1].type == _loc3_)
                  {
                     return false;
                  }
               }
            }
            if(_loc7_ && _loc10_)
            {
               if(_map[param1 - 1][param2 + 1].type == _loc3_ && _map[param1 + 1][param2 + 1].type == _loc3_)
               {
                  return false;
               }
            }
         }
         if(_loc6_)
         {
            if(_map[param1][param2 - 1].type == _loc3_)
            {
               if(_loc4_)
               {
                  if(_map[param1][param2 - 3].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc5_)
               {
                  if(_map[param1 - 1][param2 - 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc5_)
               {
                  if(_map[param1 + 1][param2 - 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc12_)
               {
                  if(_map[param1][param2 + 2].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc10_ && _loc11_)
               {
                  if(_map[param1 + 1][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
               if(_loc7_ && _loc11_)
               {
                  if(_map[param1 - 1][param2 + 1].type == _loc3_)
                  {
                     return false;
                  }
               }
            }
            if(_loc7_ && _loc10_)
            {
               if(_map[param1 - 1][param2 - 1].type == _loc3_ && _map[param1 + 1][param2 - 1].type == _loc3_)
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}
