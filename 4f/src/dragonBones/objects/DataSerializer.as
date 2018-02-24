package dragonBones.objects
{
   import dragonBones.utils.BytesType;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="flash.events.Event")]
   public class DataSerializer extends EventDispatcher
   {
       
      
      public function DataSerializer(){super();}
      
      public static function compressDataToByteArray(param1:Object, param2:Object, param3:ByteArray) : ByteArray{return null;}
      
      public static function decompressData(param1:ByteArray) : DecompressedData{return null;}
   }
}
