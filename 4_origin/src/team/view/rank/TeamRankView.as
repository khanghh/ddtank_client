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
      
      protected function __selectedServer(param1:Event) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(param1.target == btn_theServer)
         {
            _loc2_ = TeamManager.instance.model.rankList[0][_gradeIndex];
            if(!_loc2_ || _loc2_.length <= 0)
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
         else if(param1.target == btn_crossServer)
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
         var _loc1_:Array = TeamManager.instance.model.rankList[0][_gradeIndex];
         if(!_loc1_ || _loc1_.length <= 0)
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
      
      private function __listRankSelectRander(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1 < list_rank.array.length)
         {
            if(_index <= list_rank.startIndex + list_rank.repeatY && _index >= list_rank.startIndex)
            {
               _loc2_ = list_rank.getCell(_index) as TeamRankItem;
               _loc2_.isClick = false;
            }
            if(param1 <= list_rank.startIndex + list_rank.repeatY && param1 >= list_rank.startIndex)
            {
               _loc3_ = list_rank.getCell(param1) as TeamRankItem;
               _loc3_.isClick = true;
            }
            if(_index == param1)
            {
               return;
            }
            SoundManager.instance.playButtonSound();
            _index = param1;
            updateTeaminfo(_index);
         }
      }
      
      private function updateTeaminfo(param1:int) : void
      {
         teamInfoBox.updateInfo(list_rank.array[param1]);
         teamInfoBox.enabled = _serverIndex == 1?false:true;
      }
      
      private function __listLeftSelectRander(param1:int) : void
      {
         var _loc3_:TeamRankLeftItem = list_left.getCell(_gradeIndex) as TeamRankLeftItem;
         var _loc4_:TeamRankLeftItem = list_left.getCell(param1) as TeamRankLeftItem;
         SoundManager.instance.playButtonSound();
         var _loc2_:Array = TeamManager.instance.model.rankList[_serverIndex][param1];
         if(!_loc2_ || _loc2_.length <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.team.noTeamRank"));
            return;
         }
         _gradeIndex = param1;
         _loc3_.isClick = false;
         _loc4_.isClick = true;
         updateRankList();
         updateSlefRank();
      }
      
      private function __listLeftRender(param1:Component, param2:int) : void
      {
         var _loc3_:* = null;
         if(param2 < list_left.length)
         {
            _loc3_ = param1 as TeamRankLeftItem;
            _loc3_.index = param2;
         }
      }
      
      private function __listRankRender(param1:Component, param2:int) : void
      {
         var _loc3_:TeamRankItem = param1 as TeamRankItem;
         if(param2 < list_rank.length)
         {
            if(param2 == _index)
            {
               _loc3_.isClick = true;
            }
            else
            {
               _loc3_.isClick = false;
            }
            _loc3_.index = param2 + 1;
            _loc3_.updaInfo(list_rank.array[param2]);
         }
         else
         {
            _loc3_.isShow = false;
            _loc3_.isClick = false;
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
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         label_currentRank.text = LanguageMgr.GetTranslation("tank.team.no");
         label_totolRank.text = LanguageMgr.GetTranslation("tank.team.no");
         var _loc2_:Array = TeamManager.instance.model.rankList[0][_gradeIndex];
         var _loc1_:Array = TeamManager.instance.model.rankList[1][_gradeIndex];
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc4_] as TeamRankInfo;
               if(_loc5_.TeamID == PlayerManager.Instance.Self.teamID)
               {
                  label_currentRank.text = String(_loc4_ + 1);
                  break;
               }
               _loc4_++;
            }
         }
         if(_loc1_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc5_ = _loc1_[_loc3_] as TeamRankInfo;
               if(_loc5_.TeamID == PlayerManager.Instance.Self.teamID && _loc5_.FromAreaName == TeamManager.instance.model.currentAreaName)
               {
                  label_totolRank.text = String(_loc3_ + 1);
                  break;
               }
               _loc3_++;
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
