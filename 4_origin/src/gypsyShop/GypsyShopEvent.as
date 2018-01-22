package gypsyShop
{
   import flash.events.Event;
   
   public class GypsyShopEvent extends Event
   {
      
      public static const SHOW_MAIN_FRAME:String = "gyps_show_main";
      
      public static const HIDE_MAIN_FRAME:String = "gyps_hide_main";
      
      public static const RARE_ITEMS_UPDATE:String = "gyps_rare_update";
      
      public static const ITEM_LIST_UPDATE:String = "gyps_item_list_update";
      
      public static const BUY_RESULT:String = "gyps_buy_result";
      
      public static const MONEY_NEEDED:String = "gyps_money_needed";
      
      public static const HONOUR_NEEDED:String = "gyps_honour_needed";
      
      public static const RMB_NEEDED:String = "gyps_rmb_needed";
       
      
      private var _data:Object;
      
      public function GypsyShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         _data = param2;
         super(param1,param3,param4);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
