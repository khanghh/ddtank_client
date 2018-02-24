package devilTurn.view
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.view.mornui.DevilTurnMainViewUI;
   import morn.core.handlers.Handler;
   
   public class DevilTurnMainView extends DevilTurnMainViewUI
   {
       
      
      private var _helpButton:BaseButton;
      
      public function DevilTurnMainView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         viewTab.selectHandler = new Handler(selectChange);
         viewTab.selectedIndex = 0;
         closeBtn.clickHandler = new Handler(onClickCose);
         DevilTurnManager.instance.initEvent();
         _helpButton = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":775,
            "y":9
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.deviturn.helpView",470,585);
      }
      
      private function onClickCose() : void
      {
         SoundManager.instance.playButtonSound();
         if(treasureView.isRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.lotteryRunning"));
            return;
         }
         dispose();
      }
      
      private function selectChange(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1 == 0)
         {
            treasureView.visible = true;
            mallView.visible = false;
         }
         else
         {
            treasureView.visible = false;
            mallView.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         if(_helpButton)
         {
            ObjectUtils.disposeObject(_helpButton);
         }
         _helpButton = null;
         DevilTurnManager.instance.removeEvent();
         super.dispose();
      }
   }
}
