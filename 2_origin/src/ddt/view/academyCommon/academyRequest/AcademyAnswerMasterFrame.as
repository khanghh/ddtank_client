package ddt.view.academyCommon.academyRequest
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   
   public class AcademyAnswerMasterFrame extends AcademyRequestMasterFrame implements Disposeable
   {
      
      public static const BINGIN_INDEX:int = 3;
       
      
      protected var _messageText:FilterFrameText;
      
      protected var _uid:int;
      
      protected var _name:String;
      
      protected var _message:String;
      
      protected var _nameLabel:TextFormat;
      
      protected var _lookBtn:TextButton;
      
      protected var _cancelBtn:TextButton;
      
      protected var _unAcceptBtn:SelectedCheckButton;
      
      public function AcademyAnswerMasterFrame()
      {
         super();
      }
      
      override public function show() : void
      {
         SoundManager.instance.play("008");
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override protected function initContent() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame.title");
         var _loc3_:* = false;
         this.enterEnable = _loc3_;
         _loc3_ = _loc3_;
         _alertInfo.enterEnable = _loc3_;
         _loc3_ = _loc3_;
         _alertInfo.showSubmit = _loc3_;
         _alertInfo.showCancel = _loc3_;
         info = _alertInfo;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("AcademyAnswerMasterFrame.inputPos1");
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("AcademyAnswerMasterFrame.inputPos2");
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.inputBg2");
         addToContent(_inputBG);
         _inputBG.x = _loc1_.x;
         _inputBG.y = _loc1_.y;
         _messageText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.MessageText");
         addToContent(_messageText);
         _messageText.x = _loc2_.x;
         _messageText.y = _loc2_.y;
         _explainText = ComponentFactory.Instance.creat("academyCommon.academyAnswerMasterFrame.explainText");
         addToContent(_explainText);
         _nameLabel = ComponentFactory.Instance.model.getSet("academyCommon.academyRequest.explainNameTextTF");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyAnswerApprenticeFrame.LookButton");
         _lookBtn.text = LanguageMgr.GetTranslation("civil.leftview.equipName");
         addToContent(_lookBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRequestApprenticeFrame.submitButton");
         _cancelBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame.submitLabel");
         addToContent(_cancelBtn);
         _unAcceptBtn = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyAnswerApprenticeFrame.selectBtn");
         addToContent(_unAcceptBtn);
         _unAcceptBtn.text = LanguageMgr.GetTranslation("ddt.farms.refreshPetsNOAlert");
      }
      
      override protected function initEvent() : void
      {
         addEventListener("response",__onResponse);
         _lookBtn.addEventListener("click",__onLookBtnClick);
         _cancelBtn.addEventListener("click",__onCancelBtnClick);
         _unAcceptBtn.addEventListener("select",notAcceptAnswer);
      }
      
      protected function notAcceptAnswer(param1:Event) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:PlayerInfo = PlayerManager.Instance.findPlayer(_uid,PlayerManager.Instance.Self.ZoneID);
         if(_unAcceptBtn.selected)
         {
            if(SharedManager.Instance.unAcceptAnswer.indexOf(_loc3_.ID) < 0)
            {
               SharedManager.Instance.unAcceptAnswer.push(_loc3_.ID);
            }
         }
         else
         {
            _loc2_ = SharedManager.Instance.unAcceptAnswer.indexOf(_loc3_.ID);
            SharedManager.Instance.unAcceptAnswer.splice(_loc2_,1);
         }
      }
      
      protected function __onCancelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         submit();
      }
      
      protected function __onLookBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         lookUpEquip();
      }
      
      override protected function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               hide();
               break;
            default:
               hide();
               break;
            case 3:
               lookUpEquip();
               break;
            case 4:
               submit();
         }
      }
      
      public function setMessage(param1:int, param2:String, param3:String) : void
      {
         _uid = param1;
         _name = param2;
         _message = param3;
         update();
      }
      
      protected function update() : void
      {
         _messageText.htmlText = _message;
         _explainText.htmlText = LanguageMgr.GetTranslation("ddt.view.academyCommon.academyRequest.AcademyAnswerMasterFrame.AnswerMaster",_name);
      }
      
      protected function lookUpEquip() : void
      {
         PlayerInfoViewControl.viewByID(_uid,PlayerManager.Instance.Self.ZoneID);
      }
      
      override protected function submit() : void
      {
         SocketManager.Instance.out.sendAcademyMasterConfirm(true,_uid);
         dispose();
      }
      
      override protected function hide() : void
      {
         SocketManager.Instance.out.sendAcademyMasterConfirm(false,_uid);
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_unAcceptBtn)
         {
            ObjectUtils.disposeObject(_unAcceptBtn);
            _unAcceptBtn = null;
         }
         if(_messageText)
         {
            ObjectUtils.disposeObject(_messageText);
            _messageText = null;
         }
         if(_lookBtn)
         {
            _lookBtn.removeEventListener("click",__onLookBtnClick);
            ObjectUtils.disposeObject(_lookBtn);
            _lookBtn = null;
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__onCancelBtnClick);
            ObjectUtils.disposeObject(_cancelBtn);
            _lookBtn = null;
         }
         _nameLabel = null;
         super.dispose();
      }
   }
}
