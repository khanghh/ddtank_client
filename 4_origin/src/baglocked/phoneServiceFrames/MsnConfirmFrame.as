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
   
   public class MsnConfirmFrame extends Frame
   {
      
      public static const MSN_MONEY:int = 50;
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _phoneNum:FilterFrameText;
      
      private var _confirmTxt:FilterFrameText;
      
      private var _confirmInput:TextInput;
      
      private var _getConfirmBtn:TextButton;
      
      private var _tips:FilterFrameText;
      
      private var _nextBtn:TextButton;
      
      private var type:int;
      
      public function MsnConfirmFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         type = param1;
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.changePhoneTxt");
         _phoneNum = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_phoneNum,"bagLocked.phoneNumPos");
         addToContent(_phoneNum);
         _confirmTxt = ComponentFactory.Instance.creatComponentByStylename("baglocked.whiteTxt");
         PositionUtils.setPos(_confirmTxt,"bagLocked.confirmTxtPos");
         _confirmTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.confirmNum");
         addToContent(_confirmTxt);
         _confirmInput = ComponentFactory.Instance.creatComponentByStylename("baglocked.confirmTextInput");
         _confirmInput.textField.restrict = "0-9";
         addToContent(_confirmInput);
         _getConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("baglocked.getConfirmNum");
         _getConfirmBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.getConfirmNum");
         addToContent(_getConfirmBtn);
         _tips = ComponentFactory.Instance.creatComponentByStylename("baglocked.deepRedTxt");
         PositionUtils.setPos(_tips,"bagLocked.phoneTipPos");
         addToContent(_tips);
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos2");
         addToContent(_nextBtn);
         var _loc2_:String = BagLockedController.Instance.phoneNum;
         switch(int(type))
         {
            case 0:
               _phoneNum.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.formerNum",_loc2_.substr(0,3),_loc2_.substr(6));
               _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip2");
               _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
               break;
            case 1:
            case 2:
               _phoneNum.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.bindedNum",_loc2_.substr(0,3),_loc2_.substr(6));
               _tips.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tip4");
               _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.complete");
         }
         addEvent();
      }
      
      protected function __getConfirmBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(type))
         {
            case 0:
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.view.bagII.baglocked.confirmNeedMoney"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc2_.addEventListener("response",__alertGetConfirmNum);
               break;
            case 1:
            case 2:
               getConfirmMsn();
         }
      }
      
      protected function __alertGetConfirmNum(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__alertGetConfirmNum);
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.Money < 50)
               {
                  _loc3_.dispose();
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  return;
               }
               getConfirmMsn();
               break;
         }
         _loc3_.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function getConfirmMsn() : void
      {
         switch(int(type))
         {
            case 0:
               SocketManager.Instance.out.getBackLockPwdByPhone(2);
               break;
            case 1:
               SocketManager.Instance.out.getBackLockPwdByPhone(5);
               break;
            case 2:
               SocketManager.Instance.out.getBackLockPwdByQuestion(3);
         }
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
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
               SocketManager.Instance.out.getBackLockPwdByPhone(3,_confirmInput.text);
               break;
            case 1:
               SocketManager.Instance.out.getBackLockPwdByPhone(6,_confirmInput.text);
               break;
            case 2:
               SocketManager.Instance.out.getBackLockPwdByQuestion(4,_confirmInput.text);
         }
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _getConfirmBtn.addEventListener("click",__getConfirmBtnClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _getConfirmBtn.removeEventListener("click",__getConfirmBtnClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
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
