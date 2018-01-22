package com.crypto
{
   import flash.utils.ByteArray;
   
   public class NewCrypto
   {
      
      private static const _FLAG:String = "^_^";
      
      private static const _SKIP_INDEX:int = 16;
       
      
      public function NewCrypto()
      {
         super();
      }
      
      public static function decry(param1:ByteArray) : ByteArray
      {
         if(!isEncryed(param1))
         {
            return param1;
         }
         var _loc5_:int = param1.position;
         param1.position = 0;
         param1.readUTF();
         var _loc3_:ByteArray = new ByteArray();
         param1.readBytes(_loc3_,0,16);
         var _loc4_:int = param1.readByte();
         _loc4_ = ~_loc4_;
         var _loc6_:ByteArray = new ByteArray();
         param1.readBytes(_loc6_,0,_loc6_.bytesAvailable);
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(_loc3_);
         _loc2_.writeByte(_loc4_);
         _loc2_.writeBytes(_loc6_);
         param1.position = _loc5_;
         _loc3_.clear();
         _loc6_.clear();
         return _loc2_;
      }
      
      public static function isEncryed(param1:ByteArray) : Boolean
      {
         var _loc2_:* = null;
         var _loc4_:int = param1.position;
         var _loc3_:Boolean = false;
         param1.position = 0;
         try
         {
            _loc2_ = param1.readUTF();
         }
         catch(e:Error)
         {
         }
         if(_loc2_ == "^_^")
         {
            _loc3_ = true;
         }
         param1.position = _loc4_;
         return _loc3_;
      }
   }
}
