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
      
      public function SkillBomb3D(param1:Bomb, param2:Living){super(null);}
      
      public function get map() : MapView3D{return null;}
      
      override public function setMap(param1:Map3D) : void{}
      
      override public function update(param1:Number) : void{}
      
      override protected function DigMap() : void{}
      
      override public function die() : void{}
   }
}
