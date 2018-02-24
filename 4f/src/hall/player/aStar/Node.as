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
      
      public function Node(param1:int, param2:int){super();}
      
      public function equal(param1:Node) : Boolean{return false;}
      
      public function equalXY(param1:int, param2:int) : Boolean{return false;}
   }
}
