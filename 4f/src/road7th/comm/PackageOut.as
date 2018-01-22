package road7th.comm
{
   import flash.utils.ByteArray;
   
   public class PackageOut extends ByteArray
   {
      
      public static const HEADER:int = 29099;
       
      
      private var _checksum:int;
      
      private var _code:int;
      
      public function PackageOut(param1:int, param2:int = 0, param3:int = 0, param4:int = 0){super();}
      
      public function get code() : int{return 0;}
      
      public function pack() : void{}
      
      public function calculateCheckSum() : int{return 0;}
      
      public function writeDate(param1:Date) : void{}
   }
}
