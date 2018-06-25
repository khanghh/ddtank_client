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
      
      public function ConfirmFrameHonourWithNotShowCheckManager()
      {
         super();
      }
      
      protected static function showFillFrame() : BaseAlerFrame
      {
         var frame:* = null;
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("gypsy.honourNotEnough"),LanguageMgr.GetTranslation("ok"),"",true,false,false,2);
         frame.addEventListener("response",__onResponse);
         return frame;
      }
      
      private static function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
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
      
      public function alert() : ConfirmFrameHonourWithNotShowCheckAlert
      {
         if(PlayerManager.Instance.Self.myHonor < _needMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gypsy.honourNotEnough"),0,true,3);
            return null;
         }
         var confirmFrame:ConfirmFrameHonourWithNotShowCheckAlert = ComponentFactory.Instance.creat("gypsy.confirmViewHonour");
         confirmFrame.titleTxt = LanguageMgr.GetTranslation("AlertDialog.Info");
         confirmFrame.detail = LanguageMgr.GetTranslation("tank.game.GameView.gypsyHonourConfirm",_needMoney);
         confirmFrame.onNotShowAgain = _onNotShowAgain;
         confirmFrame.onComfirm = _onComfirm;
         confirmFrame.initView();
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
         LayerManager.Instance.addToLayer(confirmFrame,1,true,1);
         return confirmFrame;
      }
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:ConfirmFrameHonourWithNotShowCheckAlert = event.currentTarget as ConfirmFrameHonourWithNotShowCheckAlert;
         confirmFrame.removeEventListener("response",comfirmHandler);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.myHonor < _needMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("gypsy.honourNotEnough"),0,true,3);
            }
            else
            {
               _onComfirm != null && _onComfirm();
            }
            if(confirmFrame.isNoPrompt)
            {
               _onNotShowAgain != null && _onNotShowAgain(true);
            }
         }
      }
   }
}
