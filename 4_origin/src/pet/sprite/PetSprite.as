package pet.sprite
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import road.game.resource.ActionMovie;
   
   public class PetSprite extends Sprite
   {
      
      public static const APPEAR:String = "bornB";
      
      public static const DISAPPEAR:String = "outC";
      
      public static const HUNGER:String = "hunger";
       
      
      private var _petMovie:ActionMovie;
      
      private var _petModel:PetSpriteModel;
      
      private var _petController:PetSpriteControl;
      
      private var _msgTxt:FilterFrameText;
      
      private var _msgBg:MovieClip;
      
      private var _loader:BaseLoader;
      
      private var _petSpriteLand:MovieClip;
      
      private var _petHeight:int = 0;
      
      private var _petWidth:int = 0;
      
      private var _petY:int = 0;
      
      private var _petX:int = 0;
      
      public function PetSprite(param1:PetSpriteModel, param2:PetSpriteControl)
      {
         super();
         _petModel = param1;
         _petController = param2;
         initView();
         initLand();
      }
      
      private function initView() : void
      {
         _msgBg = ComponentFactory.Instance.creatCustomObject("petSprite.ChatBall") as MovieClip;
         DisplayObject(_msgBg["bg"]["rtTopPoint"]).alpha = 0;
         _msgBg.visible = false;
         _msgTxt = ComponentFactory.Instance.creatComponentByStylename("petSprite.MessageTxt");
         _msgTxt.visible = false;
         addChild(_msgBg);
         _msgBg.addChild(_msgTxt);
         _msgTxt.x = _msgBg.x - 126;
         _msgTxt.y = _msgBg.y - 93;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function playAnimation(param1:String, param2:Function = null) : void
      {
         if(_petMovie)
         {
            _petMovie.doAction(param1,param2);
         }
         else if(param2 != null)
         {
            param2();
         }
      }
      
      public function petMove() : void
      {
         if(_petMovie)
         {
            removeEventListener("enterFrame",petToMove);
            addEventListener("enterFrame",petToMove);
         }
      }
      
      public function petNotMove() : void
      {
         if(_petMovie)
         {
            removeEventListener("enterFrame",petToMove);
         }
      }
      
      private function petToMove(param1:Event) : void
      {
         if(!_petMovie)
         {
            removeEventListener("enterFrame",petToMove);
            return;
         }
         if(_petMovie.scaleX == 1)
         {
            _petMovie.x--;
            _msgBg.x--;
            if(_petMovie.x <= -25)
            {
               _petMovie.scaleX = -1;
            }
         }
         else if(_petMovie.scaleX == -1)
         {
            _petMovie.x++;
            _msgBg.x++;
            if(_petMovie.x >= 100)
            {
               _petMovie.scaleX = 1;
            }
         }
      }
      
      public function say(param1:String) : void
      {
         _msgTxt.text = param1;
         _msgTxt.visible = true;
         _msgBg.visible = true;
         updateSize();
      }
      
      private function updateSize() : void
      {
         if(_msgTxt.textWidth > _msgBg.width)
         {
            _msgBg.width = _msgTxt.textWidth;
         }
         if(_msgTxt.textHeight > _msgBg.height)
         {
            _msgBg.height = _msgTxt.textHeight;
         }
         if(!_petMovie)
         {
            return;
         }
         _msgBg.y = _petHeight > 100?_petMovie.y - _petHeight + 40:Number(_petMovie.y - _petHeight - 10);
         _msgBg.x = _petMovie.x + 20;
      }
      
      public function hideMessageText() : void
      {
         _msgTxt.visible = false;
         _msgBg.visible = false;
      }
      
      public function updatePet() : void
      {
         initLand();
         initMovie();
      }
      
      private function initLand() : void
      {
         if(!_petModel.petSwitcher)
         {
            return;
         }
         if(!_petSpriteLand)
         {
            _petSpriteLand = ComponentFactory.Instance.creat("asset.chat.petSprite.land");
         }
         PositionUtils.setPos(_petSpriteLand,"chat.petSprite.landPos");
      }
      
      private function initMovie() : void
      {
         var _loc1_:* = null;
         if(_petMovie)
         {
            removeEventListener("enterFrame",petToMove);
            removeChild(_petMovie);
            _petMovie = null;
         }
         if(!_petModel.currentPet)
         {
            return;
         }
         if(_petModel.currentPet.assetReady)
         {
            _loc1_ = ModuleLoader.getDefinition(_petModel.currentPet.actionMovieName) as Class;
            _petMovie = new _loc1_();
            PositionUtils.setPos(_petMovie,"petSprite.PetMoviePos");
            addChild(_petMovie);
            _petHeight = _petMovie.height;
            _petWidth = _petMovie.width;
         }
         else
         {
            _loader = LoadResourceManager.Instance.createLoader(PathManager.solvePetGameAssetUrl(_petModel.currentPet.GameAssetUrl),4);
            _loader.addEventListener("complete",__onComplete);
            LoadResourceManager.Instance.startLoad(_loader);
         }
      }
      
      protected function __onComplete(param1:LoaderEvent) : void
      {
         if(_petMovie)
         {
            ObjectUtils.disposeObject(_petMovie);
            _petMovie = null;
         }
         _loader.removeEventListener("complete",__onComplete);
         var _loc2_:Class = ModuleLoader.getDefinition(_petModel.currentPet.actionMovieName) as Class;
         _petMovie = new _loc2_();
         PositionUtils.setPos(_petMovie,"petSprite.PetMoviePos");
         addChild(_petMovie);
         _petHeight = _petMovie.height;
         _petWidth = _petMovie.width;
      }
      
      public function get petSpriteLand() : MovieClip
      {
         return _petSpriteLand;
      }
      
      public function set petSpriteLand(param1:MovieClip) : void
      {
         _petSpriteLand = param1;
      }
   }
}
