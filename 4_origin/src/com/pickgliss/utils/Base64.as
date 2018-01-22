package com.pickgliss.utils
{
   import flash.utils.ByteArray;
   
   public class Base64
   {
      
      private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      
      public static const version:String = "1.0.0";
       
      
      public function Base64()
      {
         super();
         throw new Error("Base64 class is static container only");
      }
      
      public static function encode(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return encodeByteArray(_loc2_);
      }
      
      public static function encodeByteArray(param1:ByteArray) : String
      {
         var _loc2_:* = null;
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:String = "";
         var _loc6_:Array = new Array(4);
         param1.position = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc2_ = [];
            _loc7_ = uint(0);
            while(_loc7_ < 3 && param1.bytesAvailable > 0)
            {
               _loc2_[_loc7_] = param1.readUnsignedByte();
               _loc7_++;
            }
            _loc6_[0] = (_loc2_[0] & 252) >> 2;
            _loc6_[1] = (_loc2_[0] & 3) << 4 | _loc2_[1] >> 4;
            _loc6_[2] = (_loc2_[1] & 15) << 2 | _loc2_[2] >> 6;
            _loc6_[3] = _loc2_[2] & 63;
            _loc3_ = uint(_loc2_.length);
            while(_loc3_ < 3)
            {
               _loc6_[_loc3_ + 1] = 64;
               _loc3_++;
            }
            _loc5_ = uint(0);
            while(_loc5_ < _loc6_.length)
            {
               _loc4_ = _loc4_ + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(_loc6_[_loc5_]);
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public static function decode(param1:String) : String
      {
         var _loc2_:ByteArray = decodeToByteArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function decodeToByteArray(param1:String) : ByteArray
      {
         var _loc7_:* = 0;
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:ByteArray = new ByteArray();
         var _loc2_:Array = new Array(4);
         var _loc6_:Array = new Array(3);
         _loc7_ = uint(0);
         while(_loc7_ < param1.length)
         {
            _loc3_ = uint(0);
            while(_loc3_ < 4 && _loc7_ + _loc3_ < param1.length)
            {
               _loc2_[_loc3_] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(param1.charAt(_loc7_ + _loc3_));
               _loc3_++;
            }
            _loc6_[0] = (_loc2_[0] << 2) + ((_loc2_[1] & 48) >> 4);
            _loc6_[1] = ((_loc2_[1] & 15) << 4) + ((_loc2_[2] & 60) >> 2);
            _loc6_[2] = ((_loc2_[2] & 3) << 6) + _loc2_[3];
            _loc5_ = uint(0);
            while(_loc5_ < _loc6_.length)
            {
               if(_loc2_[_loc5_ + 1] != 64)
               {
                  _loc4_.writeByte(_loc6_[_loc5_]);
                  _loc5_++;
                  continue;
               }
               break;
            }
            _loc7_ = uint(_loc7_ + 4);
         }
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}
