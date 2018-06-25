package midAutumnWorshipTheMoon{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;   import midAutumnWorshipTheMoon.view.WorshipTheMoonMainFrame;      public class WorshipTheMoonController   {            private static var instance:WorshipTheMoonController;                   private var _mainFrameMidAutumn:WorshipTheMoonMainFrame;            private var _manager:WorshipTheMoonManager;            private var _isOpen:Boolean = false;            public function WorshipTheMoonController(single:inner) { super(); }
            public static function getInstance() : WorshipTheMoonController { return null; }
            public function setup() : void { }
            private function addEvents() : void { }
            protected function onEventHandler(e:CEvent) : void { }
            private function showFrame() : void { }
            private function hide() : void { }
            private function disposeMainFrame() : void { }
            private function dispose() : void { }
   }}class inner{          function inner() { super(); }
}