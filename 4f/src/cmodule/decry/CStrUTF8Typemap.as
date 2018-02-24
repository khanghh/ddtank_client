package cmodule.decry
{
   import flash.utils.ByteArray;
   
   class CStrUTF8Typemap extends CAllocedValueTypemap
   {
       
      
      function CStrUTF8Typemap(param1:ICAllocator = null){super(null);}
      
      protected function ByteArrayForString(param1:String) : ByteArray{return null;}
      
      override public function readValue(param1:int) : *{return null;}
      
      override public function getValueSize(param1:*) : int{return 0;}
      
      override public function get ptrLevel() : int{return 0;}
      
      override public function writeValue(param1:int, param2:*) : void{}
   }
}
