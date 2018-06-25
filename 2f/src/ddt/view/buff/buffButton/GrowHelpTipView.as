package ddt.view.buff.buffButton{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.image.ScaleBitmapImage;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class GrowHelpTipView extends Sprite   {            private static const BTNNUM:int = 5;                   private var _viewBg:ScaleBitmapImage;            private var _buffArray:Vector.<BuffButton>;            private var _openBtn:Vector.<TextButton>;            public function GrowHelpTipView() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function addOpenButton() : void { }
            protected function __onClick(event:MouseEvent) : void { }
            public function addBuff(buffArray:Array) : void { }
            public function dispose() : void { }
            public function get viewBg() : ScaleBitmapImage { return null; }
   }}