package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class MornUIDataLoader extends BaseLoader
   {
       
      
      private var _content;
      
      public function MornUIDataLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         if(args == null)
         {
            args = new URLVariables();
         }
         if(args["rnd"] == null)
         {
            args["rnd"] = TextLoader.TextLoaderKey;
         }
         super(id,url,args,requestMethod);
      }
      
      override protected function __onDataLoadComplete(event:Event) : void
      {
         removeEvent();
         unload();
         var temp:ByteArray = _loader.data;
         temp.uncompress();
         _content = temp.readObject();
         analysisMornUIData();
         fireCompleteEvent();
      }
      
      private function analysisMornUIData() : void
      {
         var View:Object = getDefinitionByName("morn.core.components.View");
         if(View)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _content;
            for(var key in _content)
            {
               View.uiMap[key] = _content[key];
            }
         }
         else
         {
            trace("加载.ui文件异常，未导入morn.core.components.View包~~~~~~~~~" + url);
         }
      }
      
      override public function get content() : *
      {
         return _content;
      }
      
      override public function get type() : int
      {
         return 8;
      }
   }
}
