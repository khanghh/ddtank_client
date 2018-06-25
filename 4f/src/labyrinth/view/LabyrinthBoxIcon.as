package labyrinth.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.filters.ColorMatrixFilter;   import labyrinth.LabyrinthManager;      public class LabyrinthBoxIcon extends Sprite implements Disposeable, ITipedDisplay   {                   private var _icon:Bitmap;            private var _levelText:GradientText;            private var _index:int;            private var _level:int;            private var _tipStyle:String;            private var _tipDirctions:String;            private var _tipData:Object;            private var _tipGapH:int;            private var _tipGapV:int;            private var _myColorMatrix_filter:ColorMatrixFilter;            public function LabyrinthBoxIcon(index:int) { super(); }
            private function init() : void { }
            protected function __updateInfo(event:Event) : void { }
            private function update() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}