package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import flash.text.TextFormat;      public class FightBuffTip extends BaseTip   {                   private var buff_txt:FilterFrameText;            private var detail_txt:FilterFrameText;            private var _bg:ScaleBitmapImage;            private var _tempData:Object;            private var _oriW:int;            private var _oriH:int;            private var _state:int;            public function FightBuffTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            override public function dispose() : void { }
            private function propertyTextColor(color:uint) : void { }
            private function propertyText(value:String) : void { }
            private function detailText(value:String) : void { }
            private function updateWH() : void { }
   }}