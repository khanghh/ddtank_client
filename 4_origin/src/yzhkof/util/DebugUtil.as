package yzhkof.util
{
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class DebugUtil
   {
       
      
      public function DebugUtil()
      {
         super();
      }
      
      public static function analyseInstance(obj:Object) : String
      {
         var re_text:String = "*********************************\n";
         if(obj == null)
         {
            re_text = re_text + "null\n";
         }
         else
         {
            re_text = re_text + analyseMenbers(obj);
         }
         re_text = re_text + "**********************************\n";
         return re_text;
      }
      
      private static function analyseMenbers(obj:Object) : String
      {
         var listener_arr:Array = null;
         var length:int = 0;
         var i:int = 0;
         var fun:Object = null;
         var re_text:String = "";
         if(obj is EventDispatcher)
         {
            listener_arr = obj[QNameUtil.getObjectQname(obj,QNameUtil.LISTENERS)];
            length = !!listener_arr?int(listener_arr.length):0;
            re_text = re_text + ("监听器数 ： " + length + "\n");
            for(i = 0; i < length; i++)
            {
               fun = listener_arr[i];
               if(fun is Function)
               {
                  re_text = re_text + ("\t" + i + " ： 监听器this指向[" + fun[QNameUtil.getObjectQname(fun,QNameUtil.SAVEDTHIS)] + "]\n");
               }
               else
               {
                  re_text = re_text + ("\t" + i + " ： 监听器为 " + getQualifiedClassName(fun) + "\n");
               }
            }
         }
         return re_text;
      }
   }
}
