package hall.player.aStar
{
   public class Binary
   {
       
      
      private var _data:Array;
      
      private var _compareValue:String;
      
      public function Binary(param1:String = "")
      {
         super();
         _data = [];
         _compareValue = param1;
      }
      
      public function push(param1:Object) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _data.push(param1);
         var _loc5_:int = _data.length;
         if(_loc5_ > 1)
         {
            _loc2_ = _loc5_;
            _loc3_ = _loc2_ / 2 - 1;
            while(compareTwoNodes(param1,_data[_loc3_]))
            {
               _loc4_ = _data[_loc3_];
               _data[_loc3_] = param1;
               _data[_loc2_ - 1] = _loc4_;
               _loc2_ = int(_loc2_ / 2);
               _loc3_ = _loc2_ / 2 - 1;
            }
         }
      }
      
      public function shift() : Object
      {
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc7_:int = 0;
         var _loc6_:* = 0;
         var _loc3_:* = null;
         var _loc1_:Object = _data.shift();
         var _loc5_:int = _data.length;
         if(_loc5_ > 1)
         {
            _loc4_ = _data.pop();
            _data.unshift(_loc4_);
            _loc2_ = 0;
            _loc7_ = (_loc2_ + 1) * 2 - 1;
            while(_loc7_ < _loc5_)
            {
               if(_loc7_ + 1 == _loc5_)
               {
                  _loc6_ = _loc7_;
               }
               else
               {
                  _loc6_ = int(!!compareTwoNodes(_data[_loc7_],_data[_loc7_ + 1])?_loc7_:_loc7_ + 1);
               }
               if(compareTwoNodes(_data[_loc6_],_loc4_))
               {
                  _loc3_ = _data[_loc6_];
                  _data[_loc6_] = _loc4_;
                  _data[_loc2_] = _loc3_;
                  _loc2_ = _loc6_;
                  _loc7_ = (_loc2_ + 1) * 2 - 1;
                  continue;
               }
               break;
            }
         }
         return _loc1_;
      }
      
      public function updateNode(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = _data.indexOf(param1) + 1;
         if(_loc2_ == 0)
         {
            throw new Error("操你妈！更新一个二叉堆中不存在的节点作甚！？");
         }
         _loc3_ = _loc2_ / 2 - 1;
         while(compareTwoNodes(param1,_data[_loc3_]))
         {
            _loc4_ = _data[_loc3_];
            _data[_loc3_] = param1;
            _data[_loc2_ - 1] = _loc4_;
            _loc2_ = _loc2_ / 2;
            _loc3_ = _loc2_ / 2 - 1;
         }
      }
      
      public function indexOf(param1:Object) : int
      {
         return _data.indexOf(param1);
      }
      
      public function get length() : uint
      {
         return _data.length;
      }
      
      private function compareTwoNodes(param1:Object, param2:Object) : Boolean
      {
         if(_compareValue)
         {
            return param1[_compareValue] < param2[_compareValue];
         }
         return param1 < param2;
      }
      
      public function toString() : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:String = "";
         if(_compareValue)
         {
            _loc2_ = _data.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = _loc1_ + _data[_loc3_][_compareValue];
               if(_loc3_ < _loc2_ - 1)
               {
                  _loc1_ = _loc1_ + ",";
               }
               _loc3_++;
            }
         }
         else
         {
            _loc1_ = _data.toString();
         }
         return _loc1_;
      }
   }
}
