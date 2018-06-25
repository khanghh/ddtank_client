package floatParade.views{   import com.greensock.TweenLite;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class FloatParadeExitBtn extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _moveOutBtn:SimpleBitmapButton;            private var _moveInBtn:SimpleBitmapButton;            private var _returnBtn:SimpleBitmapButton;            public function FloatParadeExitBtn() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function inHandler(event:MouseEvent) : void { }
            private function exitHandler(event:MouseEvent) : void { }
            private function __exitConfirm(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}