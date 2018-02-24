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
      
      public function SkillBomb(param1:Bomb, param2:Living){super(null);}
      
      public function get map() : MapView{return null;}
      
      override public function setMap(param1:Map) : void{}
      
      override public function update(param1:Number) : void{}
      
      override protected function DigMap() : void{}
      
      override public function die() : void{}
   }
}
