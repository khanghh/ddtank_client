package ddt.loader{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.core.Disposeable;   import flash.events.EventDispatcher;      public class TrainerLoader extends EventDispatcher implements Disposeable   {                   private var _module:String;            private var _loadCompleted:Boolean;            public function TrainerLoader(module:String) { super(); }
            public function get completed() : Boolean { return false; }
            public function load() : void { }
            private function __onUIModuleComplete(evt:UIModuleEvent) : void { }
            public function dispose() : void { }
   }}