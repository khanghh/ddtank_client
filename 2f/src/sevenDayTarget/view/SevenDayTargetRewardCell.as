package sevenDayTarget.view{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.utils.PositionUtils;   import flash.display.Sprite;      public class SevenDayTargetRewardCell extends Sprite   {                   protected var _itemName:FilterFrameText;            protected var _itemNum:FilterFrameText;            private var cell:BaseCell;            public function SevenDayTargetRewardCell() { super(); }
            protected function initView() : void { }
            public function set itemNum(name:String) : void { }
            public function set itemName(name:String) : void { }
            public function set info(value:ItemTemplateInfo) : void { }
            public function dispose() : void { }
   }}