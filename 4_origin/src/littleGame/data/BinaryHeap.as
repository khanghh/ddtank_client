package littleGame.data
{
   public class BinaryHeap
   {
       
      
      public var a:Array;
      
      private var _justMinFunc:Function;
      
      public function BinaryHeap(justMinFunc:Function)
      {
         a = [];
         super();
         a.push(-1);
         _justMinFunc = justMinFunc;
      }
      
      public function ins(node:Node) : void
      {
         var temp:* = null;
         var p:* = int(a.length);
         a[p] = node;
         var parent:* = p >> 1;
         while(p > 1 && _justMinFunc(a[p],a[parent]))
         {
            temp = a[p];
            a[p] = a[parent];
            a[parent] = temp;
            p = parent;
            parent = p >> 1;
         }
      }
      
      public function pop() : Node
      {
         var minp:* = 0;
         var temp:* = null;
         var min:Object = a[1];
         a[1] = a[a.length - 1];
         a.pop();
         var p:* = 1;
         var l:int = a.length;
         var child1:* = p << 1;
         var child2:int = child1 + 1;
         while(child1 < l)
         {
            if(child2 < l)
            {
               minp = int(!!_justMinFunc(a[child2],a[child1])?child2:int(child1));
            }
            else
            {
               minp = child1;
            }
            if(_justMinFunc(a[minp],a[p]))
            {
               temp = a[p];
               a[p] = a[minp];
               a[minp] = temp;
               p = minp;
               child1 = p << 1;
               child2 = child1 + 1;
               continue;
            }
            break;
         }
         return min as Node;
      }
   }
}
