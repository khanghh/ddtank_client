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
      
      public static function getType(param1:ByteArray) : String
      {
         var _loc5_:* = null;
         var _loc2_:uint = param1[0];
         var _loc4_:uint = param1[1];
         var _loc3_:uint = param1[2];
         var _loc6_:uint = param1[3];
         if((_loc2_ == 70 || _loc2_ == 67 || _loc2_ == 90) && _loc4_ == 87 && _loc3_ == 83)
         {
            _loc5_ = "swf";
         }
         else if(_loc2_ == 137 && _loc4_ == 80 && _loc3_ == 78 && _loc6_ == 71)
         {
            _loc5_ = "png";
         }
         else if(_loc2_ == 255)
         {
            _loc5_ = "jpg";
         }
         else if(_loc2_ == 65 && _loc4_ == 84 && _loc3_ == 70)
         {
            _loc5_ = "atf";
         }
         else if(_loc2_ == 80 && _loc4_ == 75)
         {
            _loc5_ = "zip";
         }
         return _loc5_;
      }
   }
}
