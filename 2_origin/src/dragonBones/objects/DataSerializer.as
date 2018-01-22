package dragonBones.objects
{
   import dragonBones.utils.BytesType;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="flash.events.Event")]
   public class DataSerializer extends EventDispatcher
   {
       
      
      public function DataSerializer()
      {
         super();
      }
      
      public static function compressDataToByteArray(param1:Object, param2:Object, param3:ByteArray) : ByteArray
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param3);
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeObject(param2);
         _loc5_.compress();
         _loc4_.position = _loc4_.length;
         _loc4_.writeBytes(_loc5_);
         _loc4_.writeInt(_loc5_.length);
         _loc5_.length = 0;
         _loc5_.writeObject(param1);
         _loc5_.compress();
         _loc4_.position = _loc4_.length;
         _loc4_.writeBytes(_loc5_);
         _loc4_.writeInt(_loc5_.length);
         return _loc4_;
      }
      
      public static function decompressData(param1:ByteArray) : DecompressedData
      {
         var _loc5_:* = null;
         var _loc10_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         var _loc8_:* = null;
         var _loc6_:String = BytesType.getType(param1);
         var _loc13_:* = _loc6_;
         if("swf" !== _loc13_)
         {
            if("png" !== _loc13_)
            {
               if("jpg" !== _loc13_)
               {
                  if("atf" !== _loc13_)
                  {
                     throw new Error("Nonsupport data!");
                  }
               }
               addr29:
               try
               {
                  _loc3_ = new ByteArray();
                  _loc9_ = new ByteArray();
                  _loc9_.writeBytes(param1);
                  _loc9_.position = _loc9_.length - 4;
                  _loc4_ = _loc9_.readInt();
                  _loc2_ = uint(_loc9_.length - 4 - _loc4_);
                  _loc3_.writeBytes(_loc9_,_loc2_,_loc4_);
                  _loc3_.uncompress();
                  _loc5_ = _loc3_.readObject();
                  _loc3_.length = 0;
                  _loc9_.length = _loc2_;
                  _loc9_.position = _loc9_.length - 4;
                  _loc4_ = _loc9_.readInt();
                  _loc2_ = uint(_loc9_.length - 4 - _loc4_);
                  _loc3_.writeBytes(_loc9_,_loc2_,_loc4_);
                  _loc3_.uncompress();
                  _loc10_ = _loc3_.readObject();
                  _loc9_.length = _loc2_;
               }
               catch(e:Error)
               {
                  throw new Error("Data error!");
               }
               _loc8_ = new DecompressedData();
               _loc8_.textureBytesDataType = _loc6_;
               _loc8_.dragonBonesData = _loc5_;
               _loc8_.textureAtlasData = _loc10_;
               _loc8_.textureAtlasBytes = _loc9_;
               return _loc8_;
            }
            addr28:
            §§goto(addr29);
         }
         §§goto(addr28);
      }
   }
}
