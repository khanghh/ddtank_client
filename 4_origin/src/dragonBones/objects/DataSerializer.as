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
      
      public static function compressDataToByteArray(dragonBonesData:Object, textureAtlasData:Object, textureAtlasBytes:ByteArray) : ByteArray
      {
         var outputBytes:ByteArray = new ByteArray();
         outputBytes.writeBytes(textureAtlasBytes);
         var dataBytes:ByteArray = new ByteArray();
         dataBytes.writeObject(textureAtlasData);
         dataBytes.compress();
         outputBytes.position = outputBytes.length;
         outputBytes.writeBytes(dataBytes);
         outputBytes.writeInt(dataBytes.length);
         dataBytes.length = 0;
         dataBytes.writeObject(dragonBonesData);
         dataBytes.compress();
         outputBytes.position = outputBytes.length;
         outputBytes.writeBytes(dataBytes);
         outputBytes.writeInt(dataBytes.length);
         return outputBytes;
      }
      
      public static function decompressData(inputByteArray:ByteArray) : DecompressedData
      {
         var dragonBonesData:* = null;
         var textureAtlasData:* = null;
         var textureAtlas:* = null;
         var tempByteArray:* = null;
         var bytesToDecompress:* = null;
         var strSize:int = 0;
         var position:* = 0;
         var outputDecompressedData:* = null;
         var dataType:String = BytesType.getType(inputByteArray);
         var _loc13_:* = dataType;
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
               addr42:
               try
               {
                  tempByteArray = new ByteArray();
                  bytesToDecompress = new ByteArray();
                  bytesToDecompress.writeBytes(inputByteArray);
                  bytesToDecompress.position = bytesToDecompress.length - 4;
                  strSize = bytesToDecompress.readInt();
                  position = uint(bytesToDecompress.length - 4 - strSize);
                  tempByteArray.writeBytes(bytesToDecompress,position,strSize);
                  tempByteArray.uncompress();
                  dragonBonesData = tempByteArray.readObject();
                  tempByteArray.length = 0;
                  bytesToDecompress.length = position;
                  bytesToDecompress.position = bytesToDecompress.length - 4;
                  strSize = bytesToDecompress.readInt();
                  position = uint(bytesToDecompress.length - 4 - strSize);
                  tempByteArray.writeBytes(bytesToDecompress,position,strSize);
                  tempByteArray.uncompress();
                  textureAtlasData = tempByteArray.readObject();
                  bytesToDecompress.length = position;
               }
               catch(e:Error)
               {
                  throw new Error("Data error!");
               }
               outputDecompressedData = new DecompressedData();
               outputDecompressedData.textureBytesDataType = dataType;
               outputDecompressedData.dragonBonesData = dragonBonesData;
               outputDecompressedData.textureAtlasData = textureAtlasData;
               outputDecompressedData.textureAtlasBytes = bytesToDecompress;
               return outputDecompressedData;
            }
            addr41:
            §§goto(addr42);
         }
         §§goto(addr41);
      }
   }
}
