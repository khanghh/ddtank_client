package morn.core.managers
{
   public class LangManager
   {
       
      
      private var _data:Object;
      
      public function LangManager()
      {
         _data = {};
         super();
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(value:Object) : void
      {
         _data = value;
      }
      
      public function add(key:String, value:Object) : void
      {
         _data[key] = value;
      }
      
      public function getLang(code:String, ... args) : String
      {
         var i:int = 0;
         var n:int = 0;
         var str:String = _data[code] || code;
         if(args.length > 0)
         {
            for(i = 0,n = args.length; i < n; )
            {
               str = str.replace("{" + i + "}",args[i]);
               i++;
            }
         }
         return str;
      }
   }
}
