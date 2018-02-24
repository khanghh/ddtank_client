package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   
   public final class OverwriteManager
   {
      
      public static const version:Number = 6.1;
      
      public static const NONE:int = 0;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const AUTO:int = 2;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_ONSTART:int = 4;
      
      public static const PREEXISTING:int = 5;
      
      public static var mode:int;
      
      public static var enabled:Boolean;
       
      
      public function OverwriteManager(){super();}
      
      public static function init(param1:int = 2) : int{return 0;}
      
      public static function manageOverwrites(param1:TweenLite, param2:Object, param3:Array, param4:int) : Boolean{return false;}
      
      public static function getGlobalPaused(param1:TweenCore) : Boolean{return false;}
   }
}
