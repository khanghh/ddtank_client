package littleGame.data
{
   public class BinaryHeap
   {
       
      
      public var a:Array;
      
      private var _justMinFunc:Function;
      
      public function BinaryHeap(param1:Function)
      {
         a = [];
         super();
         a.push(-1);
         _justMinFunc = param1;
      }
      
      public function ins(param1:Node) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = int(a.length);
         a[_loc2_] = param1;
         var _loc4_:* = _loc2_ >> 1;
         while(_loc2_ > 1 && _justMinFunc(a[_loc2_],a[_loc4_]))
         {
            _loc3_ = a[_loc2_];
            a[_loc2_] = a[_loc4_];
            a[_loc4_] = _loc3_;
            _loc2_ = _loc4_;
            _loc4_ = _loc2_ >> 1;
         }
      }
      
      public function pop() : Node
      {
         var _loc2_:* = 0;
         var _loc4_:* = null;
         var _loc1_:Object = a[1];
         a[1] = a[a.length - 1];
         a.pop();
         var _loc3_:* = 1;
         var _loc5_:int = a.length;
         var _loc6_:* = _loc3_ << 1;
         var _loc7_:int = _loc6_ + 1;
         while(_loc6_ < _loc5_)
         {
            if(_loc7_ < _loc5_)
            {
               _loc2_ = int(!!_justMinFunc(a[_loc7_],a[_loc6_])?_loc7_:int(_loc6_));
            }
            else
            {
               _loc2_ = _loc6_;
            }
            if(_justMinFunc(a[_loc2_],a[_loc3_]))
            {
               _loc4_ = a[_loc3_];
               a[_loc3_] = a[_loc2_];
               a[_loc2_] = _loc4_;
               _loc3_ = _loc2_;
               _loc6_ = _loc3_ << 1;
               _loc7_ = _loc6_ + 1;
               continue;
            }
            break;
         }
         return _loc1_ as Node;
      }
   }
}
