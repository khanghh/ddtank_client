package com.hurlant.util
{
   import flash.utils.ByteArray;
   
   public class Hex
   {
       
      
      public function Hex()
      {
         super();
      }
      
      public static function dump(param1:ByteArray) : String
      {
         var _loc5_:int = 0;
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(_loc4_ % 16 == 0)
            {
               _loc2_ = _loc2_ + (("00000000" + _loc4_.toString(16)).substr(-8,8) + " ");
            }
            if(_loc4_ % 8 == 0)
            {
               _loc2_ = _loc2_ + " ";
            }
            _loc5_ = param1[_loc4_];
            _loc2_ = _loc2_ + (("0" + _loc5_.toString(16)).substr(-2,2) + " ");
            _loc3_ = _loc3_ + (_loc5_ < 32 || _loc5_ > 126?".":String.fromCharCode(_loc5_));
            if((_loc4_ + 1) % 16 == 0 || _loc4_ == param1.length - 1)
            {
               _loc2_ = _loc2_ + (" |" + _loc3_ + "|\n");
               _loc3_ = "";
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function fromString(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         return fromArray(_loc3_,param2);
      }
      
      public static function toString(param1:String) : String
      {
         var _loc2_:ByteArray = toArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function undump(param1:String) : ByteArray
      {
         var _loc4_:Array = null;
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:Array = param1.split(/(\n|\r)+/);
         while(_loc3_.length > 0 && _loc3_[0].length > 0)
         {
            _loc4_ = _loc3_.shift().substr(10).split("  |")[0].split(/\s+/);
            while(_loc4_.length > 0 && _loc4_[0].length > 0)
            {
               _loc2_.writeByte(parseInt(_loc4_.shift(),16));
            }
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function toArray(param1:String) : ByteArray
      {
         param1 = param1.replace(/\s|:/gm,"");
         var _loc2_:ByteArray = new ByteArray();
         if(param1.length & 1 == 1)
         {
            param1 = "0" + param1;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_ / 2] = parseInt(param1.substr(_loc3_,2),16);
            _loc3_ = _loc3_ + 2;
         }
         return _loc2_;
      }
      
      public static function fromArray(param1:ByteArray, param2:Boolean = false) : String
      {
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = _loc3_ + ("0" + param1[_loc4_].toString(16)).substr(-2,2);
            if(param2)
            {
               if(_loc4_ < param1.length - 1)
               {
                  _loc3_ = _loc3_ + ":";
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}
