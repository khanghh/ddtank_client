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
   import ddt.utils.PositionUtils;
   import feedback.FeedbackManager;
   import feedback.data.FeedbackInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.StringHelper;
   
   public class FeedbackStealHandSp extends Sprite implements Disposeable
   {
       
      
      private var _acquirementAsterisk:Bitmap;
      
      private var _acquirementTextImg:FilterFrameText;
      
      private var _acquirementTextInput:TextInput;
      
      private var _backBtn:TextButton;
      
      private var _closeBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelPos:Point;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _explainTextArea:TextArea;
      
      private var _getTimeAsterisk:Bitmap;
      
      private var _infoDateText:FilterFrameText;
      
      private var _getTimeTextImg:FilterFrameText;
      
      private var _getTimeTextInput:TextInput;
      
      private var _nextBtn:TextButton;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackStealHandSp()
      {
         super();
         _init();
      }
      
      public function get check() : Boolean
      {
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
         _explainTextArea = null;
         _acquirementTextImg = null;
         _acquirementTextInput = null;
         _acquirementAsterisk = null;
         _getTimeTextImg = null;
         _getTimeTextInput = null;
         _getTimeAsterisk = null;
         _infoDateText = null;
         _detailTextImg = null;
         _csTelText = null;
         _infoText = null;
         _detailTextArea = null;
         _nextBtn = null;
         _closeBtn = null;
         _backBtn = null;
         _submitBtn = null;
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
      
      private function __backBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _submitFrame.problemCombox.mouseEnabled = true;
         _submitFrame.problemCombox.mouseChildren = true;
         _submitFrame.problemTitleInput.mouseEnabled = true;
         _submitFrame.problemTitleInput.mouseChildren = true;
         _explainTextArea.visible = true;
         _nextBtn.visible = true;
         _closeBtn.visible = true;
         _backBtn.visible = false;
         _submitBtn.visible = false;
         _detailTextImg.visible = false;
         _detailTextArea.visible = false;
         _csTelText.y = 85;
         _infoText.visible = false;
         _acquirementTextImg.visible = false;
         _acquirementTextInput.visible = false;
         _acquirementAsterisk.visible = false;
         _getTimeTextImg.visible = false;
         _getTimeTextInput.visible = false;
         _getTimeAsterisk.visible = false;
         _infoDateText.visible = false;
         _csTelText.visible = true;
         _textInputBg.y = 105;
         _textInputBg.height = 242;
      }
      
      private function __texeInput(param1:Event) : void
      {
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars - _detailTextArea.textField.length);
      }
      
      private function __closeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FeedbackManager.instance.closeFrame();
      }
      
      private function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_submitFrame.feedbackInfo.question_type < 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_type"));
            return;
         }
         if(!_submitFrame.feedbackInfo.question_title)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_title"));
            return;
         }
         _submitFrame.problemCombox.mouseEnabled = false;
         _submitFrame.problemCombox.mouseChildren = false;
         _submitFrame.problemTitleInput.mouseEnabled = false;
         _submitFrame.problemTitleInput.mouseChildren = false;
         _explainTextArea.visible = false;
         _nextBtn.visible = false;
         _closeBtn.visible = false;
         _infoText.visible = true;
         _backBtn.visible = true;
         _submitBtn.visible = true;
         _detailTextImg.visible = true;
         _detailTextArea.visible = true;
         _csTelText.y = 164;
         _acquirementTextImg.visible = true;
         _acquirementTextInput.visible = true;
         _acquirementAsterisk.visible = true;
         _getTimeTextImg.visible = true;
         _getTimeTextInput.visible = true;
         _getTimeAsterisk.visible = true;
         _infoDateText.visible = true;
         _csTelText.visible = true;
         _textInputBg.y = 187;
         _textInputBg.height = 140;
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
      
      private function _init() : void
      {
         var _loc1_:* = null;
         _explainTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandExplainTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_explainTextArea,_loc1_);
         _explainTextArea.textField.htmlText = LanguageMgr.GetTranslation("feedback.view.explainTextAreaText");
         _explainTextArea.textField.type = "dynamic";
         _explainTextArea.invalidateViewport();
         addChildAt(_explainTextArea,0);
         _acquirementTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _acquirementTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text9");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandAcquirementTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextImg,_loc1_);
         _acquirementTextImg.visible = false;
         addChildAt(_acquirementTextImg,0);
         _acquirementTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandAcquirementInputRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementTextInput,_loc1_);
         _acquirementTextInput.visible = false;
         addChildAt(_acquirementTextInput,0);
         _acquirementAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandAcquirementAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_acquirementAsterisk,_loc1_);
         _acquirementAsterisk.visible = false;
         addChildAt(_acquirementAsterisk,0);
         _getTimeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _getTimeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text10");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandGetTimeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextImg,_loc1_);
         _getTimeTextImg.visible = false;
         addChildAt(_getTimeTextImg,0);
         _getTimeTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandGetTimeInputRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeTextInput,_loc1_);
         _getTimeTextInput.visible = false;
         _getTimeTextInput.textField.restrict = "0-9\\-";
         addChildAt(_getTimeTextInput,0);
         _getTimeAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandGetTimeAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_getTimeAsterisk,_loc1_);
         _getTimeAsterisk.visible = false;
         addChildAt(_getTimeAsterisk,0);
         _infoDateText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandInfoDateTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoDateText,_loc1_);
         _infoDateText.text = LanguageMgr.GetTranslation("feedback.view.infoDateText");
         addChildAt(_infoDateText,0);
         _infoDateText.visible = false;
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,_loc1_);
         _detailTextImg.visible = false;
         addChildAt(_detailTextImg,0);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,_loc1_);
         addChildAt(_infoText,0);
         _infoText.visible = false;
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _csTelPos = new Point();
         PositionUtils.setPos(_csTelPos,_csTelText);
         _csTelText.y = 85;
         _csTelText.visible = true;
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,_loc1_);
         _detailTextArea.text = "";
         _detailTextArea.visible = false;
         addChildAt(_detailTextArea,0);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackStealHand.textBgImg_style");
         addChildAt(_textInputBg,0);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandNextBtnRec");
         ObjectUtils.copyPropertyByRectangle(_nextBtn,_loc1_);
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         addChildAt(_nextBtn,0);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.closeBtnRec");
         ObjectUtils.copyPropertyByRectangle(_closeBtn,_loc1_);
         _closeBtn.text = LanguageMgr.GetTranslation("tank.invite.InviteView.close");
         addChildAt(_closeBtn,0);
         _backBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandBackBtnRec");
         ObjectUtils.copyPropertyByRectangle(_backBtn,_loc1_);
         _backBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.preview");
         _backBtn.visible = false;
         addChildAt(_backBtn,0);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("feedback.btn");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.stealHandSubmitBtnRec");
         ObjectUtils.copyPropertyByRectangle(_submitBtn,_loc1_);
         _submitBtn.text = LanguageMgr.GetTranslation("feedback.view.FeedbackSubmitSp.submitBtnText");
         _submitBtn.visible = false;
         addChildAt(_submitBtn,0);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _nextBtn.addEventListener("click",__nextBtnClick);
         _backBtn.addEventListener("click",__backBtnClick);
         _submitBtn.addEventListener("click",__submitBtnClick);
         _closeBtn.addEventListener("click",__closeBtnClick);
         _detailTextArea.textField.addEventListener("change",__texeInput);
      }
      
      private function remvoeEvent() : void
      {
         _nextBtn.addEventListener("click",__nextBtnClick);
         _backBtn.addEventListener("click",__backBtnClick);
         _submitBtn.addEventListener("click",__submitBtnClick);
         _closeBtn.removeEventListener("click",__closeBtnClick);
         _detailTextArea.textField.removeEventListener("change",__texeInput);
      }
   }
}
