package com.pickgliss.action
{
   public class OrderQueueAction extends BaseAction
   {
       
      
      protected var _actList:Array;
      
      protected var _count:int;
      
      public function OrderQueueAction(param1:Array, param2:uint = 0)
      {
         _actList = param1;
         super(param2);
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
         var _loc1_:IAction = _actList[_count] as IAction;
         _loc1_.setCompleteFun(actOneComplete);
         _loc1_.act();
      }
      
      private function actOneComplete(param1:IAction) : void
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
         var _loc1_:* = null;
         if(_acting)
         {
            _loc1_ = _actList[_count] as IAction;
            if(_loc1_)
            {
               _loc1_.setCompleteFun(null);
               _loc1_.cancel();
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
