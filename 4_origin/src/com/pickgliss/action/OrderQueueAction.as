package com.pickgliss.action
{
   public class OrderQueueAction extends BaseAction
   {
       
      
      protected var _actList:Array;
      
      protected var _count:int;
      
      public function OrderQueueAction(actList:Array, timeOut:uint = 0)
      {
         _actList = actList;
         super(timeOut);
      }
      
      override public function act() : void
      {
         cancel();
         startAct();
         super.act();
      }
      
      private function startAct() : void
      {
         _count = 0;
         if(_actList.length > 0)
         {
            actOne();
         }
      }
      
      protected function actOne() : void
      {
         var action:IAction = _actList[_count] as IAction;
         action.setCompleteFun(actOneComplete);
         action.act();
      }
      
      private function actOneComplete(target:IAction) : void
      {
         actNext();
      }
      
      protected function actNext() : void
      {
         _count = Number(_count) + 1;
         if(_count < _actList.length)
         {
            actOne();
         }
         else
         {
            execComplete();
         }
      }
      
      override public function cancel() : void
      {
         var action:* = null;
         if(_acting)
         {
            action = _actList[_count] as IAction;
            if(action)
            {
               action.setCompleteFun(null);
               action.cancel();
            }
         }
         super.cancel();
      }
      
      public function getActions() : Array
      {
         return _actList;
      }
   }
}
