package ddt.utils
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.EventDispatcher;
   
   public class CheckMoneyUtils extends EventDispatcher
   {
      
      private static var _instance:CheckMoneyUtils;
       
      
      private var _isBind:Boolean;
      
      private var _needMoney:int;
      
      private var _completeFun:Function;
      
      private var _cancelFun:Function;
      
      public function CheckMoneyUtils()
      {
         super();
      }
      
      public static function get instance() : CheckMoneyUtils
      {
         if(!_instance)
         {
            _instance = new CheckMoneyUtils();
         }
         return _instance;
      }
      
      public function checkMoney(bind:Boolean, needMoney:int, completeFun:Function, cancelFun:Function = null, ifChangeMoney:Boolean = true) : void
      {
         var confirmFrame2:* = null;
         _isBind = bind;
         _needMoney = needMoney;
         _completeFun = completeFun;
         _cancelFun = cancelFun;
         if(_isBind && PlayerManager.Instance.Self.BandMoney < _needMoney)
         {
            if(ifChangeMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
            cancel();
            return;
         }
         if(!_isBind && PlayerManager.Instance.Self.Money < _needMoney)
         {
            LeavePageManager.showFillFrame();
            cancel();
            return;
         }
         complete();
      }
      
      protected function reConfirmHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",reConfirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.Money < _needMoney)
            {
               LeavePageManager.showFillFrame();
               cancel();
               return;
            }
            _isBind = false;
            complete();
            return;
         }
         cancel();
      }
      
      private function complete() : void
      {
      }
      
      private function cancel() : void
      {
         if(_cancelFun != null)
         {
            _cancelFun();
         }
      }
      
      public function get isBind() : Boolean
      {
         return _isBind;
      }
   }
}
