package cmodule.decry
{
   class CHeapAllocator implements ICAllocator
   {
       
      
      private var pmalloc:Function;
      
      private var pfree:Function;
      
      function CHeapAllocator(){super();}
      
      public function free(param1:int) : void{}
      
      public function alloc(param1:int) : int{return 0;}
   }
}
