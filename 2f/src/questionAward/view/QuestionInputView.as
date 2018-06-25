package questionAward.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.utils.ObjectUtils;   import questionAward.data.QuestionDataBaseInfo;      public class QuestionInputView extends QuestionViewBase   {                   private var _txtInfo:TextArea;            public function QuestionInputView(value:QuestionDataBaseInfo) { super(null); }
            override protected function initView() : void { }
            override public function getAnswer() : String { return null; }
            override public function dispose() : void { }
   }}