package dragonBones.objects
{
   public class DataParser
   {
       
      
      public function DataParser()
      {
         super();
      }
      
      public static function parseData(rawData:Object) : DragonBonesData
      {
         if(rawData is XML)
         {
            return XMLDataParser.parseDragonBonesData(rawData as XML);
         }
         return ObjectDataParser.parseDragonBonesData(rawData);
      }
      
      public static function parseTextureAtlasData(textureAtlasData:Object, scale:Number = 1) : Object
      {
         if(textureAtlasData is XML)
         {
            return XMLDataParser.parseTextureAtlasData(textureAtlasData as XML,scale);
         }
         return ObjectDataParser.parseTextureAtlasData(textureAtlasData,scale);
      }
   }
}
