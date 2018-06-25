package homeTemple.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import homeTemple.HomeTempleController;      public class HomeTempleFrame extends Frame implements Disposeable   {                   private var _btnHelp:BaseButton;            private var _blessing:HomeTempleBlessing;            private var _levelView:HomeTempleLevel;            public function HomeTempleFrame() { super(); }
            private function initEvent() : void { }
            private function initView() : void { }
            protected function __onResponse(event:FrameEvent) : void { }
            public function resetBlessingPos() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}