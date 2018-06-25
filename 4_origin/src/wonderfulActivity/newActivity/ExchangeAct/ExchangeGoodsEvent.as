package wonderfulActivity.newActivity.ExchangeAct
{
   import flash.events.Event;
   
   public class ExchangeGoodsEvent extends Event
   {
      
      public static const ExchangeGoodsChange:String = "ExchangeGoodsChange";
       
      
      private var _enable:Boolean;
      
      public function ExchangeGoodsEvent(type:String, enable:Boolean = true, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         _enable = enable;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
   }
}
