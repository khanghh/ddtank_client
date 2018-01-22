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
      
      public function SearchMemberFrame(){super();}
      
      override protected function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onSearchBtnClick(param1:MouseEvent) : void{}
      
      private function __onTextChange(param1:KeyboardEvent) : void{}
      
      private function __onInputTextClick(param1:MouseEvent) : void{}
      
      public function getSearchText() : String{return null;}
      
      public function setFocus() : void{}
      
      override public function dispose() : void{}
   }
}
