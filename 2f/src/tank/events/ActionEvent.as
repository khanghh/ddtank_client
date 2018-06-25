package tank.events{   import flash.events.Event;      public class ActionEvent extends Event   {                   private var _param:int;            public function ActionEvent(type:String, param:int, bubbles:Boolean = false, cancelable:Boolean = false) { super(null,null,null); }
            public function get param() : int { return 0; }
   }}