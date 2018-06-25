package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class SearchMemberFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const SEARCH:String = "search";
       
      
      private var _inputText:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      public function SearchMemberFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var alertinfo:AlertInfo = new AlertInfo();
         alertinfo.title = LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame");
         alertinfo.showCancel = false;
         alertinfo.moveEnable = false;
         info = alertinfo;
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("SearchMemberFrame.memberList.TextInputBg");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("SearchMemberFrame.textInput");
         _inputText.text = LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default");
         addToContent(_inputBg);
         addToContent(_inputText);
         initEvent();
      }
      
      private function initEvent() : void
      {
         _inputText.addEventListener("click",__onInputTextClick);
         _inputText.addEventListener("keyDown",__onTextChange);
      }
      
      private function removeEvent() : void
      {
         if(_inputText)
         {
            _inputText.removeEventListener("click",__onInputTextClick);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("keyDown",__onTextChange);
         }
      }
      
      private function __onSearchBtnClick(event:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(2));
      }
      
      private function __onTextChange(event:KeyboardEvent) : void
      {
         if(_inputText.text == LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default"))
         {
            _inputText.text = "";
            return;
         }
         if(event.keyCode == 13)
         {
            dispatchEvent(new FrameEvent(2));
         }
      }
      
      private function __onInputTextClick(event:MouseEvent) : void
      {
         if(_inputText.text == LanguageMgr.GetTranslation("consortion.view.selfConsortia.SearchMemberFrame.default"))
         {
            _inputText.setSelection(0,_inputText.text.length);
         }
      }
      
      public function getSearchText() : String
      {
         return _inputText.text;
      }
      
      public function setFocus() : void
      {
         _inputText.setFocus();
         _inputText.setSelection(_inputText.text.length,_inputText.text.length);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         super.dispose();
      }
   }
}
