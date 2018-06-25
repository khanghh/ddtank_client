package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionInputView extends QuestionViewBase
   {
       
      
      private var _txtInfo:TextArea;
      
      public function QuestionInputView(value:QuestionDataBaseInfo)
      {
         super(value);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _txtInfo = ComponentFactory.Instance.creatComponentByStylename("questionAward.inputView");
         _txtInfo.textField.maxChars = 50;
         addChild(_txtInfo);
      }
      
      override public function getAnswer() : String
      {
         var result:String = _txtInfo.text.replace("$","USD");
         return result.replace("|","or");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_txtInfo)
         {
            ObjectUtils.disposeObject(_txtInfo);
            _txtInfo = null;
         }
      }
   }
}
