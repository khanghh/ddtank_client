package consortion.view.boss{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ConsortiaBossLevelCell extends Sprite implements Disposeable   {                   private var _txt:FilterFrameText;            private var _light:Bitmap;            private var _level:int;            public function ConsortiaBossLevelCell(level:int) { super(); }
            public function judgeMaxLevel(maxLevel:int) : void { }
            public function update(langStr:String) : void { }
            public function changeLightSizePos(width:int, height:int, x:int, y:int) : void { }
            public function get level() : int { return 0; }
            private function overHandler(event:MouseEvent) : void { }
            private function outHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}