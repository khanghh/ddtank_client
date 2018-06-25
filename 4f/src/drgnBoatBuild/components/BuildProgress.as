package drgnBoatBuild.components{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import ddt.view.tips.OneLineTip;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class BuildProgress extends Component   {                   private var _progressBg:Bitmap;            private var _progress:Bitmap;            private var _progressMask:Bitmap;            private var _progressTxt:FilterFrameText;            private var _area1:Sprite;            private var _area2:Sprite;            private var _area3:Sprite;            private var _tips:OneLineTip;            public function BuildProgress() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function __mouseOverHandler(event:MouseEvent) : void { }
            protected function __mouseOutHandler(event:MouseEvent) : void { }
            public function setData(completed:int, stage:int, total:int) : void { }
            private function removeEvents() : void { }
            override public function dispose() : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
   }}