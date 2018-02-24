package cmodule.decry
{
   import flash.utils.ByteArray;
   
   class ByteArrayIO extends IO
   {
       
      
      public var byteArray:ByteArray;
      
      function ByteArrayIO(){super();}
      
      override public function set size(param1:int) : void{}
      
      override public function read(param1:int, param2:int) : int{return 0;}
      
      override public function get size() : int{return 0;}
      
      override public function get position() : int{return 0;}
      
      override public function set position(param1:int) : void{}
      
      override public function write(param1:int, param2:int) : int{return 0;}
   }
}
