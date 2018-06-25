package loginDevice{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;      public class LoginDeviceMainFrame extends Frame implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _bgbottom:ScaleBitmapImage;            private var _btnGroup:SelectedButtonGroup;            private var _downBtn:SelectedButton;            private var _rewardBtn:SelectedButton;            private var _downView:LoginDeviceDownView;            private var _rewardView:LoginDeviceRewardView;            public function LoginDeviceMainFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function _response(e:FrameEvent) : void { }
            private function __selectedChangeHandler(e:Event) : void { }
            private function _showView(type:int) : void { }
            public function viewsUpdate() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}