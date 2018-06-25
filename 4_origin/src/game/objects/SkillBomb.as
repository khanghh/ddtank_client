package game.objects
{
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import game.actions.SkillActions.LaserAction;
   import game.view.map.MapView;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import phy.bombs.BaseBomb;
   import phy.maps.Map;
   
   public class SkillBomb extends BaseBomb
   {
       
      
      private var _info:Bomb;
      
      private var _owner:Living;
      
      private var _lifeTime:int;
      
      private var _cunrrentAction:BombAction;
      
      private var _laserAction:LaserAction;
      
      private var _game:GameInfo;
      
      public function SkillBomb(info:Bomb, owner:Living)
      {
         _info = info;
         _lifeTime = 0;
         _owner = owner;
         super(_info.Id);
      }
      
      public function get map() : MapView
      {
         return _map as MapView;
      }
      
      override public function setMap(map:Map) : void
      {
         super.setMap(map);
         if(map)
         {
            _game = this.map.gameInfo;
         }
      }
      
      override public function update(dt:Number) : void
      {
         var living:* = null;
         var player:* = null;
         if(_cunrrentAction == null)
         {
            _cunrrentAction = _info.Actions.shift();
         }
         if(_cunrrentAction == null)
         {
            bomb();
         }
         else if(_cunrrentAction.type == 16)
         {
            if(_laserAction == null)
            {
               living = _game.findLiving(_cunrrentAction.param1);
               _laserAction = new LaserAction(living,map,_info,_cunrrentAction.param2,_cunrrentAction.param3);
               _laserAction.prepare();
            }
            else if(_laserAction.isFinished)
            {
               _cunrrentAction = _info.Actions.shift();
            }
            else
            {
               _laserAction.execute();
            }
         }
         else if(_cunrrentAction.type == 5)
         {
            player = _game.findLiving(_cunrrentAction.param1);
            if(player)
            {
               if(Math.abs(player.blood - _cunrrentAction.param4) > 150000 && _owner is Player)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端发现异常:" + _owner.playerInfo.NickName + "打出单发炮弹" + Math.abs(player.blood - _cunrrentAction.param4) + "的伤害");
               }
               player.updateBlood(_cunrrentAction.param4,_cunrrentAction.param3,0 - _cunrrentAction.param2);
               player.isHidden = false;
               player.bomd();
            }
            _cunrrentAction = _info.Actions.shift();
         }
         else
         {
            _cunrrentAction = _info.Actions.shift();
         }
      }
      
      override protected function DigMap() : void
      {
      }
      
      override public function die() : void
      {
         dispatchEvent(new Event("complete"));
         super.die();
      }
   }
}
