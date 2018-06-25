package ddt.view.academyCommon.academyIcon{   import academy.AcademyManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.manager.AcademyFrameManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;      public class AcademyIcon extends Sprite implements Disposeable, ITipedDisplay   {                   private var _icon:ScaleFrameImage;            private var _tipStyle:String;            private var _tipDirctions:String;            private var _tipData:Object;            private var _tipGapH:int;            private var _tipGapV:int;            private var _myColorMatrix_filter:ColorMatrixFilter;            public function AcademyIcon() { super(); }
            private function init() : void { }
            private function updateIcon() : void { }
            private function __onClick(event:MouseEvent) : void { }
            public function dispose() : void { }
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
   }}