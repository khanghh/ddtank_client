package feedback.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import road7th.utils.StringHelper;
   
   public class FeedbackReportSp extends Sprite implements Disposeable
   {
       
      
      private var _closeBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _reportTitleOrUrlAsterisk:Bitmap;
      
      private var _reportTitleOrUrlInput:TextInput;
      
      private var _reportTitleOrUrlTextImg:FilterFrameText;
      
      private var _reportUserNameAsterisk:Bitmap;
      
      private var _reportUserNameInput:TextInput;
      
      private var _reportUserNameTextImg:FilterFrameText;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackReportSp()
      {
         super();
         _init();
      }
      
      public function get check() : Boolean
      {
         if(_submitFrame.feedbackInfo.question_type < 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_type"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.question_title)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_title"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.report_url)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.report_url"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.report_user_name)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.report_user_name"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.question_content)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_content"));
            return false;
         }
         if(_submitFrame.feedbackInfo.question_content.length < 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_LessThanEight"));
            return false;
         }
         return true;
      }
      
      public function dispose() : void
      {
         remvoeEvent();
         ObjectUtils.disposeAllChildren(this);
         _reportTitleOrUrlTextImg = null;
         _reportTitleOrUrlInput = null;
         _reportTitleOrUrlAsterisk = null;
         _reportUserNameTextImg = null;
         _reportUserNameInput = null;
         _reportUserNameAsterisk = null;
         _detailTextImg = null;
         _csTelText = null;
         _infoText = null;
         _detailTextArea = null;
         _submitBtn = null;
         _closeBtn = null;
         _submitFrame = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function setFeedbackInfo() : void
      {
         _submitFrame.feedbackInfo.question_content = _detailTextArea.text;
         _submitFrame.feedbackInfo.report_url = _reportTitleOrUrlInput.text;
         _submitFrame.feedbackInfo.report_user_name = _reportUserNameInput.text;
      }
      
      public function set submitFrame($submitFrame:FeedbackSubmitFrame) : void
      {
         _submitFrame = $submitFrame;
         if(_submitFrame.feedbackInfo.question_content)
         {
            _detailTextArea.text = _submitFrame.feedbackInfo.question_content;
         }
         if(_submitFrame.feedbackInfo.report_url)
         {
            _reportTitleOrUrlInput.text = _submitFrame.feedbackInfo.report_url;
         }
         if(_submitFrame.feedbackInfo.report_user_name)
         {
            _reportUserNameInput.text = _submitFrame.feedbackInfo.report_user_name;
         }
         __texeInput(null);
      }
      
      private function __closeBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FeedbackManager.instance.closeFrame();
      }
      
      private function __submitBtnClick(event:MouseEvent) : void
      {
         var info:* = null;
         SoundManager.instance.play("008");
         setFeedbackInfo();
         if(check)
         {
            info = new FeedbackInfo();
            info.question_type = _submitFrame.feedbackInfo.question_type;
            info.question_title = _submitFrame.feedbackInfo.question_title;
            info.occurrence_date = _submitFrame.feedbackInfo.occurrence_date;
            info.question_content = _submitFrame.feedbackInfo.question_content;
            info.report_url = _submitFrame.feedbackInfo.report_url;
            info.report_user_name = _submitFrame.feedbackInfo.report_user_name;
            FeedbackManager.instance.submitFeedbackInfo(info);
         }
      }
      
      private function __texeInput(event:Event) : void
      {
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars - _detailTextArea.textField.length);
      }
      
      private function _init() : void
      {
         var rec:* = null;
         _reportTitleOrUrlTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _reportTitleOrUrlTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text14");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlTextImg,rec);
         addChildAt(_reportTitleOrUrlTextImg,0);
         _reportTitleOrUrlInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlInputRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlInput,rec);
         addChildAt(_reportTitleOrUrlInput,0);
         _reportTitleOrUrlAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlAsterisk,rec);
         addChildAt(_reportTitleOrUrlAsterisk,0);
         _reportUserNameTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _reportUserNameTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text15");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameTextImg,rec);
         addChildAt(_reportUserNameTextImg,0);
         _reportUserNameInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameInputRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameInput,rec);
         addChildAt(_reportUserNameInput,0);
         _reportUserNameAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameAsterisk,rec);
         addChildAt(_reportUserNameAsterisk,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,rec);
         addChildAt(_detailTextImg,0);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,rec);
         addChildAt(_infoText,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _csTelText.y = 187;
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.reportDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,rec);
         addChildAt(_detailTextArea,0);
         _detailTextArea.text = "";
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackreport.textBgImg_style");
         addChildAt(_textInputBg,0);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.submitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_submitBtn,rec);
         _submitBtn.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.submitBtnText");
         addChildAt(_submitBtn,0);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.closeBtnRec");
         ObjectUtils.copyPropertyByRectangle(_closeBtn,rec);
         _closeBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.close");
         addChildAt(_closeBtn,0);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _submitBtn.addEventListener("click",__submitBtnClick);
         _closeBtn.addEventListener("click",__closeBtnClick);
         _detailTextArea.textField.addEventListener("change",__texeInput);
      }
      
      private function remvoeEvent() : void
      {
         _submitBtn.removeEventListener("click",__submitBtnClick);
         _closeBtn.removeEventListener("click",__closeBtnClick);
         _detailTextArea.textField.removeEventListener("change",__texeInput);
      }
   }
}
