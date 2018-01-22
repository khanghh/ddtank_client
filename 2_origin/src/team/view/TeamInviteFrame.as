package team.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import uigeneral.team.TeamInviteView;
   
   public class TeamInviteFrame extends SimpleAlert
   {
      
      private static var _notAlertTeam:DictionaryData = new DictionaryData();
       
      
      private var _teamID:int;
      
      private var _playerID:int;
      
      private var _selectedCheckBtn:SelectedCheckButton;
      
      public function TeamInviteFrame()
      {
         super();
      }
      
      public static function hasAlert(param1:int) : Boolean
      {
         if(_notAlertTeam.hasKey(param1))
         {
            return false;
         }
         return true;
      }
      
      override protected function init() : void
      {
         super.init();
         _selectedCheckBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.simpleAlert.selectedCheckButton");
         _selectedCheckBtn.field.width = 200;
         _selectedCheckBtn.field.height = 44;
         _selectedCheckBtn.field.wordWrap = true;
         _selectedCheckBtn.fieldX = 18;
         _selectedCheckBtn.fieldY = -8;
         _selectedCheckBtn.x = 3;
         _selectedCheckBtn.y = 35;
         _selectedCheckBtn.text = LanguageMgr.GetTranslation("team.invite.notAlert");
         _selectedCheckBtn.addEventListener("click",__onSelectCheckClick);
         addToContent(_selectedCheckBtn);
      }
      
      public function setupData(param1:Object) : void
      {
         _teamID = param1.TeamID;
         _playerID = param1.PlayerID;
         var _loc2_:AlertInfo = new AlertInfo();
         _loc2_.mutiline = false;
         _loc2_.buttonGape = 60;
         _loc2_.autoButtonGape = false;
         _loc2_.autoDispose = true;
         _loc2_.enableHtml = true;
         _loc2_.sound = "008";
         _loc2_.title = LanguageMgr.GetTranslation("team.invite.title");
         _loc2_.data = LanguageMgr.GetTranslation("team.invite.des",param1.UserName,param1.TeamName);
         _loc2_.submitLabel = LanguageMgr.GetTranslation("ok");
         _loc2_.cancelLabel = LanguageMgr.GetTranslation("team.invite.look");
         info = _loc2_;
      }
      
      override protected function onResponse(param1:int) : void
      {
         if(param1 == 4)
         {
            AssetModuleLoader.addModelLoader("uigeneral",1);
            AssetModuleLoader.startLoader(alertTeamInfoFrame);
            return;
         }
         if(param1 == 2 || param1 == 3)
         {
            SocketManager.Instance.out.sendTeamInviteAccept(_playerID,_teamID);
         }
         dispose();
      }
      
      private function alertTeamInfoFrame() : void
      {
         var _loc1_:TeamInviteView = new TeamInviteView();
         _loc1_.update(_playerID,_teamID);
         PositionUtils.setPos(_loc1_,"team.invite.alertPos");
         LayerManager.Instance.addToLayer(_loc1_,1,false,1);
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_selectedCheckBtn.selected)
         {
            _notAlertTeam.add(_teamID,true);
         }
         else
         {
            _notAlertTeam.remove(_teamID);
         }
      }
      
      override public function dispose() : void
      {
         _selectedCheckBtn.removeEventListener("click",__onSelectCheckClick);
         super.dispose();
         _selectedCheckBtn = null;
      }
   }
}
