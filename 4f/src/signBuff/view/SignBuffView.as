package signBuff.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;      public class SignBuffView extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _btnGroup:SelectedButtonGroup;            private var _signBtn:SelectedButton;            private var _powerBtn:SelectedButton;            private var _signView:SignView;            private var _powerView:PowerView;            public function SignBuffView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __selectedChangeHandler(e:Event) : void { }
            private function _showView(type:int) : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}