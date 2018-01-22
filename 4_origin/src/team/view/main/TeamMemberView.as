package team.view.main
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamMemberViewUI;
   
   public class TeamMemberView extends TeamMemberViewUI
   {
       
      
      private const NAME:int = 1;
      
      private const RANK:int = 2;
      
      private const SESSION:int = 3;
      
      private const TOTAL_ACTIVE:int = 4;
      
      private const WEEK_ACTIVE:int = 5;
      
      private const DATE:int = 6;
      
      private var _sortType:int;
      
      private const SORT_ARRAY:int = 18;
      
      private var _memberList:Array;
      
      public function TeamMemberView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         list_member.renderHandler = new Handler(__onRenderMemeber);
         TeamManager.instance.addEventListener("updateteammember",__onUpdateMmeber);
         socreBtn.clickHandler = new Handler(__onClickScore);
         sessionBtn.clickHandler = new Handler(__onClickSession);
         memberBtn.clickHandler = new Handler(__onClickMember);
         totalActiveBtn.clickHandler = new Handler(__onClickTotalActive);
         weekActiveBtn.clickHandler = new Handler(__onClickWeekActive);
         dateBtn.clickHandler = new Handler(__onClickDate);
         memberBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text43");
         socreBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text37");
         sessionBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text42");
         totalActiveBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text44");
         weekActiveBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text15");
         dateBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text39");
      }
      
      protected function __onUpdateMmeber(param1:Event) : void
      {
         update();
      }
      
      private function __onRenderMemeber(param1:Box, param2:int) : void
      {
         var _loc10_:* = null;
         var _loc5_:NameTextEx = param1.getChildByName("name") as NameTextEx;
         var _loc7_:Label = param1.getChildByName("score") as Label;
         var _loc4_:Label = param1.getChildByName("time") as Label;
         var _loc9_:Label = param1.getChildByName("totalActive") as Label;
         var _loc3_:Label = param1.getChildByName("weekActive") as Label;
         var _loc8_:Label = param1.getChildByName("date") as Label;
         var _loc6_:Image = param1.getChildByName("img_captain") as Image;
         if(param2 < list_member.array.length)
         {
            _loc10_ = list_member.array[param2] as TeamMemberInfo;
            _loc5_.textType = _loc10_ && _loc10_.IsVIP?2:1;
            _loc5_.text = _loc10_.NickName;
            _loc7_.text = _loc10_.teamSocre.toString();
            _loc4_.text = _loc10_.totalTiems.toString();
            _loc9_.text = _loc10_.seasonActiveScore.toString();
            _loc3_.text = _loc10_.weekActiveScore.toString();
            if(_loc10_.teamDuty == 1)
            {
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
            if(_loc10_.playerState.StateID != 0)
            {
               _loc8_.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.online");
            }
            else if(_loc10_.playerState.StateID == 0)
            {
               if(_loc10_.OffLineHour == -1)
               {
                  _loc8_.text = _loc10_.minute + LanguageMgr.GetTranslation("minute");
               }
               else if(_loc10_.OffLineHour >= 1 && _loc10_.OffLineHour < 24)
               {
                  _loc8_.text = _loc10_.OffLineHour + LanguageMgr.GetTranslation("hour");
               }
               else if(_loc10_.OffLineHour >= 24 && _loc10_.OffLineHour < 720)
               {
                  _loc8_.text = _loc10_.day + LanguageMgr.GetTranslation("day");
               }
               else if(_loc10_.OffLineHour >= 720 && _loc10_.OffLineHour < 999)
               {
                  _loc8_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.month");
               }
               else
               {
                  _loc8_.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.MyConsortiaMemberInfoItem.long");
               }
            }
         }
         else
         {
            _loc5_.text = "";
            _loc7_.text = "";
            _loc4_.text = "";
            _loc9_.text = "";
            _loc3_.text = "";
            _loc8_.text = "";
            _loc6_.visible = false;
         }
      }
      
      public function update() : void
      {
         _sortType = -1;
         sort(5);
      }
      
      private function __onClickMember() : void
      {
         SoundManager.instance.playButtonSound();
         sort(1);
      }
      
      private function __onClickScore() : void
      {
         SoundManager.instance.playButtonSound();
         sort(2);
      }
      
      private function __onClickSession() : void
      {
         SoundManager.instance.playButtonSound();
         sort(3);
      }
      
      private function __onClickTotalActive() : void
      {
         SoundManager.instance.playButtonSound();
         sort(4);
      }
      
      private function __onClickWeekActive() : void
      {
         SoundManager.instance.playButtonSound();
         sort(5);
      }
      
      private function __onClickDate() : void
      {
         SoundManager.instance.playButtonSound();
         sort(6);
      }
      
      private function sort(param1:int) : void
      {
         if(_sortType == param1)
         {
            _memberList = _memberList.reverse();
         }
         else
         {
            _sortType = param1;
            _memberList = TeamManager.instance.model.selfTeamMember.concat();
            switch(int(_sortType) - 1)
            {
               case 0:
                  _memberList.sortOn("NickName");
                  break;
               case 1:
                  _memberList.sortOn("teamSocre",18);
                  break;
               case 2:
                  _memberList.sortOn("totalTiems",18);
                  break;
               case 3:
                  _memberList.sortOn("totalActiveScore",18);
                  break;
               case 4:
                  _memberList.sortOn("weekActiveScore",18);
                  break;
               case 5:
                  _memberList.sortOn(["OffLineHour","day","minute"],[18,18,18]);
            }
         }
         list_member.array = _memberList;
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateteammember",__onUpdateMmeber);
         super.dispose();
      }
   }
}
