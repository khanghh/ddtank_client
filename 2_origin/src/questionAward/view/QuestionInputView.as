package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionInputView extends QuestionViewBase
   {
       
      
      private var _txtInfo:TextArea;
      
      public function QuestionInputView(param1:QuestionDataBaseInfo)
      {
         super(param1);
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
         var _loc1_:String = _txtInfo.text.replace("$","USD");
         return _loc1_.replace("|","or");
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
