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
      
      private function __onUpdateSelfActive(param1:TeamEvent) : void
      {
         list_active.array = TeamManager.instance.model.activeList.list;
      }
      
      private function __onRenderActive(param1:Box, param2:int) : void
      {
         var _loc9_:* = null;
         var _loc5_:Number = NaN;
         var _loc7_:Label = param1.getChildByName("label_desc") as Label;
         var _loc8_:Label = param1.getChildByName("label_score") as Label;
         var _loc4_:Label = param1.getChildByName("label_limit") as Label;
         var _loc3_:ProgressBar = param1.getChildByName("progress_active") as ProgressBar;
         var _loc6_:Button = param1.getChildByName("btn_jump") as Button;
         if(param2 < list_active.array.length)
         {
            _loc9_ = list_active.array[param2] as TeamActiveInfo;
            _loc7_.text = _loc9_.ChannelDesc;
            _loc8_.text = LanguageMgr.GetTranslation("team.active.score",_loc9_.AddScore);
            _loc4_.htmlText = LanguageMgr.GetTranslation("team.active.limit",_loc9_.haveScore,_loc9_.MaxLimit);
            _loc3_.value = _loc9_.scoreProgress;
            _loc3_.visible = true;
            if(_loc9_.Type == 1)
            {
               _loc4_.htmlText = "";
               _loc8_.text = LanguageMgr.GetTranslation("team.active.score",_loc9_.haveScore);
               _loc3_.visible = false;
            }
            else if(_loc9_.Type == 2)
            {
               _loc8_.text = LanguageMgr.GetTranslation("team.active.scoreRandom");
            }
            _loc5_ = TimeManager.Instance.NowTime() - PlayerManager.Instance.Self.teamLoginDate.time;
            if(_loc5_ < 86400000)
            {
               _loc6_.disabled = true;
            }
            else
            {
               _loc6_.disabled = false;
            }
         }
         else
         {
            _loc7_.text = "";
            _loc8_.text = "";
            _loc4_.text = "";
            _loc6_.disabled = true;
            _loc3_.visible = false;
         }
      }
      
      private function __onSelectActive(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         if(StateManager.currentStateType != "main")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.outofroom"));
            return;
         }
         switch(int(param1))
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
