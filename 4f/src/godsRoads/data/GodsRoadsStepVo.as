package godsRoads.data
{
   public class GodsRoadsStepVo
   {
       
      
      public var isGetAwards:Boolean;
      
      public var missionsNum:int;
      
      public var missionVos:Array;
      
      public var awadsNum:int;
      
      public var awards:Array;
      
      public var currentStep:int = 0;
      
      public function GodsRoadsStepVo(){super();}
      
      public function getFinishPerNum() : int{return 0;}
      
      public function getFinishPerString() : String{return null;}
   }
}
