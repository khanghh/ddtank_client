package com.pickgliss.action
{
   public class FunctionAction extends BaseAction
   {
       
      
      private var _fun:Function;
      
      public function FunctionAction(fun:Function)
      {
         super();
         _fun = fun;
      }
      
      override public function act() : void
      {
      }
   }
}
