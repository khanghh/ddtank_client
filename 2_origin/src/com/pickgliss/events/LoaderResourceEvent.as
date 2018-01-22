package com.pickgliss.events
{
   import flash.events.Event;
   
   public class LoaderResourceEvent extends Event
   {
      
      public static const INIT_COMPLETE:String = "init complete";
      
      public static const COMPLETE:String = "complete";
      
      public static const LOAD_ERROR:String = "loadError";
      
      public static const PROGRESS:String = "progress";
      
      public static const DELETE:String = "delete";
      
      public static const LOADXML_COMPLETE:String = "loadxmlComplete";
       
      
      public var filePath:String;
      
      public var data;
      
      public var progress:Number;
      
      public function LoaderResourceEvent(param1:String)
      {
         super(param1);
      }
   }
}
