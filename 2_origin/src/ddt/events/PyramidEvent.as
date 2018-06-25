package ddt.events
{
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class PyramidEvent extends Event
   {
      
      public static const OPEN_OR_CLOSE:String = "open_or_close";
      
      public static const ICON_ENTER:String = "icon_enter";
      
      public static const START_OR_STOP:String = "start_or_stop";
      
      public static const CARD_RESULT:String = "card_result";
      
      public static const DIE_EVENT:String = "die_event";
      
      public static const SCORE_CONVERT:String = "score_convert";
      
      public static const OPENANDCLOSE_MOVIE:String = "openAndClose_Movie";
      
      public static const MOVIE_LOCK:String = "movie_lock";
      
      public static const AUTO_OPENCARD:String = "auto_openCard";
      
      public static const DATA_CHANGE:String = "dataChange";
       
      
      public var resultData:Object;
      
      public var Pkg:PackageIn;
      
      public function PyramidEvent(type:String, _resultData:Object = null, pkg:PackageIn = null)
      {
         resultData = _resultData;
         Pkg = pkg;
         super(type,bubbles,cancelable);
      }
   }
}
