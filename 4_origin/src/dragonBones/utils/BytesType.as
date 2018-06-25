package dragonBones.utils
{
   import flash.utils.ByteArray;
   
   public class BytesType
   {
      
      public static const SWF:String = "swf";
      
      public static const PNG:String = "png";
      
      public static const JPG:String = "jpg";
      
      public static const ATF:String = "atf";
      
      public static const ZIP:String = "zip";
       
      
      public function BytesType()
      {
         super();
      }
      
      public static function getType(bytes:ByteArray) : String
      {
         var outputType:* = null;
         var b1:uint = bytes[0];
         var b2:uint = bytes[1];
         var b3:uint = bytes[2];
         var b4:uint = bytes[3];
         if((b1 == 70 || b1 == 67 || b1 == 90) && b2 == 87 && b3 == 83)
         {
            outputType = "swf";
         }
         else if(b1 == 137 && b2 == 80 && b3 == 78 && b4 == 71)
         {
            outputType = "png";
         }
         else if(b1 == 255)
         {
            outputType = "jpg";
         }
         else if(b1 == 65 && b2 == 84 && b3 == 70)
         {
            outputType = "atf";
         }
         else if(b1 == 80 && b2 == 75)
         {
            outputType = "zip";
         }
         return outputType;
      }
   }
}
