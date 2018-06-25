package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;   import pet.data.PetInfo;   import petsBag.view.PetHappyBar;      public class PetHappyTip extends BaseTip   {                   private var _happyValueLbl:FilterFrameText;            private var _happyValueTxt:FilterFrameText;            private var _happyHeartLbl:FilterFrameText;            private var _happyHeartTxt:FilterFrameText;            private var _happyDesc:FilterFrameText;            private var _splitImg:ScaleBitmapImage;            protected var _bg:ScaleBitmapImage;            private var _container:Sprite;            private var _info:PetInfo;            private var LEADING:int = 5;            public function PetHappyTip() { super(); }
            override protected function init() : void { }
            private function initView() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function get tipData() : Object { return null; }
            private function updateView() : void { }
            private function fixPos() : void { }
            private function getPetStatusArray() : Array { return null; }
            private function happyPercent() : Number { return 0; }
            override public function dispose() : void { }
   }}