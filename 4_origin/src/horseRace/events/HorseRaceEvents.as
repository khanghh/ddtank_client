package horseRace.events
{
   import flash.events.Event;
   
   public class HorseRaceEvents extends Event
   {
      
      public static const HORSERACE_INITPLAYER:String = "horseRace_initPlayer";
      
      public static const HORSERACE_PLAYERSPEED_CHANGE:String = "HORSERACE_PLAYERSPEED_CHANGE";
      
      public static const HORSERACE_RACE_END:String = "HORSERACE_RACE_END";
      
      public static const HORSERACE_START_FIVE:String = "HORSERACE_START_FIVE";
      
      public static const HORSERACE_BEGIN_RACE:String = "HORSERACE_BEGIN_RACE";
      
      public static const HORSERACE_BUFF_FLUSH:String = "HORSERACE_BUFF_FLUSH";
      
      public static const HORSERACE_BUFF_ITEMFLUSH:String = "HORSERACE_BUFF_ITEMFLUSH";
      
      public static const HORSERACE_SHOW_MSG:String = "HORSERACE_SHOW_MSG";
      
      public static const HORSERACE_ALLPLAYER_RACEEND:String = "HORSERACE_ALLPLAYER_RACEEND";
      
      public static const HORSERACE_SYN_ONESECOND:String = "HORSERACE_SYN_ONESECOND";
      
      public static const HORSERACE_USE_PINGZHANG:String = "HORSERACE_USE_PINGZHANG";
      
      public static const HORSERACE_USE_DAOJU:String = "HORSERACE_USE_DAOJU";
       
      
      public var data:Object;
      
      public function HorseRaceEvents(param1:String, param2:Object = null)
      {
         super(param1);
         this.data = param2;
      }
   }
}
