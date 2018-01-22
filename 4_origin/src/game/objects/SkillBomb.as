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
      
      public function SkillBomb(param1:Bomb, param2:Living)
      {
         _info = param1;
         _lifeTime = 0;
         _owner = param2;
         super(_info.Id);
      }
      
      public function get map() : MapView
      {
         return _map as MapView;
      }
      
      override public function setMap(param1:Map) : void
      {
         super.setMap(param1);
         if(param1)
         {
            _game = this.map.gameInfo;
         }
      }
      
      override public function update(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
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
               _loc3_ = _game.findLiving(_cunrrentAction.param1);
               _laserAction = new LaserAction(_loc3_,map,_info,_cunrrentAction.param2,_cunrrentAction.param3);
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
            _loc2_ = _game.findLiving(_cunrrentAction.param1);
            if(_loc2_)
            {
               if(Math.abs(_loc2_.blood - _cunrrentAction.param4) > 150000 && _owner is Player)
               {
                  SocketManager.Instance.out.sendErrorMsg("客户端发现异常:" + _owner.playerInfo.NickName + "打出单发炮弹" + Math.abs(_loc2_.blood - _cunrrentAction.param4) + "的伤害");
               }
               _loc2_.updateBlood(_cunrrentAction.param4,_cunrrentAction.param3,0 - _cunrrentAction.param2);
               _loc2_.isHidden = false;
               _loc2_.bomd();
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
