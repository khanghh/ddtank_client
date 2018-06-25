package cmodule.decry
{
   import flash.utils.ByteArray;
   
   class CStrUTF8Buffer extends CBuffer
   {
       
      
      private var nullTerm:Boolean;
      
      function CStrUTF8Buffer(param1:int, param2:Boolean = true, param3:ICAllocator = null){super(null,null);}
      
      override protected function computeValue() : *{return null;}
      
      override protected function setValue(param1:*) : void{}
   }
}
