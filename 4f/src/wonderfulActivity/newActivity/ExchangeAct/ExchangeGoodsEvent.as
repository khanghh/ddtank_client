package wonderfulActivity.newActivity.ExchangeAct
{
   import flash.events.Event;
   
   public class ExchangeGoodsEvent extends Event
   {
      
      public static const ExchangeGoodsChange:String = "ExchangeGoodsChange";
       
      
      private var _enable:Boolean;
      
      public function ExchangeGoodsEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get enable() : Boolean{return false;}
   }
}
