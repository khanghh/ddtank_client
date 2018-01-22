package moneyTree.ui
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.cell.IListCell;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.PlayerManager;
   import invite.data.InvitePlayerInfo;
   
   public class ListPanelMediator
   {
       
      
      private var _listPanel:ListPanel;
      
      private var _invitePlayerInfos:Array;
      
      public function ListPanelMediator(){super();}
      
      public function setPanel(param1:ListPanel) : void{}
      
      public function refresh(param1:int, param2:int = 0) : void{}
      
      private function updateList(param1:int, param2:Array) : void{}
      
      private function clearList() : void{}
      
      public function reset() : void{}
   }
}
