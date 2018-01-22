package road7th.comm
{
   import flash.utils.ByteArray;
   
   public class PackageIn extends ByteArray
   {
      
      public static const HEADER_SIZE:Number = 20;
       
      
      private var _len:int;
      
      private var _checksum:int;
      
      private var _clientId:int;
      
      private var _code:int;
      
      private var _extend1:int;
      
      private var _extend2:int;
      
      public function PackageIn(){super();}
      
      public function load(param1:ByteArray, param2:int) : void{}
      
      public function loadE(param1:ByteArray, param2:int, param3:ByteArray) : void{}
      
      public function loadFightByteInfo(param1:int, param2:int, param3:int, param4:ByteArray, param5:int) : void{}
      
      public function readHeader() : void{}
      
      public function get checkSum() : int{return 0;}
      
      public function get code() : int{return 0;}
      
      public function get clientId() : int{return 0;}
      
      public function get extend1() : int{return 0;}
      
      public function get extend2() : int{return 0;}
      
      public function get Len() : int{return 0;}
      
      public function calculateCheckSum() : int{return 0;}
      
      public function readXml() : XML{return null;}
      
      public function readDateString() : String{return null;}
      
      public function readDate() : Date{return null;}
      
      public function readByteArray() : ByteArray{return null;}
      
      public function deCompress() : void{}
      
      public function readLong() : Number{return 0;}
   }
}
