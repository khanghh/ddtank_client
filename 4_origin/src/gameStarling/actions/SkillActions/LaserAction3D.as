package gameStarling.actions.SkillActions
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.command.PlayerAction;
   import ddt.view.characterStarling.GameCharacter3D;
   import dragonBones.Armature;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.view.map.MapView3D;
   import road7th.utils.BoneMovieWrapper;
   import road7th.utils.MathUtils;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class LaserAction3D extends BaseAction
   {
      
      public static const radius:int = 60;
       
      
      private var _player:GamePlayer3D;
      
      private var _laserMovie:BoneMovieWrapper;
      
      private var _movieComplete:Boolean = false;
      
      private var _movieStarted:Boolean = false;
      
      private var _shocked:Boolean = false;
      
      private var _showAction:PlayerAction;
      
      private var _hideAction:PlayerAction;
      
      private var _living:Living;
      
      private var _map:MapView3D;
      
      private var _angle:int;
      
      private var _speed:int;
      
      private var _length:int;
      
      private var _info:Bomb;
      
      private var _shootHead:BoneMovieStarling;
      
      private var _mask:Sprite;
      
      private var _tempLength:int = 0;
      
      public function LaserAction3D(living:Living, map:MapView3D, info:Bomb, angle:int, length:Number)
      {
         super();
         _living = living;
         _map = map;
         _info = info;
         _angle = angle;
         _length = length > 90?length - 90:Number(length);
      }
      
      override public function prepare() : void
      {
         var dis:int = 0;
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         var name:String = "bonesBullet" + _info.Template.ID;
         var armature:Armature = BoneMovieFactory.instance.getArmature(name,BoneMovieFactory.instance.starlingFactory);
         _laserMovie = new BoneMovieWrapper(new BoneMovieStarling().setArmature(armature.getBone("bullet").childArmature));
         _shootHead = new BoneMovieStarling().setArmature(armature.getBone("head").childArmature) as BoneMovieStarling;
         _mask = new Sprite();
         _laserMovie.asDisplay.mask = _mask;
         var angle:int = 0;
         if(_living.direction == -1)
         {
            angle = 180 + _angle;
            var _loc5_:* = -1;
            _mask.scaleX = _loc5_;
            _laserMovie.asDisplay.scaleX = _loc5_;
            if(_shootHead)
            {
               _shootHead.scaleX = -1;
            }
         }
         else
         {
            angle = _angle;
            _loc5_ = 1;
            _shootHead.scaleX = _loc5_;
            _loc5_ = _loc5_;
            _mask.scaleX = _loc5_;
            _laserMovie.asDisplay.scaleX = _loc5_;
            if(_shootHead)
            {
               _shootHead.scaleX = 1;
            }
         }
         _loc5_ = angle;
         _shootHead.angle = _loc5_;
         _laserMovie.asDisplay.angle = _loc5_;
         if(_living is Player)
         {
            if(_living.direction == 1)
            {
               _laserMovie.asDisplay.x = _living.pos.x + 30;
               _laserMovie.asDisplay.y = _living.pos.y - 20;
            }
            else
            {
               _laserMovie.asDisplay.x = _living.pos.x - 30;
               _laserMovie.asDisplay.y = _living.pos.y - 20;
            }
         }
         else
         {
            _laserMovie.asDisplay.x = _living.pos.x;
            _laserMovie.asDisplay.y = _living.pos.y;
         }
         _map.addChild(_laserMovie.asDisplay);
         if(_shootHead)
         {
            _map.addChild(_shootHead);
         }
         _showAction = GameCharacter3D.SHOT;
         _hideAction = GameCharacter3D.HIDEGUN;
         updateSkillView(10);
      }
      
      override public function execute() : void
      {
         if(!_movieStarted)
         {
            _movieStarted = true;
            _laserMovie.playAction("",movieComplete);
            _map.addEventListener("enterFrame",__laserFrame);
         }
      }
      
      private function __laserFrame(event:Event) : void
      {
         _tempLength = _tempLength + 300;
         if(_tempLength >= _length)
         {
            _tempLength = _length;
            _map.removeEventListener("enterFrame",__laserFrame);
         }
         updateSkillView(_tempLength);
      }
      
      private function updateSkillView(tempLength:Number) : void
      {
         var offsetX:Number = _laserMovie.asDisplay.x + MathUtils.cos(_angle) * tempLength;
         var offsetY:Number = _laserMovie.asDisplay.y + MathUtils.sin(_angle) * tempLength;
         _shootHead.x = offsetX;
         _shootHead.y = offsetY;
         _mask.graphics.clear();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawCircle(0,0,tempLength + 30);
         _mask.graphics.endFill();
         if(_map.IsOutMap(offsetX,offsetY))
         {
            _map.setCenter(_living.pos.x,_living.pos.y,true);
         }
         else
         {
            _map.setCenter(offsetX,offsetY,false);
         }
      }
      
      private function movieComplete() : void
      {
         _map.removeEventListener("enterFrame",__laserFrame);
         StarlingObjectUtils.disposeObject(_mask);
         _mask = null;
         StarlingObjectUtils.disposeObject(_shootHead);
         _shootHead = null;
         _laserMovie.dispose();
         _laserMovie = null;
         _isFinished = true;
      }
   }
}
