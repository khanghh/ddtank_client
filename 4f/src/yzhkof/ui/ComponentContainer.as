package yzhkof.ui{   import flash.events.Event;   import yzhkof.ui.event.ComponentEvent;      public class ComponentContainer extends ComponentBase   {            public static const CHILD_CHANGE:String = "child_change";                   public function ComponentContainer() { super(); }
            private function __childAdd(e:Event) : void { }
            private function __childRemove(e:Event) : void { }
            private function addChildEvent(child:Object) : void { }
            private function removeChildEvent(child:Object) : void { }
            private function __childUpdate(e:Event) : void { }
   }}