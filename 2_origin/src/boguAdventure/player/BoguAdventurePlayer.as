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
      
      public function BoguAdventurePlayer(param1:Function = null)
      {
         _dir = SceneCharacterDirection.RB;
         super(param1);
         _callBack = param1;
         initialize();
      }
      
      private function initialize() : void
      {
         _playerStateSet = new SceneCharacterStateSet();
         _playerSetNatural = new SceneCharacterSet();
         _playerActionSetNatural = new SceneCharacterActionSet();
         sceneCharacterStateNatural();
         _focusArr = [new Point(68,82),new Point(-73,82)];
         _focus = _focusArr[0];
      }
      
      private function sceneCharacterStateNatural() : void
      {
         var _loc1_:BitmapLoader = LoaderManager.Instance.creatLoader(PathManager.solveBoguAdventurePath(),0);
         _loc1_.addEventListener("complete",__onLoaderPlayerStateImageComplete);
         LoaderManager.Instance.startLoad(_loc1_);
      }
      
      private function __onLoaderPlayerStateImageComplete(param1:LoaderEvent) : void
      {
         var _loc6_:* = null;
         param1.loader.removeEventListener("complete",__onLoaderPlayerStateImageComplete);
         var _loc8_:BitmapData = (param1.loader as BitmapLoader).bitmapData;
         if(!_loc8_)
         {
            if(_callBack != null)
            {
               _callBack(this,false);
            }
            return;
         }
         var _loc7_:Rectangle = new Rectangle(0,0,_loc8_.width,_loc8_.height);
         _loc6_ = new BitmapData(_loc7_.width,_loc7_.height,true,0);
         _loc6_.copyPixels(_loc8_,_loc7_,new Point(0,0));
         _playerSetNatural.push(new SceneCharacterItem("NaturalBody","NaturalAction",_loc6_,3,11,playerWitdh,playerHeight,3));
         var _loc5_:SceneCharacterActionItem = new SceneCharacterActionItem("bogustop",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,7,7,8,8,9,9,9,9,8,8,7,7,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,10,10,10,10,0,0,0,0],true);
         _playerActionSetNatural.push(_loc5_);
         var _loc4_:SceneCharacterActionItem = new SceneCharacterActionItem("boguwalk",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _playerActionSetNatural.push(_loc4_);
         var _loc3_:SceneCharacterActionItem = new SceneCharacterActionItem("boguweep",[14,14,14,15,15,15,16,16,16],true);
         _playerActionSetNatural.push(_loc3_);
         var _loc2_:SceneCharacterActionItem = new SceneCharacterActionItem("bogulaugh",[11,11,12,12,13,13],true);
         _playerActionSetNatural.push(_loc2_);
         var _loc9_:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_playerSetNatural,_playerActionSetNatural);
         _playerStateSet.push(_loc9_);
         .super.sceneCharacterStateSet = _playerStateSet;
      }
      
      public function set dir(param1:SceneCharacterDirection) : void
      {
         if(param1 == null || _dir == param1)
         {
            return;
         }
         _dir = param1;
         if(_dir == SceneCharacterDirection.LB)
         {
            if(this.scaleX == -1)
            {
               return;
            }
            this.scaleX = -1;
            this.x = this.x + this.width;
            _focus = _focusArr[1];
         }
         else
         {
            if(this.scaleX == 1)
            {
               return;
            }
            this.scaleX = 1;
            this.x = this.x - this.width;
            _focus = _focusArr[0];
         }
      }
      
      public function get dir() : SceneCharacterDirection
      {
         return _dir;
      }
      
      public function get focusPos() : Point
      {
         return _focus;
      }
      
      override public function dispose() : void
      {
         if(_playerSetNatural)
         {
            _playerSetNatural.dispose();
         }
         _playerSetNatural = null;
         if(_playerActionSetNatural)
         {
            _playerActionSetNatural.dispose();
         }
         _playerActionSetNatural = null;
         if(_playerStateSet)
         {
            _playerStateSet.dispose();
         }
         _playerStateSet = null;
         _dir = null;
         _focusArr = null;
         _focus = null;
         super.dispose();
      }
   }
}
