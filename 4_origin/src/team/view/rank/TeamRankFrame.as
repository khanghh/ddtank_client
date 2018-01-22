package team.view.rank
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   
   public class TeamRankFrame extends Frame
   {
       
      
      private var _view:TeamRankView;
      
      private var _btnHelp:BaseButton;
      
      public function TeamRankFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         _view = new TeamRankView();
         super.init();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":747,
            "y":-38
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.team.rankHelp",408,488);
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
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         super.dispose();
      }
   }
}
