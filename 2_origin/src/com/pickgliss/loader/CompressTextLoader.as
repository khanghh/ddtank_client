package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class CompressTextLoader extends BaseLoader
   {
       
      
      private var _deComressedText:String;
      
      public function CompressTextLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
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
         temp.position = 0;
         _deComressedText = temp.readUTFBytes(temp.bytesAvailable);
         if(analyzer)
         {
            analyzer.analyzeCompleteCall = fireCompleteEvent;
            analyzer.analyzeErrorCall = fireErrorEvent;
            analyzer.analyze(_deComressedText);
         }
         else
         {
            fireCompleteEvent();
         }
      }
      
      override public function get content() : *
      {
         return _deComressedText;
      }
      
      override public function get type() : int
      {
         return 5;
      }
   }
}
