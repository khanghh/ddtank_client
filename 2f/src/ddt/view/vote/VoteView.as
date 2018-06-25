package ddt.view.vote{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.vote.VoteQuestionInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.manager.VoteManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.FocusEvent;   import flash.events.MouseEvent;      public class VoteView extends Frame   {            public static var OK_CLICK:String = "Ok_click";            public static var VOTEVIEW_CLOSE:String = "voteView_close";            private static var CELL_1_GOODS:int = 11904;            private static var CELL_2_GOODS:int = 11032;            private static var TWOLINEHEIGHT:int = 31;            private static var questionBGHeight_2line:int = 188;            private static var questionBGY_2line:int = 143;            private static var questionContentY_2line:int = 158;            private static const NUMBER:int = 2;                   private var _voteInfo:VoteQuestionInfo;            private var _choseAnswerID:int;            private var _itemArr:Vector.<VoteSelectItem>;            private var _answerGroup:SelectedButtonGroup;            private var _okBtn:TextButton;            private var _answerBG:ScaleBitmapImage;            private var _questionContent:FilterFrameText;            private var _voteProgress:FilterFrameText;            private var _selectSp:Sprite;            private var _bg:ScaleBitmapImage;            private var _itemList:SimpleTileList;            private var _inputTxt:FilterFrameText;            private var _defaultInputTxt:FilterFrameText;            private var panel:ScrollPanel;            public function VoteView() { super(); }
            public function get choseAnswerID() : int { return 0; }
            override protected function init() : void { }
            public function set info(voteInfo:VoteQuestionInfo) : void { }
            private function update() : void { }
            private function __playSound(evt:Event) : void { }
            private function clear() : void { }
            private function addEvent() : void { }
            protected function __inputChangeHandler(event:Event) : void { }
            protected function __searchInputFocusIn(event:FocusEvent) : void { }
            protected function __searchInputFocusOut(event:FocusEvent) : void { }
            protected function __changeHandler(event:Event) : void { }
            private function __clickHandler(evt:MouseEvent) : void { }
            public function get selectAnswer() : String { return null; }
            private function removeEvent() : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            override public function dispose() : void { }
   }}