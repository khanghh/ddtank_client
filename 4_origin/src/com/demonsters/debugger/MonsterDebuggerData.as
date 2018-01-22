package com.demonsters.debugger
{
   import flash.utils.ByteArray;
   
   public class MonsterDebuggerData
   {
       
      
      private var _id:String;
      
      private var _data:Object;
      
      public function MonsterDebuggerData(param1:String, param2:Object)
      {
         super();
         _id = param1;
         _data = param2;
      }
      
      public static function read(param1:ByteArray) : MonsterDebuggerData
      {
         var _loc2_:MonsterDebuggerData = new MonsterDebuggerData(null,null);
         _loc2_.bytes = param1;
         return _loc2_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.writeObject(_id);
         _loc3_.writeObject(_data);
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUnsignedInt(_loc2_.length);
         _loc1_.writeBytes(_loc2_);
         _loc1_.writeUnsignedInt(_loc3_.length);
         _loc1_.writeBytes(_loc3_);
         _loc1_.position = 0;
         _loc2_ = null;
         _loc3_ = null;
         return _loc1_;
      }
      
      public function set bytes(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:ByteArray = new ByteArray();
         try
         {
            param1.readBytes(_loc2_,0,param1.readUnsignedInt());
            param1.readBytes(_loc3_,0,param1.readUnsignedInt());
            _id = _loc2_.readObject() as String;
            _data = _loc3_.readObject() as Object;
         }
         catch(e:Error)
         {
            _id = null;
            _data = null;
         }
         _loc2_ = null;
         _loc3_ = null;
      }
   }
}
