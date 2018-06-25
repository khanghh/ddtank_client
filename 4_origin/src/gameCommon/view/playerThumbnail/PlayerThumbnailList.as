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
      
      public function PlayerThumbnailList(info:DictionaryData, dirct:int = 1)
      {
         super();
         _dirct = dirct;
         _info = info;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var j:int = 0;
         var player:* = null;
         _list = [];
         _players = new DictionaryData();
         if(_info)
         {
            j = 0;
            var _loc5_:int = 0;
            var _loc4_:* = _info;
            for(_index in _info)
            {
               player = new PlayerThumbnail(_info[i],_dirct);
               player.addEventListener("playerThumbnailEvent",__onTipClick);
               player.addEventListener("wishSelect",__thumbnailHandle);
               _players.add(i,player);
               addChild(player);
               _list.push(player);
            }
         }
         arrange();
      }
      
      private function __onTipClick(e:Event) : void
      {
         e = e;
         __addTip = function(event:Event):void
         {
            if((event.currentTarget as PlayerThumbnailTip).tipDisplay)
            {
               (event.currentTarget as PlayerThumbnailTip).tipDisplay.recoverTip();
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
      
      private function __thumbnailHandle(e:GameEvent) : void
      {
         dispatchEvent(new GameEvent("wishSelect",e.data));
      }
      
      private function arrange() : void
      {
         var child:* = null;
         var count:int = 0;
         while(count < numChildren)
         {
            child = getChildAt(count);
            if(_dirct < 0)
            {
               child.x = (count + 1) * (child.width + 4) * _dirct;
            }
            else
            {
               child.x = count * (child.width + 4) * _dirct;
            }
            count++;
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
      
      private function __addLiving(e:DictionaryEvent) : void
      {
         var info:* = null;
         var player:* = null;
         if(e.data is Player)
         {
            info = e.data as Player;
            player = new PlayerThumbnail(info,_dirct);
            player.addEventListener("playerThumbnailEvent",__onTipClick);
            player.addEventListener("wishSelect",__thumbnailHandle);
            _players.add(String(info.playerInfo.ID),player);
            addChild(player);
            _list.push(player);
            arrange();
         }
      }
      
      private function delePlayer(id:int) : void
      {
         var i:int = 0;
         var p:* = null;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            p = _list[i] as PlayerThumbnail;
            if(p.info.ID == id)
            {
               removeChild(p);
               _list.splice(i,1);
               break;
            }
            i++;
         }
      }
      
      public function __removePlayer(evt:DictionaryEvent) : void
      {
         var info:Player = evt.data as Player;
         if(info && info.playerInfo)
         {
            if(_players[info.playerInfo.ID])
            {
               _players[info.playerInfo.ID].removeEventListener("playerThumbnailEvent",__onTipClick);
               _players[info.playerInfo.ID].removeEventListener("wishSelect",__thumbnailHandle);
               _players[info.playerInfo.ID].dispose();
               delete _players[info.playerInfo.ID];
            }
         }
         arrange();
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _players;
         for(var i in _players)
         {
            if(_players[i])
            {
               _players[i].removeEventListener("playerThumbnailEvent",__onTipClick);
               _players[i].removeEventListener("wishSelect",__thumbnailHandle);
               _players[i].dispose();
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
