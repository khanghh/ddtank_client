package team.model
{
   public class TeamInfo
   {
       
      
      public var name:String;
      
      public var teamID:int;
      
      public var grade:int;
      
      public var createDate:Date;
      
      public var tag:String;
      
      public var member:int;
      
      public var totalMember:int;
      
      public var winTime:int;
      
      public var totalTime:int;
      
      public var socre:int;
      
      public var division:int;
      
      public var rank:int;
      
      public var active:int;
      
      public var totalActive:int;
      
      public var maxActive:int;
      
      public var season:int;
      
      public var seasonInfo:Array;
      
      public function TeamInfo()
      {
         super();
      }
      
      public function get rate() : String
      {
         var r:Number = totalTime > 0?winTime / totalTime * 100:0;
         return r.toFixed(2) + "%";
      }
      
      public function get exp() : Number
      {
         if(maxActive == 0)
         {
            return 0;
         }
         return active / maxActive;
      }
   }
}
