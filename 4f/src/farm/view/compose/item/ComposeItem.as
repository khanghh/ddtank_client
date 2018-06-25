package farm.view.compose.item{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class ComposeItem extends BaseCell   {                   protected var _tbxUseCount:FilterFrameText;            protected var _tbxCount:FilterFrameText;            private var _total:int;            private var _need:int;            public function ComposeItem(bg:DisplayObject) { super(null); }
            override protected function createChildren() : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            public function set useCount(count:int) : void { }
            private function fixPos() : void { }
            public function get maxCount() : int { return 0; }
            override public function dispose() : void { }
   }}