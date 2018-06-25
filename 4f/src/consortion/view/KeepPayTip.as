package consortion.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class KeepPayTip extends BaseTip   {                   private var _tempData:Object;            private var _name:FilterFrameText;            private var _decript:FilterFrameText;            private var _time:FilterFrameText;            private var _container:Sprite;            private var _bg:ScaleBitmapImage;            public function KeepPayTip() { super(); }
            override protected function init() : void { }
            override public function dispose() : void { }
            override protected function addChildren() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            private function reset() : void { }
            private function drawBG($width:int = 0) : void { }
   }}