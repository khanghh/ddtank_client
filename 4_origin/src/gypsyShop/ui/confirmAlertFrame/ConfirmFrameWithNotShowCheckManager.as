package gypsyShop.ui.confirmAlertFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import gypsyShop.model.GypsyPurchaseModel;
   
   public class ConfirmFrameWithNotShowCheckManager
   {
       
      
      private var _confirmFrame:ConfirmWithNotShowCheckAlert;
      
      private var _frameType:String;
      
      private var _needMoney:int;
      
      private var _title:String = "";
      
      private var _detail:String = "";
      
      private var _onNotShowAgain:Function;
      
      private var _isBind:Function;
      
      private var _onComfirm:Function;
      
      public function ConfirmFrameWithNotShowCheckManager()
      {
         super();
      }
      
      public function set detail(value:String) : void
      {
         _detail = value;
      }
      
      public function set title(value:String) : void
      {
         _title = value;
      }
      
      public function set frameType(value:String) : void
      {
         _frameType = value;
      }
      
      public function set needMoney(value:int) : void
      {
         _needMoney = value;
      }
      
      public function set onNotShowAgain(value:Function) : void
      {
         _onNotShowAgain = value;
      }
      
      public function set isBind(value:Function) : void
      {
         _isBind = value;
      }
      
      public function set onComfirm(value:Function) : void
      {
         _onComfirm = value;
      }
      
      public function alert() : BaseAlerFrame
      {
         var confirmFrame:ConfirmWithNotShowCheckAlert = AlertManager.Instance.simpleAlert(_title,_detail,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,_frameType,30,true,1) as ConfirmWithNotShowCheckAlert;
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
         return confirmFrame;
      }
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         var confirmFrame2:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:ConfirmWithNotShowCheckAlert = event.currentTarget as ConfirmWithNotShowCheckAlert;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < _needMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
            }
            else if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < _needMoney)
            {
               _onNotShowAgain != null && _onNotShowAgain(false);
               LeavePageManager.showFillFrame();
            }
            else
            {
               if(confirmFrame.isNoPrompt)
               {
                  _onNotShowAgain != null && _onNotShowAgain(true);
               }
               _isBind != null && _isBind(confirmFrame.isBand);
               _onComfirm != null && _onComfirm();
            }
         }
         confirmFrame.removeEventListener("response",comfirmHandler);
         ObjectUtils.disposeObject(confirmFrame);
      }
      
      private function reConfirmHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _onNotShowAgain != null && _onNotShowAgain(false);
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",reConfirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < _needMoney)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            GypsyPurchaseModel.getInstance().updateIsUseBindRmbTicket(false);
            _onComfirm != null && _onComfirm();
         }
      }
   }
}
