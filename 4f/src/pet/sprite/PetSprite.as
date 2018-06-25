package pet.sprite{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import road.game.resource.ActionMovie;      public class PetSprite extends Sprite   {            public static const APPEAR:String = "bornB";            public static const DISAPPEAR:String = "outC";            public static const HUNGER:String = "hunger";                   private var _petMovie:ActionMovie;            private var _petModel:PetSpriteModel;            private var _petController:PetSpriteControl;            private var _msgTxt:FilterFrameText;            private var _msgBg:MovieClip;            private var _loader:BaseLoader;            private var _petSpriteLand:MovieClip;            private var _petHeight:int = 0;            private var _petWidth:int = 0;            private var _petY:int = 0;            private var _petX:int = 0;            public function PetSprite(model:PetSpriteModel, controller:PetSpriteControl) { super(); }
            private function initView() : void { }
            public function playAnimation(action:String, callback:Function = null) : void { }
            public function petMove() : void { }
            public function petNotMove() : void { }
            private function petToMove(e:Event) : void { }
            public function say(msg:String) : void { }
            private function updateSize() : void { }
            public function hideMessageText() : void { }
            public function updatePet() : void { }
            private function initLand() : void { }
            private function initMovie() : void { }
            protected function __onComplete(event:LoaderEvent) : void { }
            public function get petSpriteLand() : MovieClip { return null; }
            public function set petSpriteLand(value:MovieClip) : void { }
   }}