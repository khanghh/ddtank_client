package cardSystem{   import cardSystem.data.CardGrooveInfo;   import cardSystem.data.CardInfo;   import cardSystem.data.GrooveInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.QualityType;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;      public class LaterEquipmentGrooveView extends Component   {            public static const THISWIDTH:int = 200;                   private var _bg:ScaleBitmapImage;            private var _topName:FilterFrameText;            private var _GrooveLevel:FilterFrameText;            private var _GrooveLevelDetail:FilterFrameText;            private var _rule1:ScaleBitmapImage;            private var _propVec:Vector.<FilterFrameText>;            private var _rule2:ScaleBitmapImage;            private var _setsName:FilterFrameText;            private var _setsPropVec:Vector.<FilterFrameText>;            private var _validity:FilterFrameText;            private var _cardInfo:CardInfo;            private var _cardGrooveInfo:GrooveInfo;            private var _place:int;            private var _thisHeight:int;            private var _EpDetail:FilterFrameText;            private var _Explain:FilterFrameText;            public function LaterEquipmentGrooveView() { super(); }
            override protected function init() : void { }
            public function get place() : int { return 0; }
            public function set place(value:int) : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            public function showTip() : void { }
            private function updateView() : void { }
            override protected function addChildren() : void { }
            private function showHeadPart() : void { }
            private function showMiddlePart() : void { }
            private function upBackground() : void { }
            private function updateWH() : void { }
            override public function dispose() : void { }
   }}