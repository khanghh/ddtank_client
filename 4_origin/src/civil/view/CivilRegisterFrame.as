package civil.view
{
   import civil.CivilModel;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import road7th.utils.StringHelper;
   
   public class CivilRegisterFrame extends Frame implements Disposeable
   {
      
      public static const Modify:int = 1;
      
      public static const Creat:int = 0;
      
      private static var _firstOpen:Boolean;
       
      
      private var _model:CivilModel;
      
      private var _state:int;
      
      private var _titleImage:ScaleFrameImage;
      
      private var _nicknameLabel:FilterFrameText;
      
      private var _nicknameField:FilterFrameText;
      
      private var _matrimonyLabel:FilterFrameText;
      
      private var _introductionLabel:FilterFrameText;
      
      private var _matrimonyField:FilterFrameText;
      
      private var _registerBg:ScaleBitmapImage;
      
      private var _nameBg:ScaleBitmapImage;
      
      private var _introductionField:TextArea;
      
      private var _publicEquipButton:SelectedCheckButton;
      
      private var _submitButton:TextButton;
      
      private var _cancelButton:TextButton;
      
      private var _isPublishEquip:Boolean;
      
      private var _introduction:String;
      
      public function CivilRegisterFrame()
      {
         super();
         configUI();
         addEvent();
         selfInfo();
         getSelfInfoForFirstIn();
      }
      
      public function get model() : CivilModel
      {
         return _model;
      }
      
      public function set model(val:CivilModel) : void
      {
         _model = val;
         updateView();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(val:int) : void
      {
         titleText = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.titleText");
         if(_state != val)
         {
            _state = val;
            if(_state == 0)
            {
               DisplayUtils.setFrame(_titleImage,1);
            }
            else if(_state == 1)
            {
               DisplayUtils.setFrame(_titleImage,2);
               titleText = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.modify");
            }
         }
      }
      
      private function updateView() : void
      {
         _nicknameField.text = PlayerManager.Instance.Self.NickName;
         if(PlayerManager.Instance.Self.IsMarried)
         {
            _matrimonyField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.married");
         }
         else
         {
            _matrimonyField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.marry");
         }
         if(PlayerManager.Instance.Self.MarryInfoID <= 0 || !PlayerManager.Instance.Self.MarryInfoID)
         {
            state = 0;
            _introductionField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.text");
            _publicEquipButton.selected = true;
         }
         else
         {
            state = 1;
            _introductionField.text = PlayerManager.Instance.Self.Introduction;
            _publicEquipButton.selected = PlayerManager.Instance.Self.IsPublishEquit;
         }
      }
      
      private function configUI() : void
      {
         _registerBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.register.bg");
         addToContent(_registerBg);
         _nameBg = ComponentFactory.Instance.creatComponentByStylename("register.nameBg");
         addToContent(_nameBg);
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.RegisterTitle");
         DisplayUtils.setFrame(_titleImage,1);
         addToContent(_titleImage);
         _nicknameLabel = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.NicknameLabel");
         _nicknameLabel.text = LanguageMgr.GetTranslation("civil.register.NicknameLabel");
         addToContent(_nicknameLabel);
         _nicknameField = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.NicknameField");
         addToContent(_nicknameField);
         _matrimonyLabel = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.MatrimonyLabel");
         _matrimonyLabel.text = LanguageMgr.GetTranslation("civil.register.MatrimonyLabel");
         addToContent(_matrimonyLabel);
         _matrimonyField = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.MatrimonyField");
         addToContent(_matrimonyField);
         _introductionLabel = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.IntroductionLabel");
         _introductionLabel.text = LanguageMgr.GetTranslation("civil.register.IntroductionLabel");
         addToContent(_introductionLabel);
         _introductionField = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.IntroductionField");
         addToContent(_introductionField);
         _publicEquipButton = ComponentFactory.Instance.creatComponentByStylename("civil.register.PublicEquipButton");
         _publicEquipButton.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.checkBox");
         addToContent(_publicEquipButton);
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.SubmitButton");
         _submitButton.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_submitButton);
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("ddtcivil.register.CancelButton");
         _cancelButton.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_cancelButton);
      }
      
      private function addEvent() : void
      {
         _cancelButton.addEventListener("click",__onCloseClick);
         _submitButton.addEventListener("click",__onSubmitClick);
         _publicEquipButton.addEventListener("click",__onPublicEquipClick);
         addEventListener("response",__response);
         PlayerManager.Instance.addEventListener("civilselfinfochange",__getSelfInfo);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         _introductionField.textField.addEventListener("textInput",__limit);
         addEventListener("addedToStage",__toStage);
      }
      
      private function __toStage(evt:Event) : void
      {
         removeEventListener("addedToStage",__toStage);
         StageReferance.stage.focus = _introductionField.textField;
      }
      
      private function removeEvent() : void
      {
         if(_cancelButton)
         {
            _cancelButton.removeEventListener("click",__onCloseClick);
         }
         if(_submitButton)
         {
            _submitButton.removeEventListener("click",__onSubmitClick);
         }
         if(_introductionField)
         {
            _introductionField.textField.removeEventListener("textInput",__limit);
         }
         if(_publicEquipButton)
         {
            _publicEquipButton.removeEventListener("click",__onPublicEquipClick);
         }
         PlayerManager.Instance.removeEventListener("civilselfinfochange",__getSelfInfo);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         removeEventListener("response",__response);
         removeEventListener("addedToStage",__toStage);
      }
      
      private function __onPublicEquipClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __response(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode) - 1)
         {
            case 0:
               __onCloseClick(null);
               break;
            case 1:
               __onSubmitClick(null);
         }
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["IsPublishEquit"])
         {
            _publicEquipButton.selected = PlayerManager.Instance.Self.IsPublishEquit;
         }
         else if(evt.changedProperties["Introduction"])
         {
            _introductionField.text = PlayerManager.Instance.Self.Introduction;
            _introductionField.textField.setSelection(_introductionField.textField.length,_introductionField.textField.length);
         }
      }
      
      private function __getSelfInfo(evt:Event) : void
      {
         selfInfo();
      }
      
      private function __limit(evt:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_introductionField.textField,300);
      }
      
      private function __onSubmitClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _isPublishEquip = _publicEquipButton.selected;
         if(FilterWordManager.isGotForbiddenWords(_introductionField.text))
         {
            __onCloseClick(null);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.checkIntro"));
            return;
         }
         _introduction = _introductionField.text;
         if(_state == 0)
         {
            _model.registed = true;
            SocketManager.Instance.out.sendRegisterInfo(PlayerManager.Instance.Self.ID,_isPublishEquip,_introduction);
         }
         else
         {
            SocketManager.Instance.out.sendModifyInfo(_isPublishEquip,_introduction);
         }
         _model.updateBtn();
         selfInfo();
         __onCloseClick(null);
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         super.__onCloseClick(event);
         SoundManager.instance.play("008");
         dispatchEvent(new Event("complete"));
      }
      
      private function getSelfInfoForFirstIn() : void
      {
         if(PlayerManager.Instance.Self.MarryInfoID != 0 && !_firstOpen)
         {
            SocketManager.Instance.out.sendForMarryInfo(PlayerManager.Instance.Self.MarryInfoID);
            _firstOpen = true;
         }
      }
      
      private function selfInfo() : void
      {
         if(PlayerManager.Instance.Self.MarryInfoID != 0)
         {
            _publicEquipButton.selected = PlayerManager.Instance.Self.IsPublishEquit;
            _introductionField.text = PlayerManager.Instance.Self.Introduction;
            _introductionField.textField.setSelection(_introductionField.textField.length,_introductionField.textField.length);
         }
         else
         {
            _publicEquipButton.selected = true;
            _introductionField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.text");
            _introductionField.textField.setSelection(_introductionField.textField.length,_introductionField.textField.length);
         }
         if(PlayerManager.Instance.Self.IsMarried)
         {
            _matrimonyField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.married");
         }
         else
         {
            _matrimonyField.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.marry");
         }
         _publicEquipButton.selected = PlayerManager.Instance.Self.IsPublishEquit;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_titleImage)
         {
            ObjectUtils.disposeObject(_titleImage);
            _titleImage = null;
         }
         if(_nicknameLabel)
         {
            ObjectUtils.disposeObject(_nicknameLabel);
            _nicknameLabel = null;
         }
         if(_matrimonyLabel)
         {
            ObjectUtils.disposeObject(_matrimonyLabel);
            _matrimonyLabel = null;
         }
         if(_introductionLabel)
         {
            ObjectUtils.disposeObject(_introductionLabel);
            _introductionLabel = null;
         }
         if(_matrimonyField)
         {
            ObjectUtils.disposeObject(_matrimonyField);
            _matrimonyField = null;
         }
         if(_introductionField)
         {
            ObjectUtils.disposeObject(_introductionField);
            _introductionField = null;
         }
         if(_publicEquipButton)
         {
            ObjectUtils.disposeObject(_publicEquipButton);
            _publicEquipButton = null;
         }
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
            _submitButton = null;
         }
         if(_cancelButton)
         {
            ObjectUtils.disposeObject(_cancelButton);
            _cancelButton = null;
         }
         super.dispose();
      }
   }
}
