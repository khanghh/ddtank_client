package team.view.main
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import team.view.mornui.TeamQuitViewUI;
   
   public class TeamQuitView extends TeamQuitViewUI
   {
       
      
      public function TeamQuitView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_esc.clickHandler = new Handler(__onClickEsc);
         btn_cancel.clickHandler = new Handler(__onClickEsc);
         btn_cancel.label = LanguageMgr.GetTranslation("ddt.team.allView.text24");
         btn_confirm.clickHandler = new Handler(__onClickConfirm);
         btn_confirm.label = LanguageMgr.GetTranslation("ddt.team.allView.text31");
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text40");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text46");
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text45");
      }
      
      protected function __onClickConfirm() : void
      {
         SoundManager.instance.playButtonSound();
         if(input_quit.text.toLowerCase() == "quit")
         {
            SocketManager.Instance.out.sendTeamExit();
            dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("team.main.quitTip"));
         }
      }
      
      protected function __onClickEsc() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
   }
}
