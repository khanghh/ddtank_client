package consortiaDomain
{
   public class EachBuildInfo
   {
       
      
      public var Id:int;
      
      public var Repair:int;
      
      public var Blood:int;
      
      public var State:int;
      
      public var repairPlayerNum:int;
      
      public var lowHpWarnArr:Array;
      
      public function EachBuildInfo()
      {
         var _loc1_:int = 0;
         super();
         lowHpWarnArr = [];
         _loc1_ = 0;
         while(_loc1_ < ConsortiaDomainManager.BUILD_LOW_HP_WARN_ARR.length)
         {
            lowHpWarnArr.push(false);
            _loc1_++;
         }
      }
   }
}
