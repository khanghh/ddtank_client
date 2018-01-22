package consortion.view.selfConsortia
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import consortion.ConsortionModelManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class ConsortionMailFrame extends Frame
   {
      
      public static const MAIL_PAY:int = 1000;
       
      
      private var _topWord:MutipleImage;
      
      private var _explain:Bitmap;
      
      private var _send:TextButton;
      
      private var _close:TextButton;
      
      private var _recevier:FilterFrameText;
      
      private var _topic:TextInput;
      
      private var _content:TextArea;
      
      private var _bg:ScaleBitmapImage;
      
      private var _addresseeText:FilterFrameText;
      
      private var _subjectText:FilterFrameText;
      
      private var _addresseeInputText:FilterFrameText;
      
      private var _subjectInputText:FilterFrameText;
      
      private var _textAreaBG:MovieImage;
      
      private var _line:MutipleImage;
      
      private var _contentBG:MutipleImage;
      
      private var _explainText:FilterFrameText;
      
      private var _explainText1:FilterFrameText;
      
      private var _explainText2:FilterFrameText;
      
      public function ConsortionMailFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("ddt.consortion.mailFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.bg");
         _topWord = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.titleBG");
         _addresseeText = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.addresseeText");
         _addresseeText.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.addresseeText");
         _subjectText = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.subjectText");
         _subjectText.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.subjectText");
         _textAreaBG = ComponentFactory.Instance.creatComponentByStylename("consortion.mail.bg");
         _line = ComponentFactory.Instance.creatComponentByStylename("consortion.mail.line");
         _contentBG = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.contentBG");
         _send = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.send");
         _close = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.close");
         _recevier = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.recevier");
         _topic = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.title");
         _content = ComponentFactory.Instance.creatComponentByStylename("consortion.mailFrame.content");
         _content.textField.maxChars = 200;
         _explainText = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.explainText");
         _explainText.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.explainText");
         _explainText1 = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.explainText1");
         _explainText1.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.explainText1");
         _explainText2 = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionMailFrame.explainText3");
         _explainText2.text = LanguageMgr.GetTranslation("consortion.consortionMailFrame.explainText3");
         addToContent(_bg);
         addToContent(_topWord);
         addToContent(_addresseeText);
         addToContent(_subjectText);
         addToContent(_textAreaBG);
         addToContent(_line);
         addToContent(_contentBG);
         addToContent(_send);
         addToContent(_close);
         addToContent(_recevier);
         addToContent(_topic);
         addToContent(_content);
         addToContent(_explainText);
         addToContent(_explainText1);
         addToContent(_explainText2);
         _send.text = LanguageMgr.GetTranslation("send");
         _close.text = LanguageMgr.GetTranslation("cancel");
         _recevier.text = LanguageMgr.GetTranslation("ddt.consortion.mailFrame.all");
         _topic.textField.maxChars = 16;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _content.textField.addEventListener("textInput",_contentInputHandler);
         _send.addEventListener("click",__sendHandler);
         _close.addEventListener("click",__closeHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,29),__consortionMailResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _content.textField.removeEventListener("textInput",_contentInputHandler);
         _send.removeEventListener("click",__sendHandler);
         _close.removeEventListener("click",__closeHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,29),__consortionMailResponse);
      }
      
      private function __consortionMailResponse(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.mailFrame.success"));
            ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,PlayerManager.Instance.Self.consortiaInfo.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.consortiaInfo.ConsortiaID);
            dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.mailFrame.fail"));
            _send.enable = true;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function _contentInputHandler(param1:TextEvent) : void
      {
         if(_content.text.length > 300)
         {
            param1.preventDefault();
         }
      }
      
      private function __sendHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.consortiaInfo.Riches < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.mailFrame.noEnagth"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_topic.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.topic"));
            return;
         }
         if(_content.text.length > 300)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.emailII.WritingView.contentLength"));
            return;
         }
         var _loc3_:String = FilterWordManager.filterWrod(_topic.text);
         var _loc2_:String = FilterWordManager.filterWrod(_content.text);
         SocketManager.Instance.out.sendConsortionMail(_loc3_,_loc2_);
         _send.enable = false;
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _topWord = null;
         _addresseeText = null;
         _subjectText = null;
         _textAreaBG = null;
         _line = null;
         _contentBG = null;
         _send = null;
         _close = null;
         _recevier = null;
         _topic = null;
         _content = null;
         _explainText = null;
         _explainText1 = null;
         _explainText2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
