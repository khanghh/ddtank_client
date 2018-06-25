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
      
      public static function hasAlert(teamID:int) : Boolean
      {
         if(_notAlertTeam.hasKey(teamID))
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
      
      public function setupData(data:Object) : void
      {
         _teamID = data.TeamID;
         _playerID = data.PlayerID;
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.mutiline = false;
         alertInfo.buttonGape = 60;
         alertInfo.autoButtonGape = false;
         alertInfo.autoDispose = true;
         alertInfo.enableHtml = true;
         alertInfo.sound = "008";
         alertInfo.title = LanguageMgr.GetTranslation("team.invite.title");
         alertInfo.data = LanguageMgr.GetTranslation("team.invite.des",data.UserName,data.TeamName);
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ok");
         alertInfo.cancelLabel = LanguageMgr.GetTranslation("team.invite.look");
         info = alertInfo;
      }
      
      override protected function onResponse(type:int) : void
      {
         if(type == 4)
         {
            AssetModuleLoader.addModelLoader("uigeneral",1);
            AssetModuleLoader.startLoader(alertTeamInfoFrame);
            return;
         }
         if(type == 2 || type == 3)
         {
            SocketManager.Instance.out.sendTeamInviteAccept(_playerID,_teamID);
         }
         dispose();
      }
      
      private function alertTeamInfoFrame() : void
      {
         var view:TeamInviteView = new TeamInviteView();
         view.update(_playerID,_teamID);
         PositionUtils.setPos(view,"team.invite.alertPos");
         LayerManager.Instance.addToLayer(view,1,false,1);
      }
      
      protected function __onSelectCheckClick(e:MouseEvent) : void
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
