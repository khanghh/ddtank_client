package feedback.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
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
   
   public class FeedbackProblemsSp extends Sprite implements Disposeable
   {
       
      
      private var _activityTitleTextImg:FilterFrameText;
      
      private var _closeBtn:TextButton;
      
      private var _detailTextArea:TextArea;
      
      private var _csTelText:FilterFrameText;
      
      private var _detailTextImg:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _noSelectedCheckButton:SelectedCheckButton;
      
      private var _problemsActivityTitleAsterisk:Bitmap;
      
      private var _problemsActivityTitleInput:TextInput;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _submitBtn:TextButton;
      
      private var _submitFrame:FeedbackSubmitFrame;
      
      private var _whetherTheActivitiesTextImg:FilterFrameText;
      
      private var _yesSelectedCheckButton:SelectedCheckButton;
      
      private var _textInputBg:ScaleBitmapImage;
      
      public function FeedbackProblemsSp()
      {
         super();
         _init();
      }
      
      public function get check() : Boolean
      {
         if(_submitFrame.feedbackInfo.question_type <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_type"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.question_title)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.question_title"));
            return false;
         }
         if(!_submitFrame.feedbackInfo.activity_name)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("feedback.view.activity_name"));
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
         _selectedButtonGroup = null;
         _whetherTheActivitiesTextImg = null;
         _yesSelectedCheckButton = null;
         _noSelectedCheckButton = null;
         _problemsActivityTitleInput = null;
         _problemsActivityTitleAsterisk = null;
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
         _submitFrame.feedbackInfo.activity_is_error = _selectedButtonGroup.selectIndex == 0?true:false;
         _submitFrame.feedbackInfo.activity_name = _problemsActivityTitleInput.text;
      }
      
      public function set submitFrame(param1:FeedbackSubmitFrame) : void
      {
         _submitFrame = param1;
         if(_submitFrame.feedbackInfo.question_content)
         {
            _detailTextArea.text = _submitFrame.feedbackInfo.question_content;
         }
         if(_submitFrame.feedbackInfo.activity_is_error)
         {
            _selectedButtonGroup.selectIndex = 0;
         }
         else
         {
            _selectedButtonGroup.selectIndex = 1;
         }
         if(_submitFrame.feedbackInfo.activity_name)
         {
            _problemsActivityTitleInput.text = _submitFrame.feedbackInfo.activity_name;
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
            _loc2_.activity_is_error = _submitFrame.feedbackInfo.activity_is_error;
            _loc2_.activity_name = _submitFrame.feedbackInfo.activity_name;
            FeedbackManager.instance.submitFeedbackInfo(_loc2_);
         }
      }
      
      private function _init() : void
      {
         var _loc1_:* = null;
         _whetherTheActivitiesTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _whetherTheActivitiesTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text7");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsWhetherTheActivitiesTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_whetherTheActivitiesTextImg,_loc1_);
         addChildAt(_whetherTheActivitiesTextImg,0);
         _yesSelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.yesSelectedCheckButton");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.yesSelectedCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_yesSelectedCheckButton,_loc1_);
         _yesSelectedCheckButton.text = LanguageMgr.GetTranslation("yes");
         addChildAt(_yesSelectedCheckButton,0);
         _noSelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("feedback.noSelectedCheckButton");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.noSelectedCheckButtonRec");
         ObjectUtils.copyPropertyByRectangle(_noSelectedCheckButton,_loc1_);
         _noSelectedCheckButton.text = LanguageMgr.GetTranslation("no");
         addChildAt(_noSelectedCheckButton,0);
         _selectedButtonGroup = new SelectedButtonGroup(false,1);
         _selectedButtonGroup.addSelectItem(_yesSelectedCheckButton);
         _selectedButtonGroup.addSelectItem(_noSelectedCheckButton);
         _selectedButtonGroup.selectIndex = 0;
         _activityTitleTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.typeText");
         _activityTitleTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text8");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsActivityTitleTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_activityTitleTextImg,_loc1_);
         addChildAt(_activityTitleTextImg,0);
         _problemsActivityTitleInput = ComponentFactory.Instance.creatComponentByStylename("feedback.textInput");
         _problemsActivityTitleInput.maxChars = 9;
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsActivityTitleInputRec");
         ObjectUtils.copyPropertyByRectangle(_problemsActivityTitleInput,_loc1_);
         addChildAt(_problemsActivityTitleInput,0);
         _problemsActivityTitleAsterisk = ComponentFactory.Instance.creatBitmap("asset.feedback.asteriskImg");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsActivityTitleAsteriskRec");
         ObjectUtils.copyPropertyByRectangle(_problemsActivityTitleAsterisk,_loc1_);
         addChildAt(_problemsActivityTitleAsterisk,0);
         _detailTextImg = ComponentFactory.Instance.creatComponentByStylename("ddtfeedback.descriptionText");
         _detailTextImg.text = LanguageMgr.GetTranslation("feedback.view.Feedback.text6");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsDetailTextImgRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextImg,_loc1_);
         addChildAt(_detailTextImg,0);
         _csTelText = ComponentFactory.Instance.creatComponentByStylename("feedback.csTelText");
         _csTelText.text = LanguageMgr.GetTranslation("feedback.view.csTelNumber",PathManager.solveFeedbackTelNumber());
         if(!StringHelper.isNullOrEmpty(PathManager.solveFeedbackTelNumber()))
         {
            addChild(_csTelText);
         }
         _infoText = ComponentFactory.Instance.creatComponentByStylename("feedback.infoText");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsInfoTextRec");
         ObjectUtils.copyPropertyByRectangle(_infoText,_loc1_);
         _csTelText.x = _activityTitleTextImg.x;
         _csTelText.y = 160;
         addChildAt(_infoText,0);
         _detailTextArea = ComponentFactory.Instance.creatComponentByStylename("feedback.simpleTextArea");
         _loc1_ = ComponentFactory.Instance.creatCustomObject("feedback.problemsDetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailTextArea,_loc1_);
         addChildAt(_detailTextArea,0);
         _detailTextArea.text = "";
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars);
         _textInputBg = ComponentFactory.Instance.creatComponentByStylename("feedbackproblem.textBgImg_style");
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
         _yesSelectedCheckButton.addEventListener("click",__selectedCheckBtnClick);
         _noSelectedCheckButton.addEventListener("click",__selectedCheckBtnClick);
      }
      
      private function __texeInput(param1:Event) : void
      {
         _infoText.text = LanguageMgr.GetTranslation("feedback.view.infoText",_detailTextArea.maxChars - _detailTextArea.textField.length);
      }
      
      private function __selectedCheckBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function remvoeEvent() : void
      {
         _submitBtn.removeEventListener("click",__submitBtnClick);
         _closeBtn.removeEventListener("click",__closeBtnClick);
         _detailTextArea.textField.removeEventListener("change",__texeInput);
         _yesSelectedCheckButton.removeEventListener("click",__selectedCheckBtnClick);
         _noSelectedCheckButton.removeEventListener("click",__selectedCheckBtnClick);
      }
   }
}
