package email.view{   import com.pickgliss.ui.controls.Frame;   import ddt.manager.SoundManager;   import flash.text.TextField;   import flash.text.TextFormat;      public class BaseEmailRightView extends Frame   {                   protected var _sender:TextField;            protected var _topic:TextField;            protected var _ta:TextField;            public function BaseEmailRightView() { super(); }
            protected function initView() : void { }
            protected function addEvent() : void { }
            protected function removeEvent() : void { }
            protected function btnSound() : void { }
            override public function dispose() : void { }
   }}