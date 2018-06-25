package team.view.main
{
   import baglocked.BaglockedManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamCaptainTransferViewUI;
   
   public class TeamCaptainTransferView extends TeamCaptainTransferViewUI
   {
       
      
      private var _nameList:Array;
      
      private var _idList:Array;
      
      public function TeamCaptainTransferView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text1.text = LanguageMgr.GetTranslation("ddt.team.mainView.text1");
         text2.text = LanguageMgr.GetTranslation("ddt.team.mainView.text2");
         text3.text = LanguageMgr.GetTranslation("ddt.team.mainView.text3");
         btn_confirm.label = LanguageMgr.GetTranslation("ok");
         btn_confirm.clickHandler = new Handler(__onClickConfirm);
         btn_cancel.label = LanguageMgr.GetTranslation("cancel");
         btn_cancel.clickHandler = new Handler(__onClickClose);
         btn_esc.clickHandler = new Handler(__onClickClose);
         analyzeList();
         comboBox_selectName.visibleNum = _nameList.length;
         comboBox_selectName.labels = String(_nameList);
      }
      
      private function analyzeList() : void
      {
         var i:int = 0;
         var info:* = null;
         _nameList = [];
         _idList = [];
         var array:Array = TeamManager.instance.model.selfTeamMember;
         for(i = 0; i < array.length; )
         {
            info = array[i] as TeamMemberInfo;
            if(!info.isSelf)
            {
               _nameList.push(info.NickName);
               _idList.push(info.ID);
            }
            i++;
         }
      }
      
      private function __onClickConfirm() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_idList.length <= comboBox_selectName.selectedIndex || comboBox_selectName.selectedIndex < 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("team.main.captainTransferTips"));
            return;
         }
         SocketManager.Instance.out.sendTeamCaptainTransfer(_idList[comboBox_selectName.selectedIndex]);
         dispose();
      }
      
      private function __onClickClose() : void
      {
         SoundManager.instance.playButtonSound();
         _idList = null;
         _nameList = null;
         dispose();
      }
   }
}
