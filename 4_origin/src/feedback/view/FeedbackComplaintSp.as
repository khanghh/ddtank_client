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
   
   public class FeedbackComplaintSp extends Sprite implements Disposeable
   {
       
      
      private var _closeBtn:TextButton;
      
      private var _complaintSourceAsterisk:Bitmap;
      
      private var _complaintSourceInput:TextInput;
      
      private var _complaintSourceTextImg:FilterFrameText;
      
      private var _complaintTitleAsterisk:Bitmap;
      
      private var _complaintTitleInput:TextInput;
      
      private var _complaintTitleTextImg:FilterFrameText;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _playersMobileAsterisk:Bitmap;
      
      private var _playersMobileInput:TextInput;
      
      private var _playersMobileTextImg:FilterFrameText;
      
      private var _playersNameAsterisk:Bitmap;
      
      private var _playersNameInput:TextInput;
      
      private var _playersNameTextImg:FilterFrameText;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackComplaintSp()
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
         if(!_submitFrame.feedbackInfo.user_full_name)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.user_full_name"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.user_phone)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.user_phone"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.complaints_title)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.complaints_title"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.complaints_source)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.complaints_source"));
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
         _playersNameTextImg = null;
         _playersNameInput = null;
         _playersNameAsterisk = null;
         _playersMobileTextImg = null;
         _playersMobileInput = null;
         _playersMobileAsterisk = null;
         _complaintTitleTextImg = null;
         _complaintTitleInput = null;
         _complaintTitleAsterisk = null;
         _complaintSourceTextImg = null;
         _complaintSourceInput = null;
         _complaintSourceAsterisk = null;
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
         _submitFrame.feedbackInfo.user_full_name = _playersNameInput.text;
         _submitFrame.feedbackInfo.user_phone = _playersMobileInput.text;
         _submitFrame.feedbackInfo.complaints_title = _complaintTitleInput.text;
         _submitFrame.feedbackInfo.complaints_source = _complaintSourceInput.text;
      }
      
      public function set submitFrame($submitFrame:FeedbackSubmitFrame) : void
      {
         _submitFrame = $submitFrame;
         if(_submitFrame.feedbackInfo.question_content)
         {
            _detailTextArea.text = _submitFrame.feedbackInfo.question_content;
         }
         if(_submitFrame.feedbackInfo.user_full_name)
         {
            _playersNameInput.text = _submitFrame.feedbackInfo.user_full_name;
         }
         if(_submitFrame.feedbackInfo.user_phone)
         {
            _playersMobileInput.text = _submitFrame.feedbackInfo.user_phone;
         }
         if(_submitFrame.feedbackInfo.complaints_title)
         {
            _complaintTitleInput.text = _submitFrame.feedbackInfo.complaints_title;
         }
         if(_submitFrame.feedbackInfo.complaints_source)
         {
            _complaintSourceInput.text = _submitFrame.feedbackInfo.complaints_source;
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
            info.user_full_name = _submitFrame.feedbackInfo.user_full_name;
            info.user_phone = _submitFrame.feedbackInfo.user_phone;
            info.complaints_title = _submitFrame.feedbackInfo.complaints_title;
            info.complaints_source = _submitFrame.feedbackInfo.complaints_source;
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
         _playersNameTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _playersNameTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text16");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersNameTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_playersNameTextImg,rec);
         addChildAt(_playersNameTextImg,0);
         _playersNameInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersNamelInputRec");
         ObjectUtils.copyPropertyByRectangle(_playersNameInput,rec);
         addChildAt(_playersNameInput,0);
         _playersNameAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersNameAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_playersNameAsterisk,rec);
         addChildAt(_playersNameAsterisk,0);
         _playersMobileTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _playersMobileTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text17");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersMobileTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_playersMobileTextImg,rec);
         addChildAt(_playersMobileTextImg,0);
         _playersMobileInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInputMobile");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersMobileInputRec");
         ObjectUtils.copyPropertyByRectangle(_playersMobileInput,rec);
         _playersMobileInput.textField.restrict = "0-9";
         addChildAt(_playersMobileInput,0);
         _playersMobileAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.playersMobileAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_playersMobileAsterisk,rec);
         addChildAt(_playersMobileAsterisk,0);
         _complaintTitleTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _complaintTitleTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text18");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintTitleTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_complaintTitleTextImg,rec);
         addChildAt(_complaintTitleTextImg,0);
         _complaintTitleInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintTitleInputRec");
         ObjectUtils.copyPropertyByRectangle(_complaintTitleInput,rec);
         addChildAt(_complaintTitleInput,0);
         _complaintTitleAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintTitleAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_complaintTitleAsterisk,rec);
         addChildAt(_complaintTitleAsterisk,0);
         _complaintSourceTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _complaintSourceTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text20");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintSourceTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_complaintSourceTextImg,rec);
         addChildAt(_complaintSourceTextImg,0);
         _complaintSourceInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintSourceInputRec");
         ObjectUtils.copyPropertyByRectangle(_complaintSourceInput,rec);
         addChildAt(_complaintSourceInput,0);
         _complaintSourceAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintSourceAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_complaintSourceAsterisk,rec);
         addChildAt(_complaintSourceAsterisk,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,rec);
         addChildAt(_detailTextImg,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,rec);
         _csTelText.y = 206;
         addChildAt(_infoText,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.complaintDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,rec);
         addChildAt(_detailTextArea,0);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackreport.textBgImg_style1");
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
