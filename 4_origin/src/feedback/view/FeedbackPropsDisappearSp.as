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
      
      public function set submitFrame(param1:FeedbackSubmitFrame) : void
      {
         _submitFrame = param1;
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
            _loc2_.goods_get_method = _submitFrame.feedbackInfo.goods_get_method;
            _loc2_.goods_get_date = _submitFrame.feedbackInfo.goods_get_date;
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
         _acquirementTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _acquirementTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text9");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextImg,_loc1_);
         addChildAt(_acquirementTextImg,0);
         _acquirementTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementInputRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextInput,_loc1_);
         addChildAt(_acquirementTextInput,0);
         _acquirementAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsAcquirementAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementAsterisk,_loc1_);
         addChildAt(_acquirementAsterisk,0);
         _getTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _getTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text10");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextImg,_loc1_);
         addChildAt(_getTimeTextImg,0);
         _getTimeTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeInputRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextInput,_loc1_);
         _getTimeTextInput.textField.restrict = "0-9\\-";
         addChildAt(_getTimeTextInput,0);
         _getTimeAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsGetTimeAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeAsterisk,_loc1_);
         addChildAt(_getTimeAsterisk,0);
         _infoDateText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsInfoDateTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoDateText,_loc1_);
         _infoDateText.text = LanguageMgr.GetTranslation("feedback.view.infoDateText");
         addChildAt(_infoDateText,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,_loc1_);
         addChildAt(_detailTextImg,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,_loc1_);
         _csTelText.y = 198;
         addChildAt(_infoText,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.propsDisappearDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,_loc1_);
         _detailTextArea.text = "";
         addChildAt(_detailTextArea,0);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackprop.textBgImg_style");
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
