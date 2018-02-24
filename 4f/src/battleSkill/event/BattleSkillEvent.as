package battleSkill.event
{
   import flash.events.Event;
   
   public class BattleSkillEvent extends Event
   {
      
      public static var OPEN_SKILL_VIEW:String = "openSkillView";
      
      public static var CLOSE_VIEW:String = "closeSkillView";
      
      public static var BATTLESKILL_INFO:String = "battleSkillInfo";
      
      public static var UPDATE_SKILL:String = "updateBattleSkill";
      
      public static var BRIGHT_SKILL:String = "bringBattleSkill";
      
      public static var SKILLCELL_CLICK:String = "skillCellClick";
       
      
      private var _data:Object;
      
      public function BattleSkillEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : Object{return null;}
      
      override public function clone() : Event{return null;}
   }
}
