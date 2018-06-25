package christmas.view.makingSnowmenView{   import christmas.ChristmasCoreManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class SnowPackDoubleFrame extends BaseAlerFrame   {                   private var _selectedDoubleCheckButton:SelectedCheckButton;            public var buyFunction:Function;            public var clickFunction:Function;            private var _txt:FilterFrameText;            private var _txtTwo:FilterFrameText;            private var _addNumTxt:FilterFrameText;            private var _inputTxt:FilterFrameText;            private var _maxBnt:BaseButton;            private var _inputPng:Bitmap;            private var _target:Sprite;            private var _isOpen:Boolean;            private var _addDoubleNumTxt:FilterFrameText;            public function SnowPackDoubleFrame() { super(); }
            public function set target($target:Sprite) : void { }
            private function initView() : void { }
            public function initAddView(isOpen:Boolean = false) : void { }
            public function setIsShow(isShow:Boolean = true, select:int = 0) : void { }
            private function initEvents() : void { }
            private function __addMax(e:MouseEvent) : void { }
            private function mouseClickHander(e:MouseEvent) : void { }
            private function removeEvnets() : void { }
            private function responseHander(e:FrameEvent) : void { }
            public function setTxt(str:String) : void { }
            override public function dispose() : void { }
   }}