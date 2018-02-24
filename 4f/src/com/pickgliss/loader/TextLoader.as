package com.pickgliss.loader
{
   import flash.events.Event;
   import flash.net.URLVariables;
   
   public class TextLoader extends BaseLoader
   {
      
      public static var TextLoaderKey:String;
       
      
      public function TextLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super(null,null,null,null);}
      
      override public function get content() : *{return null;}
      
      override protected function __onDataLoadComplete(param1:Event) : void{}
      
      override protected function getLoadDataFormat() : String{return null;}
      
      override public function get type() : int{return 0;}
   }
}
