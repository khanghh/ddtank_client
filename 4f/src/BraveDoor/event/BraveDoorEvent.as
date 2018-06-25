package BraveDoor.event{   import BombTurnTable.event.TurnTableEvent;   import flash.events.Event;      public class BraveDoorEvent extends Event   {                   private var _data:Object;            public function BraveDoorEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) { super(null,null,null); }
            public function get data() : Object { return null; }
            override public function clone() : Event { return null; }
   }}