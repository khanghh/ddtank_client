package ddt.manager
{
   import com.pickgliss.utils.StringUtils;
   import flash.utils.Dictionary;
   
   public class LanguageMgr
   {
      
      private static var _dic:Dictionary;
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function LanguageMgr()
      {
         super();
      }
      
      public static function setup(content:String) : void
      {
         _dic = new Dictionary();
         analyze(content);
      }
      
      private static function analyze(data:String) : void
      {
         var i:int = 0;
         var s:* = null;
         var index:int = 0;
         var name:* = null;
         var value:* = null;
         var list:Array = String(data).split("\r\n");
         for(i = 0; i < list.length; )
         {
            s = list[i];
            if(s.indexOf("#") != 0)
            {
               s = s.replace(/\\r/g,"\r");
               s = s.replace(/\\n/g,"\n");
               index = s.indexOf(":");
               if(index != -1)
               {
                  name = s.substring(0,index);
                  value = s.substr(index + 1);
                  value = value.split("##")[0];
                  _dic[name] = StringUtils.trimRight(value);
               }
            }
            i++;
         }
      }
      
      public static function GetTranslation(translationId:String, ... args) : String
      {
         var id:int = 0;
         var str:* = null;
         var idx:int = 0;
         var input:String = !!_dic[translationId]?_dic[translationId]:"";
         var obj:Object = _reg.exec(input);
         while(obj && args.length > 0)
         {
            id = obj[1];
            str = String(args[id]);
            if(id >= 0 && id < args.length)
            {
               idx = str.indexOf("$");
               if(idx > -1)
               {
                  str = str.slice(0,idx) + "$" + str.slice(idx);
               }
               input = input.replace(_reg,str);
            }
            else
            {
               input = input.replace(_reg,"{}");
            }
            obj = _reg.exec(input);
         }
         return input;
      }
   }
}
