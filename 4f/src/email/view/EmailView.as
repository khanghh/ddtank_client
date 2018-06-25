package email.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.email.EmailModel;   import ddt.events.EmailEvent;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import email.manager.MailControl;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;      public class EmailView extends Sprite implements Disposeable   {                   private var _controller:MailControl;            private var _model:EmailModel;            private var _read:ReadingView;            private var _write:WritingView;            public function EmailView() { super(); }
            public function setup(controller:MailControl, model:EmailModel) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __keyDownHandler(evt:KeyboardEvent) : void { }
            public function dispose() : void { }
            public function show() : void { }
            public function resetWrite() : void { }
            public function cancelMail() : void { }
            private function __addToStage(event:Event) : void { }
            private function __changeType(event:EmailEvent) : void { }
            private function __changeState(event:EmailEvent) : void { }
            private function __changePage(event:EmailEvent) : void { }
            private function __selectEmail(event:EmailEvent) : void { }
            private function __removeEmail(event:EmailEvent) : void { }
            private function __initEmail(event:EmailEvent) : void { }
            private function updateListView() : void { }
            public function get writeView() : WritingView { return null; }
   }}