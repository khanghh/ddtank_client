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
      
      public function ConfirmFrameWithNotShowCheckManager(){super();}
      
      public function set detail(param1:String) : void{}
      
      public function set title(param1:String) : void{}
      
      public function set frameType(param1:String) : void{}
      
      public function set needMoney(param1:int) : void{}
      
      public function set onNotShowAgain(param1:Function) : void{}
      
      public function set isBind(param1:Function) : void{}
      
      public function set onComfirm(param1:Function) : void{}
      
      public function alert() : BaseAlerFrame{return null;}
      
      private function comfirmHandler(param1:FrameEvent) : void{}
      
      private function reConfirmHandler(param1:FrameEvent) : void{}
   }
}
