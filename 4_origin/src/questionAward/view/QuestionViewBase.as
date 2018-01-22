package questionAward.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import questionAward.data.QuestionDataBaseInfo;
   
   public class QuestionViewBase extends Sprite
   {
       
      
      protected var _title:FilterFrameText;
      
      protected var _info:QuestionDataBaseInfo;
      
      public function QuestionViewBase(param1:QuestionDataBaseInfo)
      {
         super();
         _info = param1;
         if(_info == null)
         {
            return;
         }
         initView();
         initData();
      }
      
      public function getAnswer() : String
      {
         return "";
      }
      
      protected function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("questionAward.titleTxt");
         addChild(_title);
      }
      
      protected function initData() : void
      {
         var _loc1_:* = null;
         if(_title)
         {
            _title.text = _info.title;
            if(_info.type == 1)
            {
               _loc1_ = !!_info.isMultiSelect?"questionAward.multiSelectTxt":"questionAward.singleSelectTxt";
               _title.text = _title.text + LanguageMgr.GetTranslation(_loc1_);
            }
         }
      }
      
      public function dispose() : void
      {
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         _info = null;
      }
   }
}
