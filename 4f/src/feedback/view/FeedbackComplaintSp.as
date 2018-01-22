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
      
      public function FeedbackComplaintSp(){super();}
      
      public function get check() : Boolean{return false;}
      
      public function dispose() : void{}
      
      public function setFeedbackInfo() : void{}
      
      public function set submitFrame(param1:FeedbackSubmitFrame) : void{}
      
      private function __closeBtnClick(param1:MouseEvent) : void{}
      
      private function __submitBtnClick(param1:MouseEvent) : void{}
      
      private function __texeInput(param1:Event) : void{}
      
      private function _init() : void{}
      
      private function addEvent() : void{}
      
      private function remvoeEvent() : void{}
   }
}
