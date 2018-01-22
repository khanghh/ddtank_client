package BraveDoor.event
{
   import BombTurnTable.event.TurnTableEvent;
   import flash.events.Event;
   
   public class BraveDoorEvent extends Event
   {
       
      
      private var _data:Object;
      
      public function BraveDoorEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : Object{return null;}
      
      override public function clone() : Event{return null;}
   }
}
