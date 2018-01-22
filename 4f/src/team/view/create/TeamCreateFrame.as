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
      
      public function TeamCreateFrame(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      private function __onCreateComplete(param1:TeamEvent) : void{}
      
      override public function dispose() : void{}
   }
}
