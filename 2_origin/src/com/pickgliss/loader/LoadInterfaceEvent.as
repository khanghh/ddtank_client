package com.pickgliss.loader
{
   import flash.events.Event;
   
   public class LoadInterfaceEvent extends Event
   {
      
      public static const CHECK_COMPLETE:String = "checkComplete";
      
      public static const DELETE_COMPLETE:String = "deleteComplete";
      
      public static const FLASH_GOTO_AND_PLAY:String = "flashGotoAndPlay";
      
      public static const SET_SOUND:String = "setSound";
       
      
      public var paras:Array;
      
      public function LoadInterfaceEvent(param1:String, param2:Array)
      {
         this.paras = param2;
         super(param1);
      }
   }
}
