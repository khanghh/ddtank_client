package cityBattle.event
{
   import flash.events.Event;
   
   public class CityBattleEvent extends Event
   {
      
      public static const SCORE_CHANGE:String = "scoreChange";
      
      public static const JOIN_BATTLE:String = "joinBattle";
      
      public static const SCORE_RANK:String = "score_rank";
       
      
      public var data:Object;
      
      public function CityBattleEvent(type:String, data:Object = null)
      {
         this.data = data;
         super(type);
      }
   }
}
