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
      
      public function QuestionSingleSelectionView(param1:QuestionDataBaseInfo)
      {
         super(param1);
      }
      
      override protected function initView() : void
      {
         _questionGroup = new SelectedButtonGroup();
         super.initView();
         _questionGroup.selectIndex = 0;
      }
      
      override protected function createCheckBox(param1:String) : SelectedCheckButton
      {
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.singleSelectBtn");
         _checkBtn.text = param1;
         _questionGroup.addSelectItem(_checkBtn);
         return _checkBtn;
      }
      
      override public function getAnswer() : String
      {
         return (_questionGroup.selectIndex + 1).toString();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_questionGroup)
         {
            ObjectUtils.disposeObject(_questionGroup);
            _questionGroup = null;
         }
      }
   }
}
