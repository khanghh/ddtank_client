package zodiac{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;      public class ZodiacFrame extends Frame   {                   private var _bg:ScaleBitmapImage;            private var _mainView:ZodiacMainView;            private var _rollingView:ZodiacRollingView;            public function ZodiacFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __response(e:FrameEvent) : void { }
            public function get mainView() : ZodiacMainView { return null; }
            public function get rollingView() : ZodiacRollingView { return null; }
            override public function dispose() : void { }
   }}