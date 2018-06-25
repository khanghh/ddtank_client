package beadSystem.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;      public class BeadBtnTip extends BaseTip   {                   private var _bg:ScaleBitmapImage;            private var _nameTxt:FilterFrameText;            private var _discTxt:FilterFrameText;            private var _beadTipData:Object;            private var _nameList:Array;            private var _priceList:Array;            public function BeadBtnTip() { super(); }
            private function initView() : void { }
            private function initData() : void { }
            override public function get tipData() : Object { return null; }
            override public function set tipData(data:Object) : void { }
            private function updateSize() : void { }
            override public function dispose() : void { }
   }}