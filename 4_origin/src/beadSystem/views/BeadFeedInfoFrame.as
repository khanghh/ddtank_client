package beadSystem.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class BeadFeedInfoFrame extends BaseAlerFrame
   {
       
      
      private var _showInfo:FilterFrameText;
      
      private var _prompt:FilterFrameText;
      
      private var _yes:FilterFrameText;
      
      private var _inputBg:Scale9CornerImage;
      
      private var _textInput:TextInput;
      
      public var isBind:Boolean;
      
      public var itemInfo:InventoryItemInfo;
      
      private var _beadName:String;
      
      public function BeadFeedInfoFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         info = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
         _showInfo = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowInfoOneFeed");
         addToContent(_showInfo);
         _prompt = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowTipOneFeed");
         _prompt.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadAlertTip");
         addToContent(_prompt);
         _yes = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadShowTipYES");
         _yes.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadAlertTipYES");
         addToContent(_yes);
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("beadSystem.feedBeadInputBg");
         addToContent(_inputBg);
         _textInput = ComponentFactory.Instance.creatComponentByStylename("beadSystem.textinput");
         addToContent(_textInput);
      }
      
      public function setBeadName(name:String) : void
      {
         _showInfo.htmlText = LanguageMgr.GetTranslation("ddt.beadSystem.feedBeadAlertInfo","[" + name + "]");
      }
      
      private function initEvent() : void
      {
         _textInput.addEventListener("keyDown",__onTextInputKeyDown);
      }
      
      private function removeEvent() : void
      {
         _textInput.removeEventListener("keyDown",__onTextInputKeyDown);
      }
      
      private function __onTextInputKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            dispatchEvent(new FrameEvent(3));
            event.stopPropagation();
         }
      }
      
      private function __confirmhandler(event:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(3));
      }
      
      private function __cancelHandler(event:MouseEvent) : void
      {
         dispatchEvent(new FrameEvent(4));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_showInfo)
         {
            _showInfo.dispose();
            _showInfo = null;
         }
         if(_prompt)
         {
            _prompt.dispose();
            _prompt = null;
         }
         if(_yes)
         {
            _yes.dispose();
            _yes = null;
         }
         if(_inputBg)
         {
            _inputBg.dispose();
            _inputBg = null;
         }
         if(_textInput)
         {
            _textInput.dispose();
            _textInput = null;
         }
      }
      
      public function get textInput() : TextInput
      {
         return _textInput;
      }
   }
}
