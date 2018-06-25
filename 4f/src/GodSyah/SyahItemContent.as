package GodSyah{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class SyahItemContent extends Sprite   {                   private var _leftBtn:BaseButton;            private var _rightBtn:BaseButton;            private var _cellVec:Vector.<SyahSelfCell>;            private var _index:int = -1;            private var _content:Sprite;            private var _alphaArr:Array;            private var _tip:ScaleBitmapImage;            private var _txt:FilterFrameText;            public function SyahItemContent() { super(); }
            private function _buildUI() : void { }
            private function _addEvent() : void { }
            private function __changeItem(e:MouseEvent) : void { }
            public function showContent() : void { }
            private function _configEvent() : void { }
            private function __overAlphaArea(e:MouseEvent) : void { }
            private function __outAlphaArea(e:MouseEvent) : void { }
            private function _removeAllChild() : void { }
            public function dispose() : void { }
   }}