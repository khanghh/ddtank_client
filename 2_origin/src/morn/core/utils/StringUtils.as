package morn.core.utils
{
   import flash.geom.Rectangle;
   
   public class StringUtils
   {
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function fillArray(arr:Array, str:String, type:Class = null) : Array
      {
         var a:* = null;
         var i:int = 0;
         var n:int = 0;
         var value:* = null;
         var temp:Array = ObjectUtils.clone(arr);
         if(str)
         {
            a = str.split(",");
            for(i = 0,n = Math.min(temp.length,a.length); i < n; )
            {
               value = a[i];
               temp[i] = value == "true"?true:value == "false"?false:value;
               if(type != null)
               {
                  temp[i] = type(value);
               }
               i++;
            }
         }
         return temp;
      }
      
      public static function rectToString(rect:Rectangle) : String
      {
         if(rect)
         {
            return rect.x + "," + rect.y + "," + rect.width + "," + rect.height;
         }
         return null;
      }
   }
}
