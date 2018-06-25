package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import pet.data.PetInfo;      public class PetBenchBagTip extends BaseTip   {                   protected var _bg:ScaleBitmapImage;            private var _splitImg:ScaleBitmapImage;            private var _petName:FilterFrameText;            protected var _attackTxt:FilterFrameText;            protected var _defenceTxt:FilterFrameText;            protected var _HPTxt:FilterFrameText;            protected var _agilityTxt:FilterFrameText;            protected var _luckTxt:FilterFrameText;            public function PetBenchBagTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function dispose() : void { }
            private function updateWH() : void { }
   }}