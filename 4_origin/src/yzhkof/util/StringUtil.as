package yzhkof.util
{
   public class StringUtil
   {
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function addString(str:String, strAdd:String, index:uint) : String
      {
         return replaceString(str,strAdd,index,index);
      }
      
      public static function replaceString(str:String, strAdd:String, startIndex:uint, endIndex:uint) : String
      {
         return str.substring(0,startIndex) + strAdd + str.substring(endIndex);
      }
   }
}
