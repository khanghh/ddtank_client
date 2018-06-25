package hall.player.aStar
{
   public class Binary
   {
       
      
      private var _data:Array;
      
      private var _compareValue:String;
      
      public function Binary(compareValue:String = "")
      {
         super();
         _data = [];
         _compareValue = compareValue;
      }
      
      public function push(node:Object) : void
      {
         var index:* = 0;
         var parentIndex:int = 0;
         var temp:* = null;
         _data.push(node);
         var len:int = _data.length;
         if(len > 1)
         {
            index = len;
            parentIndex = index / 2 - 1;
            while(compareTwoNodes(node,_data[parentIndex]))
            {
               temp = _data[parentIndex];
               _data[parentIndex] = node;
               _data[index - 1] = temp;
               index = int(index / 2);
               parentIndex = index / 2 - 1;
            }
         }
      }
      
      public function shift() : Object
      {
         var lastNode:* = null;
         var index:* = 0;
         var childIndex:int = 0;
         var comparedIndex:* = 0;
         var temp:* = null;
         var result:Object = _data.shift();
         var len:int = _data.length;
         if(len > 1)
         {
            lastNode = _data.pop();
            _data.unshift(lastNode);
            index = 0;
            childIndex = (index + 1) * 2 - 1;
            while(childIndex < len)
            {
               if(childIndex + 1 == len)
               {
                  comparedIndex = childIndex;
               }
               else
               {
                  comparedIndex = int(!!compareTwoNodes(_data[childIndex],_data[childIndex + 1])?childIndex:childIndex + 1);
               }
               if(compareTwoNodes(_data[comparedIndex],lastNode))
               {
                  temp = _data[comparedIndex];
                  _data[comparedIndex] = lastNode;
                  _data[index] = temp;
                  index = comparedIndex;
                  childIndex = (index + 1) * 2 - 1;
                  continue;
               }
               break;
            }
         }
         return result;
      }
      
      public function updateNode(node:Object) : void
      {
         var parentIndex:int = 0;
         var temp:* = null;
         var index:int = _data.indexOf(node) + 1;
         if(index == 0)
         {
            throw new Error("操你妈！更新一个二叉堆中不存在的节点作甚！？");
         }
         parentIndex = index / 2 - 1;
         while(compareTwoNodes(node,_data[parentIndex]))
         {
            temp = _data[parentIndex];
            _data[parentIndex] = node;
            _data[index - 1] = temp;
            index = index / 2;
            parentIndex = index / 2 - 1;
         }
      }
      
      public function indexOf(node:Object) : int
      {
         return _data.indexOf(node);
      }
      
      public function get length() : uint
      {
         return _data.length;
      }
      
      private function compareTwoNodes(node1:Object, node2:Object) : Boolean
      {
         if(_compareValue)
         {
            return node1[_compareValue] < node2[_compareValue];
         }
         return node1 < node2;
      }
      
      public function toString() : String
      {
         var len:int = 0;
         var i:int = 0;
         var result:String = "";
         if(_compareValue)
         {
            len = _data.length;
            for(i = 0; i < len; )
            {
               result = result + _data[i][_compareValue];
               if(i < len - 1)
               {
                  result = result + ",";
               }
               i++;
            }
         }
         else
         {
            result = _data.toString();
         }
         return result;
      }
   }
}
