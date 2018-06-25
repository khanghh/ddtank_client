package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import flash.text.TextFormat;      public class PropTxtTip extends BaseTip   {                   protected var property_txt:FilterFrameText;            protected var detail_txt:FilterFrameText;            protected var _bg:ScaleBitmapImage;            private var _tempData:Object;            protected var _oriW:int;            protected var _oriH:int;            public function PropTxtTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            override public function dispose() : void { }
            private function propertyTextColor(color:uint) : void { }
            private function propertyText(value:String) : void { }
            protected function updateWidth() : void { }
            private function detailText(value:String) : void { }
            protected function updateWH(bool:Boolean = false) : void { }
   }}