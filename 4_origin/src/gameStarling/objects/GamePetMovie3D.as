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
      
      public function GamePetMovie3D(info:PetInfo, player:GamePlayer3D)
      {
         super();
         _petInfo = info;
         _player = player;
         init();
      }
      
      private function onActionEffectEvent(movie:BoneMovieWrapper, args:Array = null) : void
      {
         dispatchEvent(new Event("PlayEffect"));
      }
      
      protected function __playPlayerEffect(event:Event) : void
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
      
      public function show(x:int = 0, y:int = 0) : void
      {
         _player.map.addToPhyLayer(this);
         PositionUtils.setPos(this,new Point(x,y));
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
      
      public function set direction(val:int) : void
      {
         if(_petMovie)
         {
            _petMovie.scaleX = -val;
         }
      }
      
      public function doAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         if(_petMovie)
         {
            _petMovie.doAction(type,callBack,args);
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
