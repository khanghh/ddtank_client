package gypsyShop.ui.confirmAlertFrame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   
   public class ConfirmFrameHonourWithNotShowCheckManager
   {
       
      
      private var _confirmFrame:ConfirmWithNotShowCheckAlert;
      
      private var _frameType:String;
      
      private var _needMoney:int;
      
      private var _title:String = "";
      
      private var _detail:String = "";
      
      private var _onNotShowAgain:Function;
      
      private var _isBind:Function;
      
      private var _onComfirm:Function;
      
      public function ConfirmFrameHonourWithNotShowCheckManager(){super();}
      
      protected static function showFillFrame() : BaseAlerFrame{return null;}
      
      private static function __onResponse(param1:FrameEvent) : void{}
      
      public function set detail(param1:String) : void{}
      
      public function set title(param1:String) : void{}
      
      public function set frameType(param1:String) : void{}
      
      public function set needMoney(param1:int) : void{}
      
      public function set onNotShowAgain(param1:Function) : void{}
      
      public function set isBind(param1:Function) : void{}
      
      public function set onComfirm(param1:Function) : void{}
      
      public function alert() : ConfirmFrameHonourWithNotShowCheckAlert{return null;}
      
      private function comfirmHandler(param1:FrameEvent) : void{}
   }
}
