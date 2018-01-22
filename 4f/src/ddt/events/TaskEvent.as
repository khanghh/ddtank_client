package ddt.events
{
   import ddt.data.quest.QuestDataInfo;
   import ddt.data.quest.QuestInfo;
   import flash.events.Event;
   
   public class TaskEvent extends Event
   {
      
      public static const INIT:String = "init";
      
      public static const CHANGED:String = "changed";
      
      public static const ADD:String = "add";
      
      public static const REMOVE:String = "remove";
      
      public static const FINISH:String = "finish";
       
      
      private var _info:QuestInfo;
      
      private var _data:QuestDataInfo;
      
      public function TaskEvent(param1:String, param2:QuestInfo, param3:QuestDataInfo){super(null,null,null);}
      
      public function get info() : QuestInfo{return null;}
      
      public function get data() : QuestDataInfo{return null;}
   }
}
