package magicHouse.magicCollection{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;      public class MagicHouseTitleTip extends BaseTip   {                   private var _bg:ScaleBitmapImage;            private var _tipTitle:FilterFrameText;            private var _attack:FilterFrameText;            private var _attackValue:FilterFrameText;            private var _defense:FilterFrameText;            private var _defenseValue:FilterFrameText;            private var _damage:FilterFrameText;            private var _damageValue:FilterFrameText;            public function MagicHouseTitleTip() { super(); }
            override protected function init() : void { }
            override public function set tipData(data:Object) : void { }
            private function setTitleText(value:String) : void { }
            private function atcAddValueText(value:int) : void { }
            private function defAddValueText(value:int) : void { }
            private function lukAddValueText(value:int) : void { }
            public function setBGWidth(bgWidth:int = 0) : void { }
            public function setBGHeight(bgHeight:int = 0) : void { }
            override protected function addChildren() : void { }
            override public function dispose() : void { }
   }}