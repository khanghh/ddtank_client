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
      
      public function PackageIn()
      {
         super();
      }
      
      public function load(param1:ByteArray, param2:int) : void
      {
         writeByte(param1.readByte());
         readHeader();
      }
      
      public function loadE(param1:ByteArray, param2:int, param3:ByteArray) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ByteArray = new ByteArray();
         var _loc4_:ByteArray = new ByteArray();
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc5_.writeByte(param1.readByte());
            _loc4_.writeByte(_loc5_[_loc6_]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            if(_loc6_ > 0)
            {
               param3[_loc6_ % 8] = param3[_loc6_ % 8] + _loc5_[_loc6_ - 1] ^ _loc6_;
               _loc4_[_loc6_] = _loc5_[_loc6_] - _loc5_[_loc6_ - 1] ^ param3[_loc6_ % 8];
            }
            else
            {
               _loc4_[_loc6_] = _loc5_[_loc6_] ^ param3[0];
            }
            _loc6_++;
         }
         _loc4_.position = 0;
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            writeByte(_loc4_.readByte());
            _loc6_++;
         }
         position = 0;
         readHeader();
      }
      
      public function loadFightByteInfo(param1:int, param2:int, param3:int, param4:ByteArray, param5:int) : void
      {
         _extend1 = param1;
         _extend2 = param2;
         _len = param3;
         writeBytes(param4);
         position = 20;
      }
      
      public function readHeader() : void
      {
         readShort();
         _len = readShort();
         _checksum = readShort();
         _code = readShort();
         _clientId = readInt();
         _extend1 = readInt();
         _extend2 = readInt();
      }
      
      public function get checkSum() : int
      {
         return _checksum;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get clientId() : int
      {
         return _clientId;
      }
      
      public function get extend1() : int
      {
         return _extend1;
      }
      
      public function get extend2() : int
      {
         return _extend2;
      }
      
      public function get Len() : int
      {
         return _len;
      }
      
      public function calculateCheckSum() : int
      {
         var _loc1_:int = 119;
         var _loc2_:int = 6;
         while(_loc2_ < length)
         {
            _loc2_++;
            _loc1_ = _loc1_ + this[_loc2_];
         }
         return _loc1_ & 32639;
      }
      
      public function readXml() : XML
      {
         return new XML(readUTF());
      }
      
      public function readDateString() : String
      {
         return readShort() + "-" + readByte() + "-" + readByte() + " " + readByte() + ":" + readByte() + ":" + readByte();
      }
      
      public function readDate() : Date
      {
         var _loc5_:int = readShort();
         var _loc4_:int = readByte() - 1;
         var _loc6_:int = readByte();
         var _loc3_:int = readByte();
         var _loc1_:int = readByte();
         var _loc2_:int = readByte();
         var _loc7_:Date = new Date(_loc5_,_loc4_,_loc6_,_loc3_,_loc1_,_loc2_);
         return _loc7_;
      }
      
      public function readByteArray() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         readBytes(_loc1_,0,_len - position);
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function deCompress() : void
      {
         position = 20;
         var _loc1_:ByteArray = new ByteArray();
         readBytes(_loc1_,0,_len - 20);
         _loc1_.uncompress();
         position = 20;
         writeBytes(_loc1_,0,_loc1_.length);
         _len = 20 + _loc1_.length;
         position = 20;
      }
      
      public function readLong() : Number
      {
         var _loc3_:Number = new Number();
         var _loc2_:Number = new Number(readInt());
         var _loc1_:Number = new Number(readUnsignedInt());
         var _loc4_:int = 1;
         if(_loc2_ < 0)
         {
            _loc4_ = -1;
         }
         _loc3_ = _loc4_ * (Math.abs(_loc2_ * Math.pow(2,32)) + _loc1_);
         return _loc3_;
      }
   }
}
