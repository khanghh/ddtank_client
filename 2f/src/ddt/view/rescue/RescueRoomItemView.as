package ddt.view.rescue{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddt.utils.ImgNumConverter;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import rescue.data.RescueRoomInfo;      public class RescueRoomItemView extends Sprite implements Disposeable   {                   private var _openSp:Sprite;            private var _closeSp:Sprite;            private var _openBg:Bitmap;            private var _closeBg:Bitmap;            private var _openBtn:SimpleBitmapButton;            private var _closeBtn:SimpleBitmapButton;            private var _sceneImg:Bitmap;            private var _scoreTxt:Sprite;            private var _arrowTxt:Sprite;            private var _arrowTxt2:Sprite;            private var _bloodBagTxt:Sprite;            private var _sceneId:int = -1;            public function RescueRoomItemView() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __closeBtnClick(event:MouseEvent) : void { }
            protected function __openBtnClick(event:MouseEvent) : void { }
            public function update(info:RescueRoomInfo) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}