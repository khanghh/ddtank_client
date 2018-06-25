package com.pickgliss.utils
{
   public function handler(func:Function, ... args) : Function
   {
      func = func;
      args = args;
      var callee:Function = function(... oargs):void
      {
         var allArgs:Array = oargs.concat(args);
         if(func.length > allArgs.length)
         {
            allArgs.push(callee);
         }
         func.apply(script0,allArgs);
      };
      return callee;
   }
}
