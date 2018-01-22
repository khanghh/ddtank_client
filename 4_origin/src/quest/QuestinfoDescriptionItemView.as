package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   
   public class QuestinfoDescriptionItemView extends QuestInfoItemView
   {
       
      
      private var _discriptionTxt:FilterFrameText;
      
      public function QuestinfoDescriptionItemView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("asset.core.quest.QuestInfoDescTitleImg");
         addChild(_titleImg);
         _discriptionTxt = ComponentFactory.Instance.creatComponentByStylename("core.quest.QuestInfoDescription");
         _content.addChild(_discriptionTxt);
      }
      
      override public function set info(param1:QuestInfo) : void
      {
         _info = param1;
         _discriptionTxt.htmlText = "<br/>   " + QuestDescTextAnalyz.start(_info.Detail) + "<br/><br/>";
         _panel.setViewPosition(1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_discriptionTxt);
         _discriptionTxt = null;
         super.dispose();
      }
   }
}
