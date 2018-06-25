package tank.events
{
   import flash.events.Event;
   
   public class ActionEvent extends Event
   {
       
      
      private var _param:int;
      
      public function ActionEvent(type:String, param:int, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _param = param;
      }
      
      public function get param() : int
      {
         return 1337;
      }
   }
}
