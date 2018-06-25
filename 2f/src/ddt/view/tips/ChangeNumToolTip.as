package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.ui.tip.ITransformableTip;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class ChangeNumToolTip extends BaseTip implements ITransformableTip   {                   private var _title:FilterFrameText;            private var _currentTxt:FilterFrameText;            private var _totalTxt:FilterFrameText;            private var _contentTxt:FilterFrameText;            private var _container:Sprite;            private var _tempData:Object;            private var _bg:ScaleBitmapImage;            public function ChangeNumToolTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            private function update(currentTxt:FilterFrameText, title:String, current:int, total:int, content:String) : void { }
            private function reset() : void { }
            private function drawBG($width:int = 0) : void { }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function get tipHeight() : int { return 0; }
            public function set tipHeight(h:int) : void { }
            override public function dispose() : void { }
   }}