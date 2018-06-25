package gameCommon.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Sprite;      public class DreamLandLogBaseView extends Sprite implements Disposeable   {            protected static const ITEM_COUNT:int = 4;                   protected var _titleTxt:FilterFrameText;            protected var _nameVec:Vector.<FilterFrameText>;            protected var _valueVec:Vector.<FilterFrameText>;            protected var _infoSprite:Sprite;            public function DreamLandLogBaseView() { super(); }
            protected function initView() : void { }
            public function updateView(hurts:Array) : void { }
            private function clearTextInfo() : void { }
            public function dispose() : void { }
   }}