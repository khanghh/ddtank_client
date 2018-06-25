package littleGame.events{   import flash.events.Event;      public class ScheduleEvent extends Event   {            public static const Complete:String = "complete";                   private var _paras:Array;            public function ScheduleEvent(type:String, ... arg) { super(null); }
            public function get paras() : Array { return null; }
   }}