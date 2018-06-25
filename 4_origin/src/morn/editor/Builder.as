package morn.editor
{
   public class Builder
   {
      
      public static var isEditor:Boolean = false;
       
      
      public function Builder()
      {
         super();
      }
      
      public static function init() : void
      {
         App.stage = Sys.stage;
         App.asset = new BuilderResManager();
         isEditor = true;
      }
      
      public static function callBack(data:Object) : void
      {
         if(data)
         {
            if(data != null)
            {
               setLang(String(data));
            }
         }
      }
      
      private static function setLang(text:String) : void
      {
         var xml:* = null;
         var obj:Object = {};
         if(text)
         {
            xml = new XML(text);
            var _loc6_:int = 0;
            var _loc5_:* = xml.item;
            for each(var item in xml.item)
            {
               App.lang.add(item.@key,String(item.@value));
            }
         }
      }
   }
}
