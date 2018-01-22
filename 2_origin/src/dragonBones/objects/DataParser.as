package dragonBones.objects
{
   public class DataParser
   {
       
      
      public function DataParser()
      {
         super();
      }
      
      public static function parseData(param1:Object) : DragonBonesData
      {
         if(param1 is XML)
         {
            return XMLDataParser.parseDragonBonesData(param1 as XML);
         }
         return ObjectDataParser.parseDragonBonesData(param1);
      }
      
      public static function parseTextureAtlasData(param1:Object, param2:Number = 1) : Object
      {
         if(param1 is XML)
         {
            return XMLDataParser.parseTextureAtlasData(param1 as XML,param2);
         }
         return ObjectDataParser.parseTextureAtlasData(param1,param2);
      }
   }
}
