package im{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.Helpers;   import ddt.utils.PositionUtils;   import ddt.view.PlayerPortraitView;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import org.aswing.KeyboardManager;      public class GirlHeadSelectView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _closeBtn:SimpleBitmapButton;            private var _headGirlPhoto:PlayerPortraitView;            private var _headGameHead:PlayerPortraitView;            private var _headGirlPhoto2:PlayerPortraitView;            private var _headNewHead:Bitmap;            private var _selectCurHead:SelectedCheckButton;            private var _selectNewHead:SelectedCheckButton;            private var _selectGroup:SelectedButtonGroup;            private var _confirmUsingCurHead:SimpleBitmapButton;            private var _confirmUsingNewHead:SimpleBitmapButton;            private var _curHeadUseGirlPic:Boolean;            private var _onCurHeadSelectedCallBack:Function;            private var _onNewHeadSelectedCallBack:Function;            private var _onCloseCallBack:Function;            public function GirlHeadSelectView() { super(); }
            protected function onConfirmUsingCurHead(e:MouseEvent) : void { }
            protected function onConfirmUsingNewHead(e:MouseEvent) : void { }
            protected function onSelectChange(e:Event) : void { }
            protected function onSelectClick(e:MouseEvent) : void { }
            protected function onRFS(e:Event) : void { }
            protected function onKeyDown(e:KeyboardEvent) : void { }
            protected function onCurHeadSelectHandler(e:MouseEvent) : void { }
            public function set onUseNewPic(value:Function) : void { }
            public function set onCurHeadSelected(value:Function) : void { }
            public function set onClose(value:Function) : void { }
            public function dispose() : void { }
            private function onCloseBtnClick(e:MouseEvent) : void { }
   }}