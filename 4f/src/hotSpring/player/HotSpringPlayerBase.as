package hotSpring.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderBody;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HotSpringPlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterSetWater:SceneCharacterSet;
      
      private var _sceneCharacterLoaderPath:String;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _sceneCharacterActionSetWater:SceneCharacterActionSet;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      private var _sceneCharacterLoaderBody:SceneCharacterLoaderBody;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      private var _headMaskAsset:MovieImage;
      
      public var playerWitdh:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      public function HotSpringPlayerBase(param1:PlayerInfo, param2:Function = null){super(null);}
      
      private function initialize() : void{}
      
      private function sceneCharacterLoadHead() : void{}
      
      private function sceneCharacterLoaderHeadCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      private function sceneCharacterStateNatural() : void{}
      
      private function sceneCharacterLoadBodyNatural() : void{}
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:SceneCharacterLoaderBody, param2:Boolean = true) : void{}
      
      private function sceneCharacterStateWater() : void{}
      
      private function sceneCharacterLoadBodyWater() : void{}
      
      private function sceneCharacterLoaderBodyWaterCallBack(param1:SceneCharacterLoaderBody, param2:Boolean = true) : void{}
      
      override public function dispose() : void{}
   }
}
