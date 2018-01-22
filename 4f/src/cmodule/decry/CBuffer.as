package cmodule.decry
{
   class CBuffer
   {
      
      private static var ptr2Buffer:Object = {};
       
      
      private var sizeVal:int;
      
      private var valCache;
      
      private var allocator:ICAllocator;
      
      private var ptrVal:int;
      
      function CBuffer(param1:int, param2:ICAllocator = null){super();}
      
      public static function free(param1:int) : void{}
      
      public function get size() : int{return 0;}
      
      public function set value(param1:*) : void{}
      
      public function free() : void{}
      
      public function get ptr() : int{return 0;}
      
      protected function setValue(param1:*) : void{}
      
      public function get value() : *{return null;}
      
      protected function computeValue() : *{return null;}
      
      private function alloc() : void{}
      
      public function reset() : void{}
   }
}
