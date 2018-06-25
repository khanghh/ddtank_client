package morn.core.managers{   import flash.events.Event;   import flash.utils.Dictionary;      public class RenderManager   {                   private var _methods:Dictionary;            public function RenderManager() { super(); }
            private function invalidate() : void { }
            private function onValidate(e:Event) : void { }
            public function renderAll() : void { }
            public function callLater(method:Function, args:Array = null) : void { }
            public function exeCallLater(method:Function) : void { }
            public function removeCallLaterByObj(obj:Object) : void { }
            public function removeCallLater(fun:Function) : void { }
   }}