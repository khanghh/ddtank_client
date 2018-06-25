package questionAward.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.utils.ObjectUtils;   import questionAward.data.QuestionDataBaseInfo;      public class QuestionSelectViewBase extends QuestionViewBase   {                   protected var _checkBtn:SelectedCheckButton;            protected var _list:VBox;            private var _scrollPanel:ScrollPanel;            public function QuestionSelectViewBase(value:QuestionDataBaseInfo) { super(null); }
            override protected function initView() : void { }
            private function updateScrollBar() : void { }
            protected function createItem() : void { }
            protected function createCheckBox(name:String) : SelectedCheckButton { return null; }
            override public function dispose() : void { }
   }}