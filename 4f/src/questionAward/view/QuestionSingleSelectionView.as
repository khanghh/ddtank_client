package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.utils.ObjectUtils;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionSingleSelectionView extends QuestionSelectViewBase
   {
       
      
      private var _questionGroup:SelectedButtonGroup;
      
      public function QuestionSingleSelectionView(param1:QuestionDataBaseInfo){super(null);}
      
      override protected function initView() : void{}
      
      override protected function createCheckBox(param1:String) : SelectedCheckButton{return null;}
      
      override public function getAnswer() : String{return null;}
      
      override public function dispose() : void{}
   }
}
