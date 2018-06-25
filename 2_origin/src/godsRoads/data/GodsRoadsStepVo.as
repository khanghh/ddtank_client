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
      
      public function GodsRoadsStepVo()
      {
         missionVos = [];
         awards = [];
         super();
      }
      
      public function getFinishPerNum() : int
      {
         var i:int = 0;
         var vo:* = null;
         var per:int = 0;
         var tmp:int = 0;
         for(i = 0; i < missionVos.length; )
         {
            vo = missionVos[i] as GodsRoadsMissionVo;
            if(vo.isFinished)
            {
               tmp++;
            }
            i++;
         }
         per = tmp / missionVos.length * 100;
         return per;
      }
      
      public function getFinishPerString() : String
      {
         var i:int = 0;
         var vo:* = null;
         var per:String = "";
         var tmp:int = 0;
         for(i = 0; i < missionVos.length; )
         {
            vo = missionVos[i] as GodsRoadsMissionVo;
            if(vo.isFinished)
            {
               tmp++;
            }
            i++;
         }
         per = tmp + "/" + missionVos.length;
         return per;
      }
   }
}
