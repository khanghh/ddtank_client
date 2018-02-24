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
      
      public function TeamRankFrame(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
