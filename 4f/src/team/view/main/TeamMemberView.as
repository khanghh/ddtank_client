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
      
      public function TeamMemberView(){super();}
      
      override protected function initialize() : void{}
      
      protected function __onUpdateMmeber(param1:Event) : void{}
      
      private function __onRenderMemeber(param1:Box, param2:int) : void{}
      
      public function update() : void{}
      
      private function __onClickMember() : void{}
      
      private function __onClickScore() : void{}
      
      private function __onClickSession() : void{}
      
      private function __onClickTotalActive() : void{}
      
      private function __onClickWeekActive() : void{}
      
      private function __onClickDate() : void{}
      
      private function sort(param1:int) : void{}
      
      override public function dispose() : void{}
   }
}
