package com.pickgliss.events
{
   import com.pickgliss.loader.BaseLoader;
   import flash.events.Event;
   
   public class UIModuleEvent extends Event
   {
      
      public static const UI_MODULE_COMPLETE:String = "uiModuleComplete";
      
      public static const UI_MODULE_ERROR:String = "uiModuleError";
      
      public static const UI_MODULE_PROGRESS:String = "uiMoudleProgress";
       
      
      public var module:String;
      
      public var loader:BaseLoader;
      
      public var state:String;
      
      public function UIModuleEvent(type:String, loader:BaseLoader = null)
      {
         this.loader = loader;
         this.module = loader.loadProgressMessage;
         this.state = loader.loadCompleteMessage;
         super(type);
      }
   }
}
