package bagAndInfo.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;      public class CallPropTxtTip extends BaseTip   {                   private var _bg:ScaleBitmapImage;            private var _tempData:Object;            private var _oriW:int;            private var _oriH:int;            private var _attack:FilterFrameText;            private var _attackValue:FilterFrameText;            private var _defense:FilterFrameText;            private var _defenseValue:FilterFrameText;            private var _agility:FilterFrameText;            private var _agilityValue:FilterFrameText;            private var _lucky:FilterFrameText;            private var _luckyValue:FilterFrameText;            private var _validDate:FilterFrameText;            private var _validDateValue:FilterFrameText;            public var lukAdd:int = 0;            public function CallPropTxtTip() { super(); }
            override protected function init() : void { }
            public function setBGWidth(bgWidth:int = 0) : void { }
            public function setBGHeight(bgHeight:int = 0) : void { }
            private function _buildTipInfo(type:String) : void { }
            override public function set tipData(data:Object) : void { }
            private function atcAddValueText(value:int) : void { }
            private function defAddValueText(value:int) : void { }
            private function agiAddValueText(value:int) : void { }
            private function lukAddValueText(value:int) : void { }
            private function validDateValueText(value:String) : void { }
            override protected function addChildren() : void { }
            override public function dispose() : void { }
   }}