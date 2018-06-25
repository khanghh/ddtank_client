package petsBag.petsAdvanced{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.ITransformableTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class PetsFormItemsTip extends Sprite implements ITransformableTip   {                   protected var _bg:ScaleBitmapImage;            protected var _title:FilterFrameText;            protected var _data:Object;            protected var _tipWidth:int;            protected var _tipHeight:int;            protected var _valid:FilterFrameText;            private var _rule:ScaleBitmapImage;            private var _rule2:ScaleBitmapImage;            private var _itemVec:Vector.<PetsFormItemsTipItem>;            public function PetsFormItemsTip() { super(); }
            protected function init() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(data:Object) : void { }
            private function updateView() : void { }
            private function isActivate() : Boolean { return false; }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}