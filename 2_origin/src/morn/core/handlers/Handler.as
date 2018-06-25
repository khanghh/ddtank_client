package morn.core.handlers
{
   public class Handler
   {
       
      
      public var method:Function;
      
      public var args:Array;
      
      public function Handler(method:Function = null, args:Array = null)
      {
         super();
         this.method = method;
         this.args = args;
      }
      
      public function execute() : void
      {
         if(method != null)
         {
            method.apply(null,args);
         }
      }
      
      public function executeWith(data:Array) : void
      {
         if(data == null)
         {
            return execute();
         }
         if(method != null)
         {
            method.apply(null,!!args?args.concat(data):data);
         }
      }
   }
}
