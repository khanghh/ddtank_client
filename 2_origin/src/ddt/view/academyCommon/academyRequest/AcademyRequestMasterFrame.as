package ddt.view.academyCommon.academyRequest
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.MouseEvent;
   
   public class AcademyRequestMasterFrame extends BaseAlerFrame implements Disposeable
   {
      
      public static const MAX_CHAES:int = 30;
       
      
      protected var _inputText:FilterFrameText;
      
      protected var _explainText:FilterFrameText;
      
      protected var _inputBG:ScaleBitmapImage;
      
      protected var _inputBG2:ScaleBitmapImage;
      
      protected var _alertInfo:AlertInfo;
      
      protected var _playerInfo:BasePlayer;
      
      protected var _isSelection:Boolean = false;
      
      public function AcademyRequestMasterFrame()
      {
         super();
         initContent();
         initEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.title");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.submitLabel");
         _alertInfo.showCancel = false;
         _alertInfo.customPos = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.requireSmallPos");
         info = _alertInfo;
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.inputBg");
         addToContent(_inputBG);
         _inputBG2 = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.inputBg2");
         addToContent(_inputBG2);
         _inputText = ComponentFactory.Instance.creat("academyCommon.academyRequest.inputxt");
         _inputText.maxChars = 30;
         _inputText.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.account");
         addToContent(_inputText);
         _explainText = ComponentFactory.Instance.creat("academyCommon.academyRequestMasterFrame.explainText");
         _explainText.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame.explainText");
         addToContent(_explainText);
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__onResponse);
         if(_inputText)
         {
            _inputText.addEventListener("click",__onInpotClick);
         }
      }
      
      protected function __onInpotClick(param1:MouseEvent) : void
      {
         if(!_isSelection)
         {
            _inputText.setSelection(0,_inputText.text.length);
            _isSelection = true;
         }
         else
         {
            _inputText.setFocus();
            _isSelection = false;
         }
      }
      
      public function setInfo(param1:BasePlayer) : void
      {
         _playerInfo = param1;
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               hide();
               break;
            case 2:
            case 3:
            case 4:
               submit();
         }
      }
      
      protected function submit() : void
      {
         if(_playerInfo.playerState.StateID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.state"));
            hide();
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_inputText.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.inviteInfo1"));
            return;
         }
         SocketManager.Instance.out.sendAcademyApprentice(_playerInfo.ID,_inputText.text);
         hide();
      }
      
      protected function hide() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__onResponse);
         if(_inputText)
         {
            _inputText.removeEventListener("click",__onInpotClick);
            ObjectUtils.disposeObject(_inputText);
            _inputText = null;
         }
         if(_explainText)
         {
            ObjectUtils.disposeObject(_explainText);
            _explainText = null;
         }
         if(_inputBG)
         {
            ObjectUtils.disposeObject(_inputBG);
            _inputBG = null;
         }
         super.dispose();
      }
   }
}
