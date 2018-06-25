package campbattle.view.roleView{   import campbattle.data.RoleData;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.PNGHitAreaFactory;   import ddt.manager.PlayerManager;   import ddt.utils.PositionUtils;   import ddt.view.sceneCharacter.SceneCharacterActionItem;   import ddt.view.sceneCharacter.SceneCharacterActionSet;   import ddt.view.sceneCharacter.SceneCharacterItem;   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;   import ddt.view.sceneCharacter.SceneCharacterSet;   import ddt.view.sceneCharacter.SceneCharacterStateItem;   import ddt.view.sceneCharacter.SceneCharacterStateSet;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import hall.player.HallPlayerView;   import horse.HorseManager;      public class CampBaseRole extends SceneCharacterPlayerBase   {            private static var MountsWidth:int = 500;            private static var MountsHeight:int = 400;                   public var playerWidth:Number = 170;            public var playerHeight:Number = 175;            public var resourceWidth:int = 120;            public var resourceHeight:int = 175;            private var _loadComplete:Boolean = false;            private var _callBack:Function;            private var _sceneCharacterStateSet:SceneCharacterStateSet;            private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;            private var _defaultSceneCharacterStateSet:SceneCharacterStateSet;            private var _defaultSceneCharacterActionSetNatural:SceneCharacterActionSet;            private var _defaultSceneCharacterSetNatural:SceneCharacterSet;            private var _sceneCharacterSetNatural:SceneCharacterSet;            private var _sceneCharacterLoaderHead:LoaderHeadOrBody;            private var _sceneCharacterLoaderBody:LoaderHeadOrBody;            private var _headBitmapData:BitmapData;            private var _bodyBitmapData:BitmapData;            private var _personPos:Point;            private var _mountsPos:Point;            private var _upDownPoints:Vector.<Point>;            protected var playerHitArea:Sprite;            protected var _playerInfo:RoleData;            public function CampBaseRole(playerInfo:RoleData, callBack:Function = null) { super(null); }
            private function initialize() : void { }
            private function initData() : void { }
            private function sceneCharacterLoadHead() : void { }
            private function showDefaultCharacter() : void { }
            private function sceneCharacterLoaderHeadCallBack(sceneCharacterLoaderHead:LoaderHeadOrBody, isAllLoadSucceed:Boolean = true) : void { }
            private function sceneCharacterStateNatural() : void { }
            private function copyVector(vector:Vector.<Point>) : void { }
            private function sceneCharacterLoadBodyNatural() : void { }
            private function sceneCharacterLoaderBodyNaturalCallBack(sceneCharacterLoaderBody:LoaderHeadOrBody, isAllLoadSucceed:Boolean) : void { }
            private function mountsWalkAnimation() : void { }
            private function loadSittingCloths() : void { }
            private function loadRideCloths() : void { }
            private function loadRugCloths() : void { }
            private function loadMountsSaddle() : void { }
            private function saddleLoaderCompleteCallBack(saddleLoader:LoaderHeadOrBody, isAllLoadSucceed:Boolean) : void { }
            private function loadMounts() : void { }
            private function mountsLoaderCompleteCallBack(mountsLoader:LoaderHeadOrBody, isAllLoadSucceed:Boolean) : void { }
            private function setPlayerAndMountsAction() : void { }
            private function callBackSetInfo(loader:LoaderHeadOrBody, isAllLoadSucceed:Boolean) : Boolean { return false; }
            private function peopleWalkAnimation() : void { }
            private function setSceneState() : void { }
            private function createHitArea() : void { }
            protected function __onMouseClick(event:MouseEvent) : void { }
            protected function __onMouseOver(event:MouseEvent) : void { }
            protected function __onMouseOut(event:MouseEvent) : void { }
            private function disposeDefaultSource() : void { }
            override public function dispose() : void { }
   }}