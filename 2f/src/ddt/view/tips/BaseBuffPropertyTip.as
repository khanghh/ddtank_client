package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class BaseBuffPropertyTip extends BaseTip   {                   private var _titleTxt:FilterFrameText;            protected var _conditionTxt:FilterFrameText;            protected var _bg:ScaleBitmapImage;            protected var _propertySpri:Sprite;            protected var _propertyList:Vector.<FilterFrameText>;            public function BaseBuffPropertyTip() { super(); }
            protected function initView() : void { }
            public function setBgWidth($width:int) : void { }
            public function setBgHeight($height:int) : void { }
            override public function set tipData(data:Object) : void { }
            protected function getProName() : Array { return null; }
            protected function get bg() : ScaleBitmapImage { return null; }
            protected function get getTitle() : * { return null; }
            public function set titleTxt(value:String) : void { }
            protected function get conditionTxt() : * { return null; }
            protected function set conditionTxt(value:String) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            protected function clearBuffProperty() : void { }
            override public function dispose() : void { }
   }}