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
      
      public static function callBack(param1:Object) : void
      {
         if(param1)
         {
            if(param1 != null)
            {
               setLang(String(param1));
            }
         }
      }
      
      private static function setLang(param1:String) : void
      {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc2_:Object = {};
         if(Boolean(param1))
         {
            _loc3_ = new XML(param1);
            for each(_loc4_ in _loc3_.item)
            {
               App.lang.add(_loc4_.@key,String(_loc4_.@value));
            }
         }
      }
   }
}
