package newVersionGuide
{
   import flash.events.Event;
   
   public class NewVersionGuideEvent extends Event
   {
      
      public static var GUIDECOMPLETE:String = "guideComplete";
       
      
      public function NewVersionGuideEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
