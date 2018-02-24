package cmodule.decry
{
   import flash.utils.Dictionary;
   
   class ValueTracker
   {
       
      
      private var snum:int = 1;
      
      private var val2rcv:Dictionary;
      
      private var id2key:Object;
      
      function ValueTracker(){super();}
      
      public function acquireId(param1:int) : int{return 0;}
      
      public function get(param1:int) : *{return null;}
      
      public function release(param1:int) : *{return null;}
      
      public function acquire(param1:*) : int{return 0;}
   }
}
