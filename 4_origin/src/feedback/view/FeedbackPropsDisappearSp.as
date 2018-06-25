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
   
   public class FeedbackPropsDisappearSp extends Sprite implements Disposeable
   {
       
      
      private var _acquirementAsterisk:Bitmap;
      
      private var _acquirementTextImg:FilterFrameText;
      
      private var _acquirementTextInput:TextInput;
      
      private var _closeBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _getTimeAsterisk:Bitmap;
      
      private var _infoDateText:FilterFrameText;
      
      private var _getTimeTextImg:FilterFrameText;
      
      private var _getTimeTextInput:TextInput;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackPropsDisappearSp()
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
         if(!_submitFrame.feedbackInfo.goods_get_method)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.goods_get_method"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.goods_get_date)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.goods_get_date"));
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
         _acquirementTextImg = null;
         _acquirementTextInput = null;
         _acquirementAsterisk = null;
         _getTimeTextImg = null;
         _getTimeTextInput = null;
         _getTimeAsterisk = null;
         _infoDateText = null;
         _csTelText = null;
         _detailTextImg = null;
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
         _submitFrame.feedbackInfo.goods_get_method = _acquirementTextInput.text;
         _submitFrame.feedbackInfo.goods_get_date = _getTimeTextInput.text;
      }
      
      public function set submitFrame($submitFrame:FeedbackSubmitFrame) : void
      {
         _submitFrame = $submitFrame;
         if(_submitFrame.feedbackInfo.question_content)
         {
            _detailTextArea.text = _submitFrame.feedbackInfo.question_content;
         }
         if(_submitFrame.feedbackInfo.goods_get_method)
         {
            _acquirementTextInput.text = _submitFrame.feedbackInfo.goods_get_method;
         }
         if(_submitFrame.feedbackInfo.goods_get_date)
         {
            _getTimeTextInput.text = _submitFrame.feedbackInfo.goods_get_date;
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
            info.goods_get_method = _submitFrame.feedbackInfo.goods_get_method;
            info.goods_get_date = _submitFrame.feedbackInfo.goods_get_date;
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
         _acquirementTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _acquirementTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text9");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextImg,rec);
         addChildAt(_acquirementTextImg,0);
         _acquirementTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementInputRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextInput,rec);
         addChildAt(_acquirementTextInput,0);
         _acquirementAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementAsterisk,rec);
         addChildAt(_acquirementAsterisk,0);
         _getTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _getTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text10");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextImg,rec);
         addChildAt(_getTimeTextImg,0);
         _getTimeTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeInputRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextInput,rec);
         _getTimeTextInput.textField.restrict = "0-9\\-";
         addChildAt(_getTimeTextInput,0);
         _getTimeAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeAsterisk,rec);
         addChildAt(_getTimeAsterisk,0);
         _infoDateText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsInfoDateTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoDateText,rec);
         _infoDateText.text = LanguageMgr.GetTranslation("feedback.view.infoDateText");
         addChildAt(_infoDateText,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,rec);
         addChildAt(_detailTextImg,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,rec);
         _csTelText.y = 198;
         addChildAt(_infoText,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,rec);
         _detailTextArea.text = "";
         addChildAt(_detailTextArea,0);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackprop.textBgImg_style");
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
