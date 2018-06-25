package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionMultiSelectView extends QuestionSelectViewBase
   {
       
      
      public function QuestionMultiSelectView(value:QuestionDataBaseInfo)
      {
         super(value);
      }
      
      override protected function createCheckBox(name:String) : SelectedCheckButton
      {
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.multiSelectBtn");
         _checkBtn.text = name;
         return _checkBtn;
      }
      
      override public function getAnswer() : String
      {
         var temBtn:* = null;
         var i:int = 0;
         var result:String = "";
         if(_list && _list.numChildren > 0)
         {
            for(i = 0; i < _list.numChildren; )
            {
               temBtn = _list.getChildAt(i) as SelectedCheckButton;
               if(temBtn.selected)
               {
                  result = result + ((i + 1).toString() + "$");
               }
               i++;
            }
            if(result != "")
            {
               result = result.slice(0,result.length - 1);
            }
         }
         return result;
      }
   }
}
