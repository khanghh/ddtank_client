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
      
      public function set submitFrame(param1:FeedbackSubmitFrame) : void
      {
         _submitFrame = param1;
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
      
      private function __closeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FeedbackManager.instance.closeFrame();
      }
      
      private function __submitBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         setFeedbackInfo();
         if(check)
         {
            _loc2_ = new FeedbackInfo();
            _loc2_.question_type = _submitFrame.feedbackInfo.question_type;
            _loc2_.question_title = _submitFrame.feedbackInfo.question_title;
            _loc2_.occurrence_date = _submitFrame.feedbackInfo.occurrence_date;
            _loc2_.question_content = _submitFrame.feedbackInfo.question_content;
            _loc2_.report_url = _submitFrame.feedbackInfo.report_url;
            _loc2_.report_user_name = _submitFrame.feedbackInfo.report_user_name;
            FeedbackManager.instance.submitFeedbackInfo(_loc2_);
         }
      }
      
      private function __texeInput(param1:Event) : void
      {
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars - _detailTextArea.textField.length);
      }
      
      private function _init() : void
      {
         var _loc1_:* = null;
         _reportTitleOrUrlTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _reportTitleOrUrlTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text14");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlTextImg,_loc1_);
         addChildAt(_reportTitleOrUrlTextImg,0);
         _reportTitleOrUrlInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlInputRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlInput,_loc1_);
         addChildAt(_reportTitleOrUrlInput,0);
         _reportTitleOrUrlAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportTitleOrUrlAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_reportTitleOrUrlAsterisk,_loc1_);
         addChildAt(_reportTitleOrUrlAsterisk,0);
         _reportUserNameTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _reportUserNameTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text15");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameTextImg,_loc1_);
         addChildAt(_reportUserNameTextImg,0);
         _reportUserNameInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameInputRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameInput,_loc1_);
         addChildAt(_reportUserNameInput,0);
         _reportUserNameAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportUserNameAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_reportUserNameAsterisk,_loc1_);
         addChildAt(_reportUserNameAsterisk,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,_loc1_);
         addChildAt(_detailTextImg,0);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,_loc1_);
         addChildAt(_infoText,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _csTelText.y = 187;
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.reportDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,_loc1_);
         addChildAt(_detailTextArea,0);
         _detailTextArea.text = "";
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackreport.textBgImg_style");
         addChildAt(_textInputBg,0);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.submitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_submitBtn,_loc1_);
         _submitBtn.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.submitBtnText");
         addChildAt(_submitBtn,0);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.closeBtnRec");
         ObjectUtils.copyPropertyByRectangle(_closeBtn,_loc1_);
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
