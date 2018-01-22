package morn.core.handlers
{
   public class Handler
   {
       
      
      public var method:Function;
      
      public var args:Array;
      
      public function Handler(param1:Function = null, param2:Array = null){super();}
      
      public function execute() : void{}
      
      public function executeWith(param1:Array) : void{}
   }
}
