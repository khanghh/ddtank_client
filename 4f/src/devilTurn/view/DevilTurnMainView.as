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
      
      public function DevilTurnMainView(){super();}
      
      override protected function initialize() : void{}
      
      private function onClickCose() : void{}
      
      private function selectChange(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
