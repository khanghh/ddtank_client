package store{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class HelpFrame extends Frame   {                   private var _view:Sprite;            private var _submitButton:TextButton;            public function HelpFrame() { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            public function changeSubmitButtonY(offset:int) : void { }
            public function changeSubmitButtonX(offset:int) : void { }
            public function setView(view:DisplayObject) : void { }
            private function _submit(e:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            private function close() : void { }
            override public function dispose() : void { }
   }}