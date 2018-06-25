package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   
   public class TextLoader extends BaseLoader
   {
      
      public static var TextLoaderKey:String;
       
      
      public function TextLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super(id,url,args,requestMethod);
      }
      
      override public function get content() : *
      {
         return _loader.data;
      }
      
      override protected function __onDataLoadComplete(event:Event) : void
      {
         removeEvent();
         unload();
         if(analyzer)
         {
            analyzer.analyzeCompleteCall = fireCompleteEvent;
            analyzer.analyzeErrorCall = fireErrorEvent;
            analyzer.analyze(_loader.data);
         }
         else
         {
            fireCompleteEvent();
         }
      }
      
      override protected function getLoadDataFormat() : String
      {
         return "text";
      }
      
      override public function get type() : int
      {
         return 2;
      }
   }
}
