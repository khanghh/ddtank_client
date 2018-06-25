package petIsland.event
{
   import flash.events.Event;
   
   public class PetIslandEvent extends Event
   {
      
      public static const RETURN_PETISLAND:String = "return_petIsLand";
      
      public static const PETCLICK:String = "pet_click";
      
      public static const DESTROY:String = "destroy";
      
      public static const PLAYERBLOOD:String = "playerBlood";
      
      public static const NPCBLOOD:String = "npcBlood";
      
      public static const PLAYERSCORE:String = "playerscore";
      
      public static const NPCSCORE:String = "npcscore";
      
      public static const CURRENTROUND:String = "round";
      
      public static const STEP:String = "step";
      
      public static const REWARDRECORD:String = "rewardRecord";
      
      public static const CURRENTLEVEL:String = "currentLevel";
      
      public static const OPENTYPE:String = "openType";
      
      public static const SAVELIFECOUNT:String = "saveLifeCount";
      
      public static const SAVELIFE2COUNT:String = "saveLife2Count";
      
      public static const REFRESH:String = "refresh";
      
      public static const STEPCHANGE:String = "stepChange";
      
      public static const USESKILL:String = "useSkill";
      
      public static const USESKILLTWO:String = "useSkillTwo";
       
      
      public var resultData:Object;
      
      public function PetIslandEvent(type:String, _resultData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         resultData = _resultData;
         super(type,bubbles,cancelable);
      }
   }
}
