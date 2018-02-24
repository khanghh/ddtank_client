package cmodule.decry
{
   import flash.utils.ByteArray;
   
   class CDoubleTypemap extends CTypemap
   {
       
      
      private var scratch:ByteArray;
      
      function CDoubleTypemap(){super();}
      
      override public function fromReturnRegs(param1:Object) : *{return null;}
      
      override public function toReturnRegs(param1:Object, param2:*, param3:int = 0) : void{}
      
      override public function createC(param1:*, param2:int = 0) : Array{return null;}
      
      override public function fromC(param1:Array) : *{return null;}
      
      override public function get typeSize() : int{return 0;}
   }
}
