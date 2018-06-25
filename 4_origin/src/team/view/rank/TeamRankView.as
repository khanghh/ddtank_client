package team.view.rank
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import morn.core.components.Component;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamRankInfo;
   import team.view.mornui.Rank.TeamRankViewUI;
   
   public class TeamRankView extends TeamRankViewUI
   {
       
      
      private var _serverIndex:int;
      
      private var _gradeIndex:int;
      
      private var _index:int;
      
      public function TeamRankView()
      {
         super();
         updateRankList();
         addEvent();
      }
      
      private function addEvent() : void
      {
         btn_theServer.addEventListener("click",__selectedServer);
         btn_crossServer.addEventListener("click",__selectedServer);
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text9");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text10");
         teamText3.text = LanguageMgr.GetTranslation("ddt.team.allView.text11");
         teamText4.text = LanguageMgr.GetTranslation("ddt.team.allView.text12");
         teamText5.text = LanguageMgr.GetTranslation("ddt.team.allView.text6");
         teamText6.text = LanguageMgr.GetTranslation("ddt.team.allView.text4");
         teamText7.text = LanguageMgr.GetTranslation("ddt.team.allView.text5");
         teamText8.text = LanguageMgr.GetTranslation("ddt.team.allView.text7");
         teamText9.text = LanguageMgr.GetTranslation("ddt.team.allView.text8");
      }
      
      protected function __selectedServer(event:Event) : void
      {
         var currentRank:* = null;
         SoundManager.instance.playButtonSound();
         if(event.target == btn_theServer)
         {
            currentRank = TeamManager.instance.model.rankList[0][_gradeIndex];
            if(!currentRank || currentRank.length <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.noServerTeamRank"));
               btn_theServer.selected = false;
               btn_crossServer.selected = true;
               return;
            }
            btn_theServer.selected = true;
            btn_crossServer.selected = false;
            if(_serverIndex == 0)
            {
               return;
            }
            _serverIndex = 0;
         }
         else if(event.target == btn_crossServer)
         {
            btn_theServer.selected = false;
            btn_crossServer.selected = true;
            if(_serverIndex == 1)
            {
               return;
            }
            _serverIndex = 1;
         }
         updateRankList();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(PlayerManager.Instance.Self.teamDivision > 0)
         {
            _gradeIndex = PlayerManager.Instance.Self.teamDivision - 1;
         }
         var currentRank:Array = TeamManager.instance.model.rankList[0][_gradeIndex];
         if(!currentRank || currentRank.length <= 0)
         {
            _gradeIndex = 0;
         }
         list_rank.renderHandler = new Handler(__listRankRender);
         list_rank.selectHandler = new Handler(__listRankSelectRander);
         list_left.renderHandler = new Handler(__listLeftRender);
         list_left.selectHandler = new Handler(__listLeftSelectRander);
         list_left.array = [0,1,2,3,4];
         list_left.selectedIndex = _gradeIndex;
         updateSlefRank();
      }
      
      private function __listRankSelectRander(index:int) : void
      {
         var item:* = null;
         var curreItem:* = null;
         if(index < list_rank.array.length)
         {
            if(_index <= list_rank.startIndex + list_rank.repeatY && _index >= list_rank.startIndex)
            {
               item = list_rank.getCell(_index) as TeamRankItem;
               item.isClick = false;
            }
            if(index <= list_rank.startIndex + list_rank.repeatY && index >= list_rank.startIndex)
            {
               curreItem = list_rank.getCell(index) as TeamRankItem;
               curreItem.isClick = true;
            }
            if(_index == index)
            {
               return;
            }
            SoundManager.instance.playButtonSound();
            _index = index;
            updateTeaminfo(_index);
         }
      }
      
      private function updateTeaminfo(index:int) : void
      {
         teamInfoBox.updateInfo(list_rank.array[index]);
         teamInfoBox.enabled = _serverIndex == 1?false:true;
      }
      
      private function __listLeftSelectRander(index:int) : void
      {
         var item:TeamRankLeftItem = list_left.getCell(_gradeIndex) as TeamRankLeftItem;
         var curreItem:TeamRankLeftItem = list_left.getCell(index) as TeamRankLeftItem;
         SoundManager.instance.playButtonSound();
         var currentRank:Array = TeamManager.instance.model.rankList[_serverIndex][index];
         if(!currentRank || currentRank.length <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.noTeamRank"));
            return;
         }
         _gradeIndex = index;
         item.isClick = false;
         curreItem.isClick = true;
         updateRankList();
         updateSlefRank();
      }
      
      private function __listLeftRender(item:Component, index:int) : void
      {
         var render:* = null;
         if(index < list_left.length)
         {
            render = item as TeamRankLeftItem;
            render.index = index;
         }
      }
      
      private function __listRankRender(item:Component, index:int) : void
      {
         var render:TeamRankItem = item as TeamRankItem;
         if(index < list_rank.length)
         {
            if(index == _index)
            {
               render.isClick = true;
            }
            else
            {
               render.isClick = false;
            }
            render.index = index + 1;
            render.updaInfo(list_rank.array[index]);
         }
         else
         {
            render.isShow = false;
            render.isClick = false;
         }
      }
      
      private function updateRankList() : void
      {
         list_rank.array = TeamManager.instance.model.rankList[_serverIndex][_gradeIndex];
         list_rank.refresh();
         list_rank.selectedIndex = 0;
         updateTeaminfo(0);
      }
      
      private function updateSlefRank() : void
      {
         var info:* = null;
         var i:int = 0;
         var j:int = 0;
         label_currentRank.text = LanguageMgr.GetTranslation("tank.team.no");
         label_totolRank.text = LanguageMgr.GetTranslation("tank.team.no");
         var list1:Array = TeamManager.instance.model.rankList[0][_gradeIndex];
         var list2:Array = TeamManager.instance.model.rankList[1][_gradeIndex];
         if(list1 != null)
         {
            for(i = 0; i < list1.length; )
            {
               info = list1[i] as TeamRankInfo;
               if(info.TeamID == PlayerManager.Instance.Self.teamID)
               {
                  label_currentRank.text = String(i + 1);
                  break;
               }
               i++;
            }
         }
         if(list2 != null)
         {
            for(j = 0; j < list2.length; )
            {
               info = list2[j] as TeamRankInfo;
               if(info.TeamID == PlayerManager.Instance.Self.teamID && info.FromAreaName == TeamManager.instance.model.currentAreaName)
               {
                  label_totolRank.text = String(j + 1);
                  break;
               }
               j++;
            }
         }
      }
      
      private function removeEvent() : void
      {
         btn_theServer.removeEventListener("click",__selectedServer);
         btn_crossServer.removeEventListener("click",__selectedServer);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}
