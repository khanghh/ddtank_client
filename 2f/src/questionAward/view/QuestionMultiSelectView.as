package questionAward.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import questionAward.data.QuestionDataBaseInfo;      public class QuestionMultiSelectView extends QuestionSelectViewBase   {                   public function QuestionMultiSelectView(value:QuestionDataBaseInfo) { super(null); }
            override protected function createCheckBox(name:String) : SelectedCheckButton { return null; }
            override public function getAnswer() : String { return null; }
   }}