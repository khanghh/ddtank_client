package catchInsect.player
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CatchInsectRoomPlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      public var playerWitdh:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      private var _sceneCharacterLoaderBody:SceneCharacterLoaderBody;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      public function CatchInsectRoomPlayerBase(param1:PlayerInfo, param2:Function = null){super(null);}
      
      private function initialize() : void{}
      
      private function sceneCharacterLoadHead() : void{}
      
      private function sceneCharacterLoaderHeadCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void{}
      
      private function sceneCharacterStateNatural() : void{}
      
      private function sceneCharacterLoadBodyNatural() : void{}
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:SceneCharacterLoaderBody, param2:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
