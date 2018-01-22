package growthPackage.event
{
   import flash.events.Event;
   
   public class GrowthPackageEvent extends Event
   {
      
      public static const DATA_CHANGE:String = "dataChange";
      
      public static const ICON_CLOSE:String = "icon_close";
       
      
      public var resultData:Object;
      
      public function GrowthPackageEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         resultData = param2;
         super(param1,param3,param4);
      }
   }
}
