package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   
   public class QuestinfoDescriptionItemView extends QuestInfoItemView
   {
       
      
      private var _discriptionTxt:FilterFrameText;
      
      public function QuestinfoDescriptionItemView(){super();}
      
      override protected function initView() : void{}
      
      override public function set info(param1:QuestInfo) : void{}
      
      override public function dispose() : void{}
   }
}
