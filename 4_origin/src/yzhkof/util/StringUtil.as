package yzhkof.util
{
   public class StringUtil
   {
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function addString(param1:String, param2:String, param3:uint) : String
      {
         return replaceString(param1,param2,param3,param3);
      }
      
      public static function replaceString(param1:String, param2:String, param3:uint, param4:uint) : String
      {
         return param1.substring(0,param3) + param2 + param1.substring(param4);
      }
   }
}
