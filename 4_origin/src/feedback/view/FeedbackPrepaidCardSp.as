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
   
   public class FeedbackPrepaidCardSp extends Sprite implements Disposeable
   {
       
      
      private var _closeBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _orderNumberValueAsterisk:Bitmap;
      
      private var _orderNumberValueTextImg:FilterFrameText;
      
      private var _orderNumberValueTextInput:TextInput;
      
      private var _prepaidAmountAsterisk:Bitmap;
      
      private var _prepaidAmountTextImg:FilterFrameText;
      
      private var _prepaidAmountTextInput:TextInput;
      
      private var _prepaidModeAsterisk:Bitmap;
      
      private var _prepaidModeTextImg:FilterFrameText;
      
      private var _prepaidModeTextInput:TextInput;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackPrepaidCardSp()
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
         if(!_submitFrame.feedbackInfo.charge_order_id)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.charge_order_id"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.charge_method)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.charge_method"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.charge_moneys)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.charge_moneys"));
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
         _orderNumberValueTextImg = null;
         _orderNumberValueTextInput = null;
         _orderNumberValueAsterisk = null;
         _prepaidModeTextImg = null;
         _prepaidModeTextInput = null;
         _prepaidModeAsterisk = null;
         _prepaidAmountTextImg = null;
         _prepaidAmountTextInput = null;
         _prepaidAmountAsterisk = null;
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
         _submitFrame.feedbackInfo.charge_order_id = _orderNumberValueTextInput.text;
         _submitFrame.feedbackInfo.charge_method = _prepaidModeTextInput.text;
         _submitFrame.feedbackInfo.charge_moneys = Number(_prepaidAmountTextInput.text);
      }
      
      public function set submitFrame($submitFrame:FeedbackSubmitFrame) : void
      {
         _submitFrame = $submitFrame;
         if(_submitFrame.feedbackInfo.question_content)
         {
            _detailTextArea.text = _submitFrame.feedbackInfo.question_content;
         }
         if(_submitFrame.feedbackInfo.charge_order_id)
         {
            _orderNumberValueTextInput.text = _submitFrame.feedbackInfo.charge_order_id;
         }
         if(_submitFrame.feedbackInfo.charge_method)
         {
            _prepaidModeTextInput.text = _submitFrame.feedbackInfo.charge_method;
         }
         if(_submitFrame.feedbackInfo.charge_moneys)
         {
            _prepaidAmountTextInput.text = String(_submitFrame.feedbackInfo.charge_moneys);
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
            info.charge_order_id = _submitFrame.feedbackInfo.charge_order_id;
            info.charge_method = _submitFrame.feedbackInfo.charge_method;
            info.charge_moneys = _submitFrame.feedbackInfo.charge_moneys;
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
         _orderNumberValueTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _orderNumberValueTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text11");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardOrderNumberValueTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_orderNumberValueTextImg,rec);
         addChildAt(_orderNumberValueTextImg,0);
         _orderNumberValueTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardOrderNumberValueInputRec");
         ObjectUtils.copyPropertyByRectangle(_orderNumberValueTextInput,rec);
         _orderNumberValueTextInput.textField.restrict = "a-zA-Z0-9";
         addChildAt(_orderNumberValueTextInput,0);
         _orderNumberValueAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardOrderNumberValueAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_orderNumberValueAsterisk,rec);
         addChildAt(_orderNumberValueAsterisk,0);
         _prepaidModeTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _prepaidModeTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text12");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidModeTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_prepaidModeTextImg,rec);
         addChildAt(_prepaidModeTextImg,0);
         _prepaidModeTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _prepaidModeTextInput.maxChars = 10;
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidModeInputRec");
         ObjectUtils.copyPropertyByRectangle(_prepaidModeTextInput,rec);
         addChildAt(_prepaidModeTextInput,0);
         _prepaidModeAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidModeAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_prepaidModeAsterisk,rec);
         addChildAt(_prepaidModeAsterisk,0);
         _prepaidAmountTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _prepaidAmountTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text13");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidAmountTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_prepaidAmountTextImg,rec);
         addChildAt(_prepaidAmountTextImg,0);
         _prepaidAmountTextInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidAmountInputRec");
         _prepaidAmountTextInput.textField.restrict = "0-9";
         ObjectUtils.copyPropertyByRectangle(_prepaidAmountTextInput,rec);
         addChildAt(_prepaidAmountTextInput,0);
         _prepaidAmountAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardPrepaidAmountAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_prepaidAmountAsterisk,rec);
         addChildAt(_prepaidAmountAsterisk,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,rec);
         addChildAt(_detailTextImg,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardDisappearInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,rec);
         _csTelText.y = 197;
         addChildAt(_infoText,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         rec = ComponentFactory.Instance.creatCustomObject("feedback.prepaidCardDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,rec);
         addChildAt(_detailTextArea,0);
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackCard.textBgImg_style");
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
