package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class SuperWinnerPlayerListView extends Sprite implements Disposeable
   {
       
      
      private var _data:DictionaryData;
      
      private var _playerList:ListPanel;
      
      public function SuperWinnerPlayerListView(data:DictionaryData)
      {
         _data = data;
         super();
         initbg();
         initView();
         initEvent();
      }
      
      private function initbg() : void
      {
         var bg:Image = ComponentFactory.Instance.creat("superWinner.playerList.bg");
         addChild(bg);
      }
      
      private function initView() : void
      {
         _playerList = ComponentFactory.Instance.creatComponentByStylename("asset.superWinner.PlayerList");
         _playerList.vScrollbar.visible = false;
         addChild(_playerList);
         _playerList.list.updateListView();
      }
      
      private function initEvent() : void
      {
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
         _data.addEventListener("update",__updatePlayer);
      }
      
      private function __addPlayer(event:DictionaryEvent) : void
      {
         var player:PlayerInfo = event.data as PlayerInfo;
         _playerList.vectorListModel.insertElementAt(player,getInsertIndex(player));
      }
      
      private function __removePlayer(event:DictionaryEvent) : void
      {
         var player:PlayerInfo = event.data as PlayerInfo;
         _playerList.vectorListModel.remove(player);
      }
      
      private function __updatePlayer(event:DictionaryEvent) : void
      {
         var player:PlayerInfo = event.data as PlayerInfo;
         _playerList.vectorListModel.remove(player);
         _playerList.vectorListModel.insertElementAt(player,getInsertIndex(player));
         _playerList.list.updateListView();
      }
      
      private function getInsertIndex(info:PlayerInfo) : int
      {
         var tempInfo:* = null;
         var i:int = 0;
         var tempIndex:int = 0;
         var tempArray:Array = _playerList.vectorListModel.elements;
         if(tempArray.length == 0)
         {
            return 0;
         }
         for(i = tempArray.length - 1; i >= 0; )
         {
            tempInfo = tempArray[i] as PlayerInfo;
            if(!(info.IsVIP && !tempInfo.IsVIP))
            {
               if(!info.IsVIP && tempInfo.IsVIP)
               {
                  return i + 1;
               }
               if(info.IsVIP == tempInfo.IsVIP)
               {
                  if(info.Grade > tempInfo.Grade)
                  {
                     tempIndex = i - 1;
                  }
                  else
                  {
                     return i + 1;
                  }
               }
            }
            i--;
         }
         return tempIndex < 0?0:tempIndex;
      }
      
      public function dispose() : void
      {
         _data.removeEventListener("add",__addPlayer);
         _data.removeEventListener("remove",__removePlayer);
         _data.removeEventListener("update",__updatePlayer);
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
