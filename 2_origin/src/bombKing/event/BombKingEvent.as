package bombKing.event
{
   import flash.events.Event;
   
   public class BombKingEvent extends Event
   {
      
      public static const BOMBKING_OPENVIEW:String = "bombkingOpenView";
      
      public static const STARTLOADBATTLEXML:String = "startloadbattlexml";
      
      public static const RECORDING_MODIFYANGLE:String = "recordingModifyAngle";
       
      
      public var data:Object;
      
      public function BombKingEvent(type:String, value:Object = null)
      {
         data = value;
         super(type,bubbles,cancelable);
      }
   }
}
