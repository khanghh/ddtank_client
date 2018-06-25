package mark{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.QualityType;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.utils.Dictionary;   import mark.data.MarkChipData;   import mark.data.MarkChipTemplateData;   import mark.data.MarkProData;   import mark.data.MarkSuitTemplateData;   import morn.core.components.Label;      public class MarkChipTip extends BaseTip implements ITip   {                   private var _display = null;            private var _qualityTxt:FilterFrameText = null;            public function MarkChipTip() { super(); }
            override protected function init() : void { }
            override public function set tipData(value:Object) : void { }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
            override protected function addChildren() : void { }
            override public function dispose() : void { }
   }}