package ddt.view.common{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.image.ScaleFrameImage;   import ddt.manager.PlayerManager;   import ddt.view.tips.GuildIconTipInfo;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class GuildIcon extends Sprite implements Disposeable, ITipedDisplay   {            public static const BIG:String = "big";            public static const SMALL:String = "small";                   private var _icon:ScaleFrameImage;            private var _tipDirctions:String;            private var _tipGapH:int;            private var _tipGapV:int;            private var _tipStyle:String;            private var _tipData:GuildIconTipInfo;            private var _cid:int;            private var _level:int;            private var _repute:int;            public function GuildIcon() { super(); }
            public function setInfo(level:int, cid:int, repute:int) : void { }
            public function set showTip(value:Boolean) : void { }
            public function set size(value:String) : void { }
            public function get tipStyle() : String { return null; }
            public function get tipData() : Object { return null; }
            public function get tipDirctions() : String { return null; }
            public function get tipGapV() : int { return 0; }
            public function get tipGapH() : int { return 0; }
            public function set tipStyle(value:String) : void { }
            public function set tipData(value:Object) : void { }
            public function set tipDirctions(value:String) : void { }
            public function set tipGapV(value:int) : void { }
            public function set tipGapH(value:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}