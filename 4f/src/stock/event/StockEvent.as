package stock.event
{
   import flash.events.Event;
   
   public final class StockEvent extends Event
   {
      
      public static const ACCOUNT_UPDATE:String = "account_update";
      
      public static const STOCK_ALL_UPDATE:String = "stock_all_update";
      
      public static const STOCK_SPECIFICS_UPDATE:String = "stock_specifics_update";
      
      public static const STOCK_USER_INFO:String = "stock_user_info";
      
      public static const STOCK_NEWS:String = "stock_news";
      
      public static const STOCK_DEAL_MESSAGE:String = "stock_deal_message";
      
      public static const STOCK_CHOOSE:String = "stock_choose";
      
      public static const STOCK_SELL_OUT:String = "stock_sell_out";
      
      public static const STOCK_UPDATE_SCORE:String = "stock_update_score";
      
      public static const STOCK_EXCHANGE_AWARD:String = "stock_exchange_award";
       
      
      private var _data = null;
      
      public function StockEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : *{return null;}
   }
}
