package consortion.view.boss{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ConsortiaBossLevelView extends Sprite implements Disposeable   {                   private var _txt:FilterFrameText;            private var _bg:Bitmap;            private var _levelShowBtn:SimpleBitmapButton;            private var _showSprite:Sprite;            private var _selectedBg:Bitmap;            private var _selectedSprite:Sprite;            private var _selectedLevel:int;            private var _cellList:Vector.<ConsortiaBossLevelCell>;            public var currentFrame:int;            public function ConsortiaBossLevelView() { super(); }
            public function set selectedLevel(value:int) : void { }
            public function get selectedLevel() : int { return 0; }
            private function initView() : void { }
            private function initEvent() : void { }
            private function selecteLevelHandler(event:MouseEvent) : void { }
            public function reset() : void { }
            private function showOrHideSelectedSprite(event:MouseEvent) : void { }
            private function getcurrentFrameText() : String { return null; }
            public function dispose() : void { }
   }}