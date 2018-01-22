package consortionBattle.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ConsortiaBattlePlayerBase extends SceneCharacterPlayerBase
   {
       
      
      private var _playerData:ConsortiaBattlePlayerInfo;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _defaultSceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _defaultSceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _rectangle:Rectangle;
      
      public var playerWidth:Number = 120;
      
      public var playerHeight:Number = 175;
      
      private var _callBack:Function;
      
      private var _sceneCharacterLoaderBody:ConsBatLoaderHeadOrBody;
      
      private var _sceneCharacterLoaderHead:ConsBatLoaderHeadOrBody;
      
      private var _loadComplete:Boolean = false;
      
      public function ConsortiaBattlePlayerBase(param1:ConsortiaBattlePlayerInfo, param2:Function = null){super(null);}
      
      private function initialize() : void{}
      
      private function sceneCharacterLoadHead() : void{}
      
      private function showDefaultCharacter() : void{}
      
      private function sceneCharacterLoaderHeadCallBack(param1:ConsBatLoaderHeadOrBody, param2:Boolean = true) : void{}
      
      private function sceneCharacterStateNatural() : void{}
      
      private function sceneCharacterLoadBodyNatural() : void{}
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:ConsBatLoaderHeadOrBody, param2:Boolean = true) : void{}
      
      private function disposeDefaultSource() : void{}
      
      override public function dispose() : void{}
   }
}
