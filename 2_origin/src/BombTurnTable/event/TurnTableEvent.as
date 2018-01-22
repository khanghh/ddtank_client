package BombTurnTable.event
{
   import flash.events.Event;
   
   public class TurnTableEvent extends Event
   {
      
      public static const CLICK_LOTTERY:String = "ClickLottery";
      
      public static const LOTTERY_COMPLATE:String = "lotteryComplate";
      
      public static const UPDATE_TURNTABLE_DATA:String = "updateTurntableData";
       
      
      private var _data:Object;
      
      public function TurnTableEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new TurnTableEvent(type,_data,bubbles,cancelable);
      }
   }
}
