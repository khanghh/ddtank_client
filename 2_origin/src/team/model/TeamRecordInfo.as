package team.model
{
   public class TeamRecordInfo
   {
       
      
      public var date:Date;
      
      public var active:int;
      
      public var isWin:Boolean;
      
      public var fightName:String;
      
      public var teamName:String;
      
      public var teamZone:String;
      
      public var teamKill:int;
      
      public var teamSurvival:int;
      
      public var teamMemberInfo:String;
      
      public var enemyName:String;
      
      public var enemyZone:String;
      
      public var enemyKill:int;
      
      public var enemySurvival:int;
      
      public var enemyMemberInfo:String;
      
      public var teamList:Array;
      
      public var enemyList:Array;
      
      public function TeamRecordInfo()
      {
         teamList = [];
         enemyList = [];
         super();
      }
      
      public function getName(win:Boolean) : String
      {
         return !!win?teamName:enemyName;
      }
      
      public function getZone(win:Boolean) : String
      {
         return !!win?teamZone:enemyZone;
      }
      
      public function getKill(win:Boolean) : int
      {
         return !!win?teamKill:int(enemyKill);
      }
      
      public function getSurvival(win:Boolean) : int
      {
         return !!win?teamSurvival:int(enemySurvival);
      }
      
      public function getMemberInfo(win:Boolean) : Array
      {
         var str:String = !!win?teamMemberInfo:enemyMemberInfo;
         var list:Array = str.split("|");
         return list;
      }
   }
}
