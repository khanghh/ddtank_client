package magicHouse{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import ddt.view.DoubleSelectedItem;      public class MagicHouseTipFrame extends Frame   {                   private var _tipTxt:FilterFrameText;            private var _okBtn:TextButton;            private var _cancelBtn:TextButton;            private var _item:DoubleSelectedItem;            public function MagicHouseTipFrame() { super(); }
            public function set item(value:DoubleSelectedItem) : void { }
            public function get item() : DoubleSelectedItem { return null; }
            private function initView() : void { }
            public function get okBtn() : TextButton { return null; }
            public function get cancelBtn() : TextButton { return null; }
            public function setTipText(str:String) : void { }
            public function setTipHtmlText(str:String) : void { }
            public function setFrameWidth($w:int) : void { }
            public function setFrameHeight($h:int) : void { }
            override public function dispose() : void { }
   }}