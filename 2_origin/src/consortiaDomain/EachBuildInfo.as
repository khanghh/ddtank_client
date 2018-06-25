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
         var i:int = 0;
         super();
         lowHpWarnArr = [];
         for(i = 0; i < ConsortiaDomainManager.BUILD_LOW_HP_WARN_ARR.length; )
         {
            lowHpWarnArr.push(false);
            i++;
         }
      }
   }
}
