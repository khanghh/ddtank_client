package campbattle.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CampBattleReturnBtn extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _moveOutBtn:SimpleBitmapButton;            private var _moveInBtn:SimpleBitmapButton;            public var returnBtn:SimpleBitmapButton;            private var _isDice:Boolean;            public function CampBattleReturnBtn() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function inHandler(event:MouseEvent) : void { }
            private function exitHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}