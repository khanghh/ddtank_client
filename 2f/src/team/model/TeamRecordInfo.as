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
      
      public function TeamRecordInfo(){super();}
      
      public function getName(param1:Boolean) : String{return null;}
      
      public function getZone(param1:Boolean) : String{return null;}
      
      public function getKill(param1:Boolean) : int{return 0;}
      
      public function getSurvival(param1:Boolean) : int{return 0;}
      
      public function getMemberInfo(param1:Boolean) : Array{return null;}
   }
}
