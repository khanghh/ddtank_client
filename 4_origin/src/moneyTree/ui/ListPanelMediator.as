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
      
      public function ListPanelMediator()
      {
         super();
      }
      
      public function setPanel(listPanel:ListPanel) : void
      {
         _listPanel = listPanel;
      }
      
      public function refresh(type:int, count:int = 0) : void
      {
         type = type;
         count = count;
         hasMounts = function(item:*, index:int, array:Array):Boolean
         {
            return item.Grade >= 25;
         };
         var titleList:Array = PlayerManager.Instance.friendList.slice();
         titleList = titleList.filter(hasMounts);
         titleList.sortOn("Grade",2);
         updateList(0,titleList);
      }
      
      private function updateList(type:int, list:Array) : void
      {
         var invitePlayer:* = null;
         var i:int = 0;
         var cpInfo:* = null;
         var tmpPosY:int = _listPanel.list.viewPosition.y;
         clearList();
         _invitePlayerInfos = [];
         for(i = 0; i < list.length; )
         {
            cpInfo = list[i] as BasePlayer;
            if(cpInfo.ID != PlayerManager.Instance.Self.ID)
            {
               invitePlayer = new InvitePlayerInfo();
               invitePlayer.NickName = cpInfo.NickName;
               invitePlayer.typeVIP = cpInfo.typeVIP;
               invitePlayer.Sex = cpInfo.Sex;
               invitePlayer.Grade = cpInfo.Grade;
               invitePlayer.Repute = cpInfo.Repute;
               invitePlayer.WinCount = cpInfo.WinCount;
               invitePlayer.TotalCount = cpInfo.TotalCount;
               invitePlayer.FightPower = cpInfo.FightPower;
               invitePlayer.ID = cpInfo.ID;
               invitePlayer.Offer = cpInfo.Offer;
               invitePlayer.isOld = cpInfo.isOld;
               invitePlayer.titleType = (cpInfo as FriendListPlayer).titleType;
               invitePlayer.type = (cpInfo as FriendListPlayer).type;
               invitePlayer.titleText = (cpInfo as FriendListPlayer).titleText;
               invitePlayer.titleNumText = (cpInfo as FriendListPlayer).titleNumText;
               _invitePlayerInfos.push(invitePlayer);
            }
            i++;
         }
         var friendList:Array = _invitePlayerInfos;
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(friendList);
         _listPanel.list.updateListView();
         var intPoint:IntPoint = new IntPoint(0,tmpPosY);
         _listPanel.list.viewPosition = intPoint;
      }
      
      private function clearList() : void
      {
         _listPanel.vectorListModel.clear();
      }
      
      public function reset() : void
      {
         var i:int = 0;
         var cellList:Vector.<IListCell> = _listPanel.list.cell;
         var len:int = cellList.length;
         for(i = 0; i < len; )
         {
            (cellList[i] as MoneyTreeSendRedPkgCell).reset();
            i++;
         }
      }
   }
}
