package newVersionGuide
{
   import flash.events.Event;
   
   public class NewVersionGuideEvent extends Event
   {
      
      public static var GUIDECOMPLETE:String = "guideComplete";
       
      
      public function NewVersionGuideEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
