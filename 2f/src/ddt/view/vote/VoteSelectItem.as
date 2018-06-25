package ddt.view.vote{   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.list.VectorListModel;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class VoteSelectItem extends Sprite implements Disposeable   {                   private var _item:SelectedCheckButton;            private var _textTxt:FilterFrameText;            private var _scoreCombox:ComboBox;            private var _scoreArr:Array;            private var _currentScore:int;            private var _text:String;            private var _type:int;            private var _otherSelect:Boolean;            private var _inputTxt:FilterFrameText;            private var _inputBg:Scale9CornerImage;            private var _voteInfo:VoteInfo;            public function VoteSelectItem(type:int, voteInfo:VoteInfo, otherSelect:Boolean = false) { super(); }
            private function initView() : void { }
            public function initEvent() : void { }
            protected function __onListClick(event:ListItemEvent) : void { }
            private function updateComboBox(obj:* = null) : void { }
            private function __playSound(evt:MouseEvent) : void { }
            public function set inputEnable(value:Boolean) : void { }
            private function removeEvent() : void { }
            public function get selected() : Boolean { return false; }
            public function get selectedAnswer() : String { return null; }
            public function get item() : SelectedCheckButton { return null; }
            public function get otherSelect() : Boolean { return false; }
            public function get answerId() : String { return null; }
            public function get score() : int { return 0; }
            public function get content() : String { return null; }
            public function set text(value:String) : void { }
            public function dispose() : void { }
   }}