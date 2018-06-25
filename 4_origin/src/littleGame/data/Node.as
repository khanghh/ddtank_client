package littleGame.data
{
   import com.pickgliss.ui.core.Disposeable;
   
   public class Node implements Disposeable
   {
       
      
      public var x:int;
      
      public var y:int;
      
      public var f:Number;
      
      public var g:Number;
      
      public var h:Number;
      
      public var walkable:Boolean;
      
      public var parent:Node;
      
      public var version:int = -1;
      
      public var links:Vector.<Node>;
      
      public function Node(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
      }
      
      public function dispose() : void
      {
         parent = null;
         while(links.length > 0)
         {
            links.shift();
         }
      }
      
      public function toString() : String
      {
         return "[node:(x:" + x + ";\ty:" + y + ";\tf:" + f + ";\twalk:" + walkable + ";)]";
      }
   }
}
