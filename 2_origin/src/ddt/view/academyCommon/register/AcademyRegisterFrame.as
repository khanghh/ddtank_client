package ddt.view.academyCommon.register
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import road7th.utils.StringHelper;
   
   public class AcademyRegisterFrame extends BaseAlerFrame implements Disposeable
   {
       
      
      private var _titleImage:ScaleFrameImage;
      
      private var _nicknameLabel:FilterFrameText;
      
      private var _nicknameField:FilterFrameText;
      
      private var _academyHonorLabel:FilterFrameText;
      
      private var _academyHonorField:FilterFrameText;
      
      private var _introductionLabel:FilterFrameText;
      
      private var _checkBox:SelectedCheckButton;
      
      private var _checkBoxLabel:FilterFrameText;
      
      private var _introductionField:TextArea;
      
      private var _alertInfo:AlertInfo;
      
      private var _selfInfo:SelfInfo;
      
      public function AcademyRegisterFrame()
      {
         super();
         initContainer();
         iniEvent();
      }
      
      private function initContainer() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.register.TitleTxt");
         _alertInfo.enterEnable = true;
         _alertInfo.escEnable = true;
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.title");
         _titleImage.setFrame(1);
         addToContent(_titleImage);
         _nicknameLabel = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.NicknameLabel");
         _nicknameLabel.text = LanguageMgr.GetTranslation("civil.register.NicknameLabel");
         addToContent(_nicknameLabel);
         _nicknameField = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.NicknameField");
         addToContent(_nicknameField);
         _academyHonorLabel = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.academyHonorLabel");
         _academyHonorLabel.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRegisterFrame.academyHonorLabel");
         addToContent(_academyHonorLabel);
         _academyHonorField = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.academyHonorField");
         addToContent(_academyHonorField);
         _introductionLabel = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.IntroductionLabel");
         _introductionLabel.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.register.introductionLabel");
         addToContent(_introductionLabel);
         _introductionField = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.IntroductionField");
         _introductionField.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.register.introductionFieldTxt");
         addToContent(_introductionField);
         _checkBoxLabel = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame.checkBoxLabel");
         _checkBoxLabel.text = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.checkBox");
         addToContent(_checkBoxLabel);
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.checkBoxBtn");
         addToContent(_checkBox);
         if(AcademyManager.Instance.selfIsRegister)
         {
            _checkBox.selected = AcademyManager.Instance.isSelfPublishEquip;
         }
         else
         {
            _checkBox.selected = true;
         }
         _selfInfo = PlayerManager.Instance.Self;
         update();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         _introductionField.textField.setFocus();
         _introductionField.textField.setSelection(_introductionField.textField.length,_introductionField.textField.length);
      }
      
      public function isAmend(value:Boolean) : void
      {
         if(value)
         {
            _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.register.TitleTxtII");
            info = _alertInfo;
            if(AcademyManager.Instance.selfDescribe != "" && AcademyManager.Instance.selfDescribe)
            {
               _introductionField.text = AcademyManager.Instance.selfDescribe;
            }
         }
         else
         {
            _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.register.TitleTxt");
            info = _alertInfo;
         }
      }
      
      public function update() : void
      {
         _nicknameField.text = _selfInfo.NickName;
         _academyHonorField.text = _selfInfo.honourOfMaster;
      }
      
      private function iniEvent() : void
      {
         addEventListener("response",__frameEvent);
         _checkBox.addEventListener("click",__checkBoxLabelClick);
         _introductionField.addEventListener("textInput",__limit);
      }
      
      private function __limit(evt:TextEvent) : void
      {
         StringHelper.checkTextFieldLength(_introductionField.textField,150);
      }
      
      private function __checkBoxLabelClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __frameEvent(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(FilterWordManager.isGotForbiddenWords(_introductionField.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.inviteInfo1"));
                  return;
               }
               SocketManager.Instance.out.sendAcademyRegister(_selfInfo.ID,_checkBox.selected,_introductionField.text,AcademyManager.Instance.selfIsRegister);
               AcademyManager.Instance.selfDescribe = _introductionField.text;
               AcademyManager.Instance.isSelfPublishEquip = _checkBox.selected;
               dispose();
               break;
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameEvent);
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
         if(_nicknameField)
         {
            ObjectUtils.disposeObject(_nicknameField);
            _nicknameField = null;
         }
         if(_academyHonorLabel)
         {
            ObjectUtils.disposeObject(_academyHonorLabel);
            _academyHonorLabel = null;
         }
         if(_academyHonorField)
         {
            ObjectUtils.disposeObject(_academyHonorField);
            _academyHonorField = null;
         }
         if(_introductionLabel)
         {
            ObjectUtils.disposeObject(_introductionLabel);
            _introductionLabel = null;
         }
         if(_introductionField)
         {
            _introductionField.removeEventListener("textInput",__limit);
            ObjectUtils.disposeObject(_introductionField);
            _introductionField = null;
         }
         if(_checkBox)
         {
            _checkBox.removeEventListener("click",__checkBoxLabelClick);
            ObjectUtils.disposeObject(_checkBox);
            _checkBox = null;
         }
         if(_checkBoxLabel)
         {
            _checkBoxLabel.removeEventListener("click",__checkBoxLabelClick);
            ObjectUtils.disposeObject(_checkBoxLabel);
            _checkBoxLabel = null;
         }
         super.dispose();
      }
   }
}
