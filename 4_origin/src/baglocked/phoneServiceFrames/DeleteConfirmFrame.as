package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class DeleteConfirmFrame extends Frame
   {
      
      public static const MSN_MONEY:int = 50;
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:ScaleBitmapImage;
      
      private var _description:FilterFrameText;
      
      private var _phoneNum:FilterFrameText;
      
      private var _confirmTxt:FilterFrameText;
      
      private var _confirmInput:TextInput;
      
      private var _getConfirmBtn:TextButton;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function DeleteConfirmFrame()
      {
         super();
      }
      
      public function init2(value:int) : void
      {
         type = value;
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.appeal");
         _BG = ComponentFactory.Instance.creatComponentByStylename("baglocked.deleteQuestionBG");
         addToContent(_BG);
         _description = ComponentFactory.Instance.creatComponentByStylename("baglocked.lightRedTxt");
         PositionUtils.setPos(_description,"bagLocked.deleteDescPos");
         _description.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deleteDesc3");
         addToContent(_description);
         var num:String = BagLockedController.Instance.phoneNum;
         _phoneNum = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_phoneNum,"bagLocked.phoneNumPos2");
         _phoneNum.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.formerNum",num.substr(0,3),num.substr(6));
         addToContent(_phoneNum);
         _confirmTxt = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_confirmTxt,"bagLocked.confirmTxtPos2");
         _confirmTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.confirmNum");
         addToContent(_confirmTxt);
         _confirmInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.confirmTextInput");
         PositionUtils.setPos(_confirmInput,"bagLocked.confirmInputPos");
         _confirmInput.textField.restrict = "0-9";
         addToContent(_confirmInput);
         _getConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.getConfirmNum");
         _getConfirmBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.getConfirmNum");
         PositionUtils.setPos(_getConfirmBtn,"bagLocked.getConfirmBtnPos");
         addToContent(_getConfirmBtn);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip2");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos3");
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos5");
         addToContent(_nextBtn);
         switch(int(type))
         {
            case 0:
               _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deleteQuestion");
               break;
            case 1:
               _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deletePwd");
         }
         addEvent();
      }
      
      protected function __nextBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_confirmInput.text.length != 6)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.msnLengthWrong"));
            return;
         }
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.deletePwdQuestion(3,_confirmInput.text);
               break;
            case 1:
               SocketManager.Instance.out.deletePwdByPhone(3,_confirmInput.text);
         }
      }
      
      protected function __getConfirmBtnClick(event:MouseEvent) : void
      {
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.bagII.baglocked.confirmNeedMoney"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         alertAsk.addEventListener("response",__alertGetConfirmNum);
      }
      
      protected function __alertGetConfirmNum(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertGetConfirmNum);
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.Money < 50)
               {
                  frame.dispose();
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  alertFrame.addEventListener("response",_response);
                  return;
               }
               getConfirmMsn();
               break;
         }
         frame.dispose();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function getConfirmMsn() : void
      {
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.deletePwdQuestion(2);
               break;
            case 1:
               SocketManager.Instance.out.deletePwdByPhone(2);
         }
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(value:BagLockedController) : void
      {
         _bagLockedController = value;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _nextBtn.addEventListener("click",__nextBtnClick);
         _getConfirmBtn.addEventListener("click",__getConfirmBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         _getConfirmBtn.removeEventListener("click",__getConfirmBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_description)
         {
            ObjectUtils.disposeObject(_description);
         }
         _description = null;
         if(_phoneNum)
         {
            ObjectUtils.disposeObject(_phoneNum);
         }
         _phoneNum = null;
         if(_confirmTxt)
         {
            ObjectUtils.disposeObject(_confirmTxt);
         }
         _confirmTxt = null;
         if(_confirmInput)
         {
            ObjectUtils.disposeObject(_confirmInput);
         }
         _confirmInput = null;
         if(_getConfirmBtn)
         {
            ObjectUtils.disposeObject(_getConfirmBtn);
         }
         _getConfirmBtn = null;
         if(_tips)
         {
            ObjectUtils.disposeObject(_tips);
         }
         _tips = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         super.dispose();
      }
   }
}
