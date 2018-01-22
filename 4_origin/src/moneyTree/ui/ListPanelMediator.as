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
      
      public function setPanel(param1:ListPanel) : void
      {
         _listPanel = param1;
      }
      
      public function refresh(param1:int, param2:int = 0) : void
      {
         type = param1;
         count = param2;
         hasMounts = function(param1:*, param2:int, param3:Array):Boolean
         {
            return param1.Grade >= 25;
         };
         var titleList:Array = PlayerManager.Instance.friendList.slice();
         titleList = titleList.filter(hasMounts);
         titleList.sortOn("Grade",2);
         updateList(0,titleList);
      }
      
      private function updateList(param1:int, param2:Array) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = _listPanel.list.viewPosition.y;
         clearList();
         _invitePlayerInfos = [];
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            _loc3_ = param2[_loc7_] as BasePlayer;
            if(_loc3_.ID != PlayerManager.Instance.Self.ID)
            {
               _loc6_ = new InvitePlayerInfo();
               _loc6_.NickName = _loc3_.NickName;
               _loc6_.typeVIP = _loc3_.typeVIP;
               _loc6_.Sex = _loc3_.Sex;
               _loc6_.Grade = _loc3_.Grade;
               _loc6_.Repute = _loc3_.Repute;
               _loc6_.WinCount = _loc3_.WinCount;
               _loc6_.TotalCount = _loc3_.TotalCount;
               _loc6_.FightPower = _loc3_.FightPower;
               _loc6_.ID = _loc3_.ID;
               _loc6_.Offer = _loc3_.Offer;
               _loc6_.isOld = _loc3_.isOld;
               _loc6_.titleType = (_loc3_ as FriendListPlayer).titleType;
               _loc6_.type = (_loc3_ as FriendListPlayer).type;
               _loc6_.titleText = (_loc3_ as FriendListPlayer).titleText;
               _loc6_.titleNumText = (_loc3_ as FriendListPlayer).titleNumText;
               _invitePlayerInfos.push(_loc6_);
            }
            _loc7_++;
         }
         var _loc5_:Array = _invitePlayerInfos;
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(_loc5_);
         _listPanel.list.updateListView();
         var _loc4_:IntPoint = new IntPoint(0,_loc8_);
         _listPanel.list.viewPosition = _loc4_;
      }
      
      private function clearList() : void
      {
         _listPanel.vectorListModel.clear();
      }
      
      public function reset() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<IListCell> = _listPanel.list.cell;
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            (_loc2_[_loc3_] as MoneyTreeSendRedPkgCell).reset();
            _loc3_++;
         }
      }
   }
}
