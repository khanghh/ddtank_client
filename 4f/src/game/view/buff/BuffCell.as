package game.view.buff{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.BuffType;   import ddt.display.BitmapLoaderProxy;   import ddt.display.BitmapObject;   import ddt.display.BitmapSprite;   import ddt.manager.BitmapManager;   import ddt.manager.PathManager;   import ddt.view.tips.PropTxtTipInfo;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.geom.Matrix;   import flash.geom.Rectangle;   import gameCommon.model.FightBuffInfo;   import gameCommon.view.buff.FightContainerBuff;      public class BuffCell extends BitmapSprite implements ITipedDisplay   {                   private var _info:FightBuffInfo;            private var _bitmapMgr:BitmapManager;            private var _tipData:PropTxtTipInfo;            private var _txt:FilterFrameText;            private var _loaderProxy:BitmapLoaderProxy;            private var _buffAnimation:MovieClip;            public function BuffCell(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) { super(null,null,null,null); }
            override public function dispose() : void { }
            private function deleteBuffAnimation() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function clearSelf() : void { }
            public function setInfo(val:FightBuffInfo) : void { }
            public function get tipData() : Object { return null; }
            private function isContainerBuff(buff:FightBuffInfo) : Boolean { return false; }
            private function isActivityDunBuff(buff:FightBuffInfo) : Boolean { return false; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
   }}