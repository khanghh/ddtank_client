package ddt.utils{   import flash.utils.ByteArray;      public class BitArray extends ByteArray   {                   public function BitArray() { super(); }
            public function setBit(position:uint, value:Boolean) : Boolean { return false; }
            public function getBit(position:uint) : Boolean { return false; }
            public function loadBinary(str:String) : void { }
            public function traceBinary(position:uint) : String { return null; }
   }}