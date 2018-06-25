package trainer.controller{   import com.pickgliss.toplevel.StageReferance;   import flash.events.Event;   import trainer.data.Step;      public class NewHandQueue   {            private static var _instance:NewHandQueue;                   private var _queue:Array;            private var _isDelay:Boolean;            public function NewHandQueue(enforcer:NewHandQueueEnforcer) { super(); }
            public static function get Instance() : NewHandQueue { return null; }
            public function push(step:Step) : void { }
            private function __enterFrame(evt:Event) : void { }
            private function execute() : void { }
            private function next() : void { }
            public function dispose() : void { }
   }}class NewHandQueueEnforcer{          function NewHandQueueEnforcer() { super(); }
}