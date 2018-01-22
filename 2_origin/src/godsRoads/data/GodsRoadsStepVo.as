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
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < missionVos.length)
         {
            _loc3_ = missionVos[_loc4_] as GodsRoadsMissionVo;
            if(_loc3_.isFinished)
            {
               _loc2_++;
            }
            _loc4_++;
         }
         _loc1_ = _loc2_ / missionVos.length * 100;
         return _loc1_;
      }
      
      public function getFinishPerString() : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < missionVos.length)
         {
            _loc3_ = missionVos[_loc4_] as GodsRoadsMissionVo;
            if(_loc3_.isFinished)
            {
               _loc2_++;
            }
            _loc4_++;
         }
         _loc1_ = _loc2_ + "/" + missionVos.length;
         return _loc1_;
      }
   }
}
