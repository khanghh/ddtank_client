package morn.core.handlers
{
   public class Handler
   {
       
      
      public var method:Function;
      
      public var args:Array;
      
      public function Handler(param1:Function = null, param2:Array = null)
      {
         super();
         this.method = param1;
         this.args = param2;
      }
      
      public function execute() : void
      {
         if(this.method != null)
         {
            this.method.apply(null,this.args);
         }
      }
      
      public function executeWith(param1:Array) : void
      {
         if(param1 == null)
         {
            return this.execute();
         }
         if(this.method != null)
         {
            this.method.apply(null,!!this.args?this.args.concat(param1):param1);
         }
      }
   }
}
