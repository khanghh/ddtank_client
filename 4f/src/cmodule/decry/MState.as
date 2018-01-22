package cmodule.decry
{
   import flash.utils.ByteArray;
   
   public class MState extends MemUser
   {
       
      
      public var esp:int;
      
      public const syms:Object = null;
      
      public const ds:ByteArray = null;
      
      public var eax:int;
      
      public var cf:uint;
      
      public var gworker:Machine;
      
      public var st0:Number;
      
      public var ebp:int;
      
      public var funcs:Vector.<Object>;
      
      public var edx:int;
      
      public var system:CSystem;
      
      public function MState(param1:Machine){super();}
      
      public function copyTo(param1:MState) : void{}
      
      public function pop() : int{return 0;}
      
      public function push(param1:int) : void{}
   }
}
