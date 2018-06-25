package BraveDoor.event
{
   import BombTurnTable.event.TurnTableEvent;
   import flash.events.Event;
   
   public class BraveDoorEvent extends Event
   {
       
      
      private var _data:Object;
      
      public function BraveDoorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         _data = data;
         super(type,bubbles,cancelable);
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
