package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionMultiSelectView extends QuestionSelectViewBase
   {
       
      
      public function QuestionMultiSelectView(param1:QuestionDataBaseInfo)
      {
         super(param1);
      }
      
      override protected function createCheckBox(param1:String) : SelectedCheckButton
      {
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("questionAward.multiSelectBtn");
         _checkBtn.text = param1;
         return _checkBtn;
      }
      
      override public function getAnswer() : String
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:String = "";
         if(_list && _list.numChildren > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _list.numChildren)
            {
               _loc1_ = _list.getChildAt(_loc3_) as SelectedCheckButton;
               if(_loc1_.selected)
               {
                  _loc2_ = _loc2_ + ((_loc3_ + 1).toString() + "$");
               }
               _loc3_++;
            }
            if(_loc2_ != "")
            {
               _loc2_ = _loc2_.slice(0,_loc2_.length - 1);
            }
         }
         return _loc2_;
      }
   }
}
