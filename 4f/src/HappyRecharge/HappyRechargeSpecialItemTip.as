package HappyRecharge{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.geom.Point;      public class HappyRechargeSpecialItemTip extends BaseTip   {                   private var _bg:ScaleBitmapImage;            private var _titleTxt:FilterFrameText;            private var _bodyTxt:FilterFrameText;            private var _line:ScaleBitmapImage;            public function HappyRechargeSpecialItemTip() { super(); }
            override protected function init() : void { }
            public function setBGWidth(bgWidth:int = 0) : void { }
            public function setBGHeight(bgHeight:int = 0) : void { }
            override public function set tipData(data:Object) : void { }
            override protected function addChildren() : void { }
            override public function dispose() : void { }
   }}