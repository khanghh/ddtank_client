package sevenDayTarget.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class SevenDayTargetHelpFrame extends Frame   {                   private var _view:Sprite;            private var _bg:Scale9CornerImage;            private var _submitButton:TextButton;            private var _helpInfo:MovieClip;            public function SevenDayTargetHelpFrame() { super(); }
            private function initView() : void { }
            public function changeContent(help:MovieClip) : void { }
            private function addEvent() : void { }
            private function __submit(e:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            private function close() : void { }
            override public function dispose() : void { }
   }}