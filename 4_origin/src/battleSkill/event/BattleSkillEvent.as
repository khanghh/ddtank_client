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
      
      public function BattleSkillEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _data = data;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new BattleSkillEvent(type,bubbles,cancelable);
      }
   }
}
