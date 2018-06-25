package ddt.view.roulette{   import flash.events.Event;      public class RouletteEvent extends Event   {            public static const ROULETTE_KEYCOUNT_UPDATE:String = "roulette_key_count_update";                   private var _keyCount:int = 0;            public function RouletteEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) { super(null,null,null); }
            public function set keyCount(value:int) : void { }
            public function get keyCount() : int { return 0; }
   }}