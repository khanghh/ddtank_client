package funnyGames.event
{
   import flash.events.Event;
   
   public class FunnyGamesEvent extends Event
   {
      
      public static const RANK_REWARD_UPDATE:String = "rankRewardUpdate";
      
      public static const RANK_UPDATE:String = "rankUpdate";
       
      
      private var _data:Object;
      
      public function FunnyGamesEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this._data = data;
         super(type,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}
