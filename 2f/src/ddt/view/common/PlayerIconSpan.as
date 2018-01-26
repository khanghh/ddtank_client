package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.player.BasePlayer;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.view.academyCommon.academyIcon.AcademyIcon;
   import flash.utils.getDefinitionByName;
   
   public class PlayerIconSpan extends VBox
   {
       
      
      private var _info:BasePlayer;
      
      private var _levelIcon:LevelIcon;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _marriedIcon:MarriedIcon;
      
      private var _academyIcon:AcademyIcon;
      
      public function PlayerIconSpan(param1:BasePlayer){super();}
      
      override protected function init() : void{}
      
      private function getShowAcademyIcon() : Boolean{return false;}
   }
}
