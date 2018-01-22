package gameStarling.objects
{
   import ddt.manager.SocketManager;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameStarling.actions.SkillActions.LaserAction3D;
   import gameStarling.view.map.MapView3D;
   import starling.events.Event;
   import starlingPhy.bombs.BaseBomb3D;
   import starlingPhy.maps.Map3D;
   
   public class SkillBomb3D extends BaseBomb3D
   {
       
      
      private var _info:Bomb;
      
      private var _owner:Living;
      
      private var _lifeTime:int;
      
      private var _cunrrentAction:BombAction3D;
      
      private var _laserAction:LaserAction3D;
      
      private var _game:GameInfo;
      
      public function SkillBomb3D(param1:Bomb, param2:Living)
      {
         _info = param1;
         _lifeTime = 0;
         _owner = param2;
         super(_info.Id);
      }
      
      public function get map() : MapView3D
      {
         return _map as MapView3D;
      }
      
      override public function setMap(param1:Map3D) : void
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
               _laserAction = new LaserAction3D(_loc3_,map,_info,_cunrrentAction.param2,_cunrrentAction.param3);
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
