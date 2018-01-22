package gameCommon.view.playerThumbnail
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.events.GameEvent;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import gameCommon.model.Player;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class PlayerThumbnailList extends Sprite implements Disposeable
   {
       
      
      private var _info:DictionaryData;
      
      private var _players:DictionaryData;
      
      private var _dirct:int;
      
      private var _index:String;
      
      private var _list:Array;
      
      private var _thumbnailTip:PlayerThumbnailTip;
      
      public function PlayerThumbnailList(param1:DictionaryData, param2:int = 1)
      {
         super();
         _dirct = param2;
         _info = param1;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _list = [];
         _players = new DictionaryData();
         if(_info)
         {
            _loc2_ = 0;
            var _loc5_:int = 0;
            var _loc4_:* = _info;
            for(_index in _info)
            {
               _loc1_ = new PlayerThumbnail(_info[_loc3_],_dirct);
               _loc1_.addEventListener("playerThumbnailEvent",__onTipClick);
               _loc1_.addEventListener("wishSelect",__thumbnailHandle);
               _players.add(_loc3_,_loc1_);
               addChild(_loc1_);
               _list.push(_loc1_);
            }
         }
         arrange();
      }
      
      private function __onTipClick(param1:Event) : void
      {
         e = param1;
         __addTip = function(param1:Event):void
         {
            if((param1.currentTarget as PlayerThumbnailTip).tipDisplay)
            {
               (param1.currentTarget as PlayerThumbnailTip).tipDisplay.recoverTip();
            }
         };
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(5))
         {
            return;
         }
         _thumbnailTip = ShowTipManager.Instance.getTipInstanceByStylename("gameCommon.view.playerThumbnail.PlayerThumbnailTip") as PlayerThumbnailTip;
         if(_thumbnailTip == null)
         {
            _thumbnailTip = ShowTipManager.Instance.createTipByStyleName("gameCommon.view.playerThumbnail.PlayerThumbnailTip");
            _thumbnailTip.addEventListener("playerThumbnailTipItemClick",__addTip);
         }
         _thumbnailTip.tipDisplay = e.currentTarget as PlayerThumbnail;
         _thumbnailTip.x = this.mouseX;
         _thumbnailTip.y = e.currentTarget.height + e.currentTarget.y + 12;
         PositionUtils.setPos(_thumbnailTip,localToGlobal(new Point(_thumbnailTip.x,_thumbnailTip.y)));
         LayerManager.Instance.addToLayer(_thumbnailTip,3,false);
      }
      
      private function __thumbnailHandle(param1:GameEvent) : void
      {
         dispatchEvent(new GameEvent("wishSelect",param1.data));
      }
      
      private function arrange() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < numChildren)
         {
            _loc1_ = getChildAt(_loc2_);
            if(_dirct < 0)
            {
               _loc1_.x = (_loc2_ + 1) * (_loc1_.width + 4) * _dirct;
            }
            else
            {
               _loc1_.x = _loc2_ * (_loc1_.width + 4) * _dirct;
            }
            _loc2_++;
         }
      }
      
      private function initEvents() : void
      {
         _info.addEventListener("remove",__removePlayer);
         _info.addEventListener("add",__addLiving);
      }
      
      private function removeEvents() : void
      {
         _info.removeEventListener("remove",__removePlayer);
         _info.removeEventListener("add",__addLiving);
      }
      
      private function __addLiving(param1:DictionaryEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.data is Player)
         {
            _loc3_ = param1.data as Player;
            _loc2_ = new PlayerThumbnail(_loc3_,_dirct);
            _loc2_.addEventListener("playerThumbnailEvent",__onTipClick);
            _loc2_.addEventListener("wishSelect",__thumbnailHandle);
            _players.add(String(_loc3_.playerInfo.ID),_loc2_);
            addChild(_loc2_);
            _list.push(_loc2_);
            arrange();
         }
      }
      
      private function delePlayer(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _list[_loc4_] as PlayerThumbnail;
            if(_loc2_.info.ID == param1)
            {
               removeChild(_loc2_);
               _list.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
      }
      
      public function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:Player = param1.data as Player;
         if(_loc2_ && _loc2_.playerInfo)
         {
            if(_players[_loc2_.playerInfo.ID])
            {
               _players[_loc2_.playerInfo.ID].removeEventListener("playerThumbnailEvent",__onTipClick);
               _players[_loc2_.playerInfo.ID].removeEventListener("wishSelect",__thumbnailHandle);
               _players[_loc2_.playerInfo.ID].dispose();
               delete _players[_loc2_.playerInfo.ID];
            }
         }
         arrange();
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for(var _loc1_ in _players)
         {
            if(_players[_loc1_])
            {
               _players[_loc1_].removeEventListener("playerThumbnailEvent",__onTipClick);
               _players[_loc1_].removeEventListener("wishSelect",__thumbnailHandle);
               _players[_loc1_].dispose();
            }
         }
         _players = null;
         if(_thumbnailTip)
         {
            _thumbnailTip.tipDisplay = null;
         }
         _thumbnailTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
