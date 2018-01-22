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
      
      public function GamePetMovie(param1:PetInfo, param2:GamePlayer)
      {
         super();
         _petInfo = param1;
         _player = param2;
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
      
      protected function __playPlayerEffect(param1:Event) : void
      {
         dispatchEvent(new Event("PlayEffect"));
      }
      
      public function init() : void
      {
         var _loc1_:* = null;
         if(_petInfo.assetReady)
         {
            _loc1_ = ModuleLoader.getDefinition(_petInfo.actionMovieName) as Class;
            _petMovie = new _loc1_();
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
         _petMovie.scaleX = -param1;
      }
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         if(_petMovie)
         {
            _petMovie.doAction(param1,param2,param3);
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
