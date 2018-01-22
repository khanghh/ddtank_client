package godsRoads.data
{
   public class GodsRoadsMissionVo
   {
       
      
      public var ID:int;
      
      public var Index:int;
      
      public var isFinished:Boolean;
      
      public var condition1:int;
      
      public var condition2:int;
      
      public var condition3:int;
      
      public var condition4:int;
      
      public var isGetAwards:Boolean;
      
      public var awardsNum:int;
      
      public var awards:Array;
      
      public function GodsRoadsMissionVo()
      {
         awards = [];
         super();
      }
   }
}
