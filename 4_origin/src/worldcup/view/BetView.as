package worldcup.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import worldcup.WorldcupManager;
   import worldcup.view.item.TeamItem;
   import worldcup.view.mornui.BetViewUI;
   
   public class BetView extends BetViewUI
   {
       
      
      public function BetView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         listGroup.renderHandler = new Handler(render);
         betBtn.clickHandler = new Handler(betClickHandler);
         betAgainBtn.clickHandler = new Handler(betAgainclickHandler);
         checkBetState();
         listGroup.refresh();
         WorldcupManager.instance.addEventListener(WorldcupManager.CLEAR_GUESS,__clearGuessHandler);
         WorldcupManager.instance.addEventListener(WorldcupManager.GUESS,__clearGuessHandler);
      }
      
      private function __clearGuessHandler(evt:CEvent) : void
      {
         checkBetState();
         listGroup.refresh();
      }
      
      public function checkBetState() : void
      {
         betBtn.visible = WorldcupManager.instance.model.supportCountry == 0;
         betAgainBtn.visible = !betBtn.visible;
         var _loc1_:* = WorldcupManager.instance.model.state != 2;
         betAgainBtn.disabled = _loc1_;
         betBtn.disabled = _loc1_;
      }
      
      private function betAgainclickHandler() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var needMoney:int = ServerConfigManager.instance.clearWorldcupGuessPrice;
         var _confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.worldcupGuess.clearMsg",needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",function():*
         {
            var /*UnknownSlot*/:* = function(evt:FrameEvent):void
            {
               evt = evt;
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  CheckMoneyUtils.instance.checkMoney(false,needMoney,function():*
                  {
                     var /*UnknownSlot*/:* = function():void
                     {
                        SocketManager.Instance.out.clearWorldPrizeGuess();
                     };
                     return function():void
                     {
                        SocketManager.Instance.out.clearWorldPrizeGuess();
                     };
                  }());
               }
            };
            return function(evt:FrameEvent):void
            {
               evt = evt;
               _confirmFrame.removeEventListener("response",__confirmBuy);
               if(evt.responseCode == 3 || evt.responseCode == 2)
               {
                  CheckMoneyUtils.instance.checkMoney(false,needMoney,function():*
                  {
                     var /*UnknownSlot*/:* = function():void
                     {
                        SocketManager.Instance.out.clearWorldPrizeGuess();
                     };
                     return function():void
                     {
                        SocketManager.Instance.out.clearWorldPrizeGuess();
                     };
                  }());
               }
            };
         }());
      }
      
      private function betClickHandler() : void
      {
         SoundManager.instance.playButtonSound();
         if(WorldcupManager.instance.model.selectCountry == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldcupGuess.selectWrong"));
         }
         else
         {
            SocketManager.Instance.out.chooseWorldcupTeam(WorldcupManager.instance.model.selectCountry);
         }
      }
      
      private function render(item:TeamItem, index:int) : void
      {
         item.team = index + 1;
      }
      
      override public function dispose() : void
      {
         WorldcupManager.instance.removeEventListener(WorldcupManager.CLEAR_GUESS,__clearGuessHandler);
         WorldcupManager.instance.removeEventListener(WorldcupManager.GUESS,__clearGuessHandler);
         super.dispose();
      }
   }
}
