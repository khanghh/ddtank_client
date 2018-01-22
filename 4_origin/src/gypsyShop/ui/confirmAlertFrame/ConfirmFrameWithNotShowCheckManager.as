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
      
      public function set detail(param1:String) : void
      {
         _detail = param1;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function set frameType(param1:String) : void
      {
         _frameType = param1;
      }
      
      public function set needMoney(param1:int) : void
      {
         _needMoney = param1;
      }
      
      public function set onNotShowAgain(param1:Function) : void
      {
         _onNotShowAgain = param1;
      }
      
      public function set isBind(param1:Function) : void
      {
         _isBind = param1;
      }
      
      public function set onComfirm(param1:Function) : void
      {
         _onComfirm = param1;
      }
      
      public function alert() : BaseAlerFrame
      {
         var _loc1_:ConfirmWithNotShowCheckAlert = AlertManager.Instance.simpleAlert(_title,_detail,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,_frameType,30,true,1) as ConfirmWithNotShowCheckAlert;
         _loc1_.moveEnable = false;
         _loc1_.addEventListener("response",comfirmHandler,false,0,true);
         return _loc1_;
      }
      
      private function comfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:ConfirmWithNotShowCheckAlert = param1.currentTarget as ConfirmWithNotShowCheckAlert;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_loc3_.isBand && PlayerManager.Instance.Self.BandMoney < _needMoney)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",reConfirmHandler,false,0,true);
            }
            else if(!_loc3_.isBand && PlayerManager.Instance.Self.Money < _needMoney)
            {
               _onNotShowAgain != null && _onNotShowAgain(false);
               LeavePageManager.showFillFrame();
            }
            else
            {
               if(_loc3_.isNoPrompt)
               {
                  _onNotShowAgain != null && _onNotShowAgain(true);
               }
               _isBind != null && _isBind(_loc3_.isBand);
               _onComfirm != null && _onComfirm();
            }
         }
         _loc3_.removeEventListener("response",comfirmHandler);
         ObjectUtils.disposeObject(_loc3_);
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _onNotShowAgain != null && _onNotShowAgain(false);
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
