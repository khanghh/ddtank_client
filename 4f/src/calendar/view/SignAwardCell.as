package calendar.view{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.DisplayObject;      public class SignAwardCell extends BaseCell   {                   private var _bigBack:DisplayObject;            private var _nameField:FilterFrameText;            private var _tbxCount:FilterFrameText;            public function SignAwardCell() { super(null); }
            public function setCount(count:int) : void { }
            override protected function createChildren() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override public function dispose() : void { }
   }}