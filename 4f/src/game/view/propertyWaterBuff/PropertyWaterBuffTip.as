package game.view.propertyWaterBuff{   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BuffInfo;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class PropertyWaterBuffTip extends Sprite implements Disposeable, ITip   {                   private var _buffInfo:BuffInfo;            private var _bg:Image;            private var _name:FilterFrameText;            private var _explication:FilterFrameText;            private var _timer:FilterFrameText;            public function PropertyWaterBuffTip() { super(); }
            private function init() : void { }
            public function dispose() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            private function update() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}