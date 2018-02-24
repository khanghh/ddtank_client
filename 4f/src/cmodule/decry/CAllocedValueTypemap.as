package cmodule.decry
{
   class CAllocedValueTypemap extends CTypemap
   {
       
      
      private var allocator:ICAllocator;
      
      function CAllocedValueTypemap(param1:ICAllocator){super();}
      
      override public function fromC(param1:Array) : *{return null;}
      
      protected function alloc(param1:*) : int{return 0;}
      
      override public function createC(param1:*, param2:int = 0) : Array{return null;}
      
      override public function destroyC(param1:Array) : void{}
      
      protected function free(param1:int) : void{}
   }
}
