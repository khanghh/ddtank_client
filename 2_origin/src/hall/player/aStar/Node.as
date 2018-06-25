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
      
      public function Node(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
      }
      
      public function equal(value:Node) : Boolean
      {
         if(value == null)
         {
            return false;
         }
         return equalXY(value.x,value.y);
      }
      
      public function equalXY(mX:int, mY:int) : Boolean
      {
         return this.x == mX && this.y == mY;
      }
   }
}
