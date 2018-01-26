package boguAdventure.player
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import ddt.manager.PathManager;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BoguAdventurePlayer extends SceneCharacterPlayerBase
   {
      
      public static const STOP:String = "bogustop";
      
      public static const WALK:String = "boguwalk";
      
      public static const WEEP:String = "boguweep";
      
      public static const LAUGH:String = "bogulaugh";
       
      
      private var _playerStateSet:SceneCharacterStateSet;
      
      private var _playerSetNatural:SceneCharacterSet;
      
      private var _playerActionSetNatural:SceneCharacterActionSet;
      
      public var playerWitdh:Number = 114;
      
      public var playerHeight:Number = 95;
      
      private var _callBack:Function;
      
      private var _dir:SceneCharacterDirection;
      
      private var _focusArr:Array;
      
      private var _focus:Point;
      
      public function BoguAdventurePlayer(param1:Function = null){super(null);}
      
      private function initialize() : void{}
      
      private function sceneCharacterStateNatural() : void{}
      
      private function __onLoaderPlayerStateImageComplete(param1:LoaderEvent) : void{}
      
      public function set dir(param1:SceneCharacterDirection) : void{}
      
      public function get dir() : SceneCharacterDirection{return null;}
      
      public function get focusPos() : Point{return null;}
      
      override public function dispose() : void{}
   }
}
