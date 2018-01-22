package cmodule.decry
{
   class CTypemap
   {
      
      public static var AS3ValType:CAS3ValTypemap = new CAS3ValTypemap();
      
      public static var DoubleType:CDoubleTypemap = new CDoubleTypemap();
      
      public static var VoidType:CVoidTypemap = new CVoidTypemap();
      
      public static var DoubleRefType:CRefTypemap = new CRefTypemap(CTypemap.DoubleType);
      
      public static var StrRefType:CRefTypemap = new CRefTypemap(CTypemap.StrType);
      
      public static var IntRefType:CRefTypemap = new CRefTypemap(CTypemap.IntType);
      
      public static var SizedStrType:CSizedStrUTF8Typemap = new CSizedStrUTF8Typemap();
      
      public static var IntType:CIntTypemap = new CIntTypemap();
      
      public static var StrType:CStrUTF8Typemap = new CStrUTF8Typemap();
      
      public static var PtrType:CPtrTypemap = new CPtrTypemap();
      
      public static var BufferType:CBufferTypemap = new CBufferTypemap();
       
      
      function CTypemap(){super();}
      
      public static function getTypeByName(param1:String) : CTypemap{return null;}
      
      public static function getTypesByNames(param1:String) : Array{return null;}
      
      public static function getTypesByNameArray(param1:Array) : Array{return null;}
      
      public function fromC(param1:Array) : *{return null;}
      
      public function writeValue(param1:int, param2:*) : void{}
      
      public function readValue(param1:int) : *{return null;}
      
      public function get ptrLevel() : int{return 0;}
      
      public function createC(param1:*, param2:int = 0) : Array{return null;}
      
      public function fromReturnRegs(param1:Object) : *{return null;}
      
      public function destroyC(param1:Array) : void{}
      
      public function toReturnRegs(param1:Object, param2:*, param3:int = 0) : void{}
      
      public function get typeSize() : int{return 0;}
      
      public function getValueSize(param1:*) : int{return 0;}
   }
}
