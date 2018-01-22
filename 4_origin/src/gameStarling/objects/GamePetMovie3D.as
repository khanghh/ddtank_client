package gameStarling.objects
{
   import bones.game.ActionMovieBone;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import road7th.utils.BoneMovieWrapper;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class GamePetMovie3D extends Sprite
   {
      
      public static const PlayEffect:String = "PlayEffect";
       
      
      private var _petInfo:PetInfo;
      
      private var _player:GamePlayer3D;
      
      private var _petMovie:ActionMovieBone;
      
      public function GamePetMovie3D(param1:PetInfo, param2:GamePlayer3D)
      {
         super();
         _petInfo = param1;
         _player = param2;
         init();
      }
      
      private function onActionEffectEvent(param1:BoneMovieWrapper, param2:Array = null) : void
      {
         dispatchEvent(new Event("PlayEffect"));
      }
      
      protected function __playPlayerEffect(param1:Event) : void
      {
      }
      
      public function init() : void
      {
         if(_petInfo.assetReady)
         {
            _petMovie = new ActionMovieBone(_petInfo.actionMovieName);
            _petMovie.boneMovie.addFrameScript("effect",onActionEffectEvent);
            addChild(_petMovie);
         }
      }
      
      public function show(param1:int = 0, param2:int = 0) : void
      {
         _player.map.addToPhyLayer(this);
         PositionUtils.setPos(this,new Point(param1,param2));
      }
      
      public function hide() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get info() : PetInfo
      {
         return _petInfo;
      }
      
      public function set direction(param1:int) : void
      {
         if(_petMovie)
         {
            _petMovie.scaleX = -param1;
         }
      }
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         if(_petMovie)
         {
            _petMovie.doAction(param1,param2,param3);
         }
      }
      
      override public function dispose() : void
      {
         if(_petMovie)
         {
            _petMovie.boneMovie.removeFrameScriptAll();
         }
         StarlingObjectUtils.disposeObject(_petMovie);
         _petMovie = null;
         super.dispose();
      }
   }
}
