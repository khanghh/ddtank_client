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
      
      public function SuperWinnerPlayerListView(param1:DictionaryData)
      {
         _data = param1;
         super();
         initbg();
         initView();
         initEvent();
      }
      
      private function initbg() : void
      {
         var _loc1_:Image = ComponentFactory.Instance.creat("superWinner.playerList.bg");
         addChild(_loc1_);
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
      
      private function __addPlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc2_));
      }
      
      private function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.remove(_loc2_);
      }
      
      private function __updatePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:PlayerInfo = param1.data as PlayerInfo;
         _playerList.vectorListModel.remove(_loc2_);
         _playerList.vectorListModel.insertElementAt(_loc2_,getInsertIndex(_loc2_));
         _playerList.list.updateListView();
      }
      
      private function getInsertIndex(param1:PlayerInfo) : int
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _playerList.vectorListModel.elements;
         if(_loc3_.length == 0)
         {
            return 0;
         }
         _loc5_ = _loc3_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = _loc3_[_loc5_] as PlayerInfo;
            if(!(param1.IsVIP && !_loc4_.IsVIP))
            {
               if(!param1.IsVIP && _loc4_.IsVIP)
               {
                  return _loc5_ + 1;
               }
               if(param1.IsVIP == _loc4_.IsVIP)
               {
                  if(param1.Grade > _loc4_.Grade)
                  {
                     _loc2_ = _loc5_ - 1;
                  }
                  else
                  {
                     return _loc5_ + 1;
                  }
               }
            }
            _loc5_--;
         }
         return _loc2_ < 0?0:_loc2_;
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
