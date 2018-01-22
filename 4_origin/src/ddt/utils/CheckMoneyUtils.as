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
      
      public function checkMoney(param1:Boolean, param2:int, param3:Function, param4:Function = null, param5:Boolean = true) : void
      {
         var _loc6_:* = null;
         _isBind = param1;
         _needMoney = param2;
         _completeFun = param3;
         _cancelFun = param4;
         if(_isBind && PlayerManager.Instance.Self.BandMoney < _needMoney)
         {
            if(param5)
            {
               _loc6_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc6_.moveEnable = false;
               _loc6_.addEventListener("response",reConfirmHandler,false,0,true);
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
      
      protected function reConfirmHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
