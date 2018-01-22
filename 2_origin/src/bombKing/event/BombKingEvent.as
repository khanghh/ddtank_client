package bombKing.event
{
   import flash.events.Event;
   
   public class BombKingEvent extends Event
   {
      
      public static const BOMBKING_OPENVIEW:String = "bombkingOpenView";
      
      public static const STARTLOADBATTLEXML:String = "startloadbattlexml";
      
      public static const RECORDING_MODIFYANGLE:String = "recordingModifyAngle";
       
      
      public var data:Object;
      
      public function BombKingEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,bubbles,cancelable);
      }
   }
}
