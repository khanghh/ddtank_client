package wonderfulActivity.newActivity.ExchangeAct
{
   import flash.events.Event;
   
   public class ExchangeGoodsEvent extends Event
   {
      
      public static const ExchangeGoodsChange:String = "ExchangeGoodsChange";
       
      
      private var _enable:Boolean;
      
      public function ExchangeGoodsEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _enable = param2;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
   }
}
