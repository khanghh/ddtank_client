package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import road.game.resource.ActionMovie;
   
   public class GamePetMovie extends Sprite implements Disposeable
   {
      
      public static const PlayEffect:String = "PlayEffect";
       
      
      private var _petInfo:PetInfo;
      
      private var _player:GamePlayer;
      
      private var _petMovie:ActionMovie;
      
      public function GamePetMovie(info:PetInfo, player:GamePlayer)
      {
         super();
         _petInfo = info;
         _player = player;
         init();
         initEvent();
      }
      
      private function initEvent() : void
      {
         if(_petMovie)
         {
            _petMovie.addEventListener("effect",__playPlayerEffect);
         }
      }
      
      protected function __playPlayerEffect(event:Event) : void
      {
         dispatchEvent(new Event("PlayEffect"));
      }
      
      public function init() : void
      {
         var movieClass:* = null;
         if(_petInfo.assetReady)
         {
            movieClass = ModuleLoader.getDefinition(_petInfo.actionMovieName) as Class;
            _petMovie = new movieClass();
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
         _petMovie.scaleX = -val;
      }
      
      public function doAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         if(_petMovie)
         {
            _petMovie.doAction(type,callBack,args);
         }
      }
      
      public function dispose() : void
      {
         if(_petMovie)
         {
            _petMovie.removeEventListener("effect",__playPlayerEffect);
         }
         ObjectUtils.disposeObject(_petMovie);
         _petMovie = null;
      }
   }
}
