package road7th.comm{   import flash.utils.ByteArray;      public class PackageOut extends ByteArray   {            public static const HEADER:int = 29099;                   private var _checksum:int;            private var _code:int;            public function PackageOut(code:int, toId:int = 0, extend1:int = 0, extend2:int = 0) { super(); }
            public function get code() : int { return 0; }
            public function pack() : void { }
            public function calculateCheckSum() : int { return 0; }
            public function writeDate(date:Date) : void { }
   }}