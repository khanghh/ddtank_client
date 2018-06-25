package moneyTree.ui{   import com.pickgliss.geom.IntPoint;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.cell.IListCell;   import ddt.data.player.BasePlayer;   import ddt.data.player.FriendListPlayer;   import ddt.manager.PlayerManager;   import invite.data.InvitePlayerInfo;      public class ListPanelMediator   {                   private var _listPanel:ListPanel;            private var _invitePlayerInfos:Array;            public function ListPanelMediator() { super(); }
            public function setPanel(listPanel:ListPanel) : void { }
            public function refresh(type:int, count:int = 0) : void { }
            private function updateList(type:int, list:Array) : void { }
            private function clearList() : void { }
            public function reset() : void { }
   }}