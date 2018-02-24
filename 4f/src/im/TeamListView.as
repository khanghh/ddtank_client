package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.IMManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import team.TeamManager;
   import team.model.TeamMemberInfo;
   
   public class TeamListView extends Sprite implements Disposeable
   {
       
      
      private var _teamChatBtn:SimpleBitmapButton;
      
      private var _list:ListPanel;
      
      private var _teamPlayerArray:Array;
      
      private var _teamIMInfoArray:Array;
      
      private var _currentItem:TeamMemberInfo;
      
      private var _currentTitle:TeamMemberInfo;
      
      private var _pos:int;
      
      public function TeamListView(){super();}
      
      private function addEvent() : void{}
      
      private function initView() : void{}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function updateList() : void{}
      
      private function update() : void{}
      
      private function showTeamChatFrame() : void{}
      
      private function __showTeamChat(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function get teamIMInfoArray() : Array{return null;}
      
      public function dispose() : void{}
   }
}
