package starling.events
{
   public class EnterFrameEvent extends Event
   {
      
      public static const ENTER_FRAME:String = "enterFrame";
       
      
      public function EnterFrameEvent(param1:String, param2:Number, param3:Boolean = false){super(null,null,null);}
      
      public function get passedTime() : Number{return 0;}
   }
}
