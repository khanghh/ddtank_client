package escort.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import escort.EscortManager;   import escort.event.EscortEvent;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class EscortRankView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _moveInBtn:SimpleBitmapButton;            private var _moveOutBtn:SimpleBitmapButton;            private var _rankTxt:FilterFrameText;            private var _nameTxt:FilterFrameText;            private var _rateTxt:FilterFrameText;            private var _sprintTxt:FilterFrameText;            private var _rankCellList:Vector.<EscortRankCell>;            public function EscortRankView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function inHandler(event:MouseEvent) : void { }
            private function refreshRankList(event:EscortEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}