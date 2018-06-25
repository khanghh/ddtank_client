package team.view.main
{
   import calendar.CalendarManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.ProgressBar;
   import morn.core.handlers.Handler;
   import roomList.pveRoomList.DungeonListController;
   import roomList.pvpRoomList.RoomListController;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamActiveInfo;
   import team.view.mornui.TeamActiveAlertViewUI;
   
   public class TeamActiveAlertView extends TeamActiveAlertViewUI
   {
       
      
      private var _btnHelp:BaseButton;
      
      public function TeamActiveAlertView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         btn_close.clickHandler = new Handler(__onClickClose);
         list_active.renderHandler = new Handler(__onRenderActive);
         list_active.selectHandler = new Handler(__onSelectActive);
         TeamManager.instance.addEventListener("updateselfactive",__onUpdateSelfActive);
         SocketManager.Instance.out.sendTeamGetSelfActive();
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",{
            "x":484,
            "y":4
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.team.activeHelp",408,488);
         label_title.text = LanguageMgr.GetTranslation("ddt.team.allView.text13");
      }
      
      private function __onUpdateSelfActive(e:TeamEvent) : void
      {
         list_active.array = TeamManager.instance.model.activeList.list;
      }
      
      private function __onRenderActive(item:Box, index:int) : void
      {
         var info:* = null;
         var time:Number = NaN;
         var desc:Label = item.getChildByName("label_desc") as Label;
         var score:Label = item.getChildByName("label_score") as Label;
         var limit:Label = item.getChildByName("label_limit") as Label;
         var progress:ProgressBar = item.getChildByName("progress_active") as ProgressBar;
         var btn:Button = item.getChildByName("btn_jump") as Button;
         if(index < list_active.array.length)
         {
            info = list_active.array[index] as TeamActiveInfo;
            desc.text = info.ChannelDesc;
            score.text = LanguageMgr.GetTranslation("team.active.score",info.AddScore);
            limit.htmlText = LanguageMgr.GetTranslation("team.active.limit",info.haveScore,info.MaxLimit);
            progress.value = info.scoreProgress;
            progress.visible = true;
            if(info.Type == 1)
            {
               limit.htmlText = "";
               score.text = LanguageMgr.GetTranslation("team.active.score",info.haveScore);
               progress.visible = false;
            }
            else if(info.Type == 2)
            {
               score.text = LanguageMgr.GetTranslation("team.active.scoreRandom");
            }
            time = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
            if(time < 86400000)
            {
               btn.disabled = true;
            }
            else
            {
               btn.disabled = false;
            }
         }
         else
         {
            desc.text = "";
            score.text = "";
            limit.text = "";
            btn.disabled = true;
            progress.visible = false;
         }
      }
      
      private function __onSelectActive(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(StateManager.currentStateType != "main")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.outofroom"));
            return;
         }
         switch(int(index))
         {
            case 0:
               CalendarManager.getInstance().open(1,true);
               break;
            case 1:
               StateManager.setState("shop");
               break;
            case 2:
               TeamManager.instance.showTeamBattleFrame();
               break;
            case 3:
               StateManager.currentStateType = "dungeon";
               DungeonListController.instance.enter();
               break;
            case 4:
            case 5:
            case 6:
            case 7:
               StateManager.currentStateType = "roomlist";
               RoomListController.instance.enter();
         }
      }
      
      private function __onClickClose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateselfactive",__onUpdateSelfActive);
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
         super.dispose();
      }
   }
}
