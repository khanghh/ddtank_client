package team.view.create
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import team.TeamManager;
   import team.event.TeamEvent;
   
   public class TeamCreateFrame extends Frame
   {
       
      
      private var _btnHelp:BaseButton;
      
      private var _view:TeamCreateView;
      
      public function TeamCreateFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         _view = new TeamCreateView();
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":761,
            "y":-38
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.teamcreate.hp",408,450);
         TeamManager.instance.addEventListener("updateteaminfo",__onCreateComplete);
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_view)
         {
            addToContent(_view);
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(param1 == 0 || param1 == 4 || param1 == 1)
         {
            SoundManager.instance.playButtonSound();
            dispose();
         }
      }
      
      private function __onCreateComplete(param1:TeamEvent) : void
      {
         dispose();
         TeamManager.instance.showTeamMainFrame();
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteaminfo",__onCreateComplete);
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         super.dispose();
      }
   }
}
