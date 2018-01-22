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
      
      public function getName(param1:Boolean) : String
      {
         return !!param1?teamName:enemyName;
      }
      
      public function getZone(param1:Boolean) : String
      {
         return !!param1?teamZone:enemyZone;
      }
      
      public function getKill(param1:Boolean) : int
      {
         return !!param1?teamKill:int(enemyKill);
      }
      
      public function getSurvival(param1:Boolean) : int
      {
         return !!param1?teamSurvival:int(enemySurvival);
      }
      
      public function getMemberInfo(param1:Boolean) : Array
      {
         var _loc2_:String = !!param1?teamMemberInfo:enemyMemberInfo;
         var _loc3_:Array = _loc2_.split("|");
         return _loc3_;
      }
   }
}
