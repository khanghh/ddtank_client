package hall.player.aStar
{
   public class Node
   {
       
      
      public var x:int;
      
      public var y:int;
      
      public var f:Number;
      
      public var g:Number;
      
      public var h:Number;
      
      public var walkable:Boolean = true;
      
      public var parent:Node;
      
      public var costMultiplier:Number = 1.0;
      
      public function Node(param1:int, param2:int)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function equal(param1:Node) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return equalXY(param1.x,param1.y);
      }
      
      public function equalXY(param1:int, param2:int) : Boolean
      {
         return this.x == param1 && this.y == param2;
      }
   }
}
