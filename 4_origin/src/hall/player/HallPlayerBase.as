package hall.player
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import horse.HorseManager;
   
   public class HallPlayerBase extends SceneCharacterPlayerBase
   {
      
      private static var MountsWidth:int = 500;
      
      private static var MountsHeight:int = 400;
       
      
      public var playerWidth:Number = 170;
      
      public var playerHeight:Number = 175;
      
      public var resourceWidth:int = 120;
      
      public var resourceHeight:int = 175;
      
      private var _loadComplete:Boolean = false;
      
      private var _playerInfo:PlayerInfo;
      
      private var _callBack:Function;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _defaultSceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterLoaderHead:SceneCharacterLoaderHead;
      
      private var _sceneCharacterLoaderBody:HallSceneCharacterLoaderLayer;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _personPos:Point;
      
      private var _mountsPos:Point;
      
      private var _upDownPoints:Vector.<Point>;
      
      protected var playerHitArea:Sprite;
      
      public function HallPlayerBase(playerInfo:PlayerInfo, callBack:Function = null)
      {
         super(callBack);
         _playerInfo = playerInfo;
         _callBack = callBack;
         initialize();
         var _loc3_:Boolean = false;
         this.character.mouseEnabled = _loc3_;
         this.character.mouseChildren = _loc3_;
      }
      
      private function initialize() : void
      {
         _sceneCharacterStateSet = new SceneCharacterStateSet();
         _sceneCharacterActionSetNatural = new SceneCharacterActionSet();
         _defaultSceneCharacterStateSet = new SceneCharacterStateSet();
         _defaultSceneCharacterActionSetNatural = new SceneCharacterActionSet();
         playerHitArea = new Sprite();
         initData();
         sceneCharacterLoadHead();
      }
      
      private function initData() : void
      {
         _personPos = PositionUtils.creatPoint("hall.playerView.headPos");
         if(_playerInfo.MountsType > 100)
         {
            if(_playerInfo.MountsType >= 222)
            {
               copyVector(HallPlayerView.horsePicCherishPointsArray[25]);
            }
            else
            {
               copyVector(HallPlayerView.horsePicCherishPointsArray[_playerInfo.MountsType - 101]);
            }
         }
         else
         {
            copyVector(HallPlayerView.pointsArray[_playerInfo.MountsType]);
         }
         if(_playerInfo.IsMounts)
         {
            playerWidth = 500;
            if(_playerInfo.MountsType == 113)
            {
               playerHeight = 205;
            }
            else if(_playerInfo.MountsType == 141)
            {
               playerHeight = 255;
            }
            else
            {
               playerHeight = 225;
            }
         }
         else
         {
            playerWidth = 120;
            _personPos = new Point(0,0);
         }
      }
      
      private function sceneCharacterLoadHead() : void
      {
         _sceneCharacterLoaderHead = new SceneCharacterLoaderHead(_playerInfo);
         _sceneCharacterLoaderHead.load(sceneCharacterLoaderHeadCallBack);
         if(!_loadComplete)
         {
            _headBitmapData = ComponentFactory.Instance.creatBitmapData("game.player.defaultPlayerCharacter");
            showDefaultCharacter();
         }
      }
      
      private function showDefaultCharacter() : void
      {
         var actionBmp:* = null;
         _defaultSceneCharacterSetNatural = new SceneCharacterSet();
         var rectangle:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,rectangle,new Point(25,20));
         _defaultSceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,1));
         var sceneCharacterActionItem1:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem2);
         var sceneCharacterActionItem3:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem3);
         var sceneCharacterActionItem4:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(sceneCharacterActionItem4);
         var _sceneCharacterStateItemNatural:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_defaultSceneCharacterSetNatural,_defaultSceneCharacterActionSetNatural);
         _defaultSceneCharacterStateSet.push(_sceneCharacterStateItemNatural);
         .super.loadComplete = false;
         .super.isDefaultCharacter = true;
         .super.sceneCharacterStateSet = _defaultSceneCharacterStateSet;
      }
      
      private function sceneCharacterLoaderHeadCallBack(sceneCharacterLoaderHead:SceneCharacterLoaderHead, isAllLoadSucceed:Boolean = true) : void
      {
         _headBitmapData = sceneCharacterLoaderHead.getContent()[0] as BitmapData;
         if(sceneCharacterLoaderHead)
         {
            sceneCharacterLoaderHead.dispose();
         }
         if(!isAllLoadSucceed || !_headBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false,-1);
            }
            return;
         }
         if(_playerInfo)
         {
            sceneCharacterStateNatural();
         }
      }
      
      private function sceneCharacterStateNatural() : void
      {
         var actionBmp:* = null;
         var points:* = undefined;
         _sceneCharacterSetNatural = new SceneCharacterSet();
         var rectangle:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,rectangle,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,1,_upDownPoints,true,7));
         rectangle.x = resourceWidth;
         rectangle.y = 0;
         rectangle.width = resourceWidth;
         rectangle.height = resourceHeight;
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_headBitmapData,rectangle,_personPos);
         if(_playerInfo.MountsType == 121)
         {
            points = _upDownPoints;
         }
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,2,points));
         if(_playerInfo && !_playerInfo.IsMounts)
         {
            rectangle.x = resourceWidth * 2;
            rectangle.y = 0;
            rectangle.width = resourceWidth;
            rectangle.height = resourceHeight;
            actionBmp = new BitmapData(resourceWidth,resourceHeight * 2,true,0);
            actionBmp.copyPixels(_headBitmapData,rectangle,_personPos);
            _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",actionBmp,1,1,playerWidth,playerHeight,6,_upDownPoints,true,7));
         }
         sceneCharacterLoadBodyNatural();
      }
      
      private function sceneCharacterLoadBodyNatural() : void
      {
         _sceneCharacterLoaderBody = new HallSceneCharacterLoaderLayer(_playerInfo);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(sceneCharacterLoaderBody:HallSceneCharacterLoaderLayer, isAllLoadSucceed:Boolean) : void
      {
         if(!callBackSetInfo(sceneCharacterLoaderBody,isAllLoadSucceed))
         {
            return;
         }
         if(_playerInfo.IsMounts)
         {
            mountsWalkAnimation();
         }
         else
         {
            peopleWalkAnimation();
            setSceneState();
         }
      }
      
      private function mountsWalkAnimation() : void
      {
         if(HorseManager.instance.getIsSit(_playerInfo.MountsType))
         {
            if(_playerInfo.MountsType == 140)
            {
               _mountsPos = PositionUtils.creatPoint("hall.playerView.mounts3Pos");
               loadSittingCloths();
            }
            else
            {
               _mountsPos = PositionUtils.creatPoint("hall.playerView.mountsPos");
               loadRugCloths();
            }
         }
         else
         {
            _mountsPos = PositionUtils.creatPoint("hall.playerView.mounts2Pos");
            loadRideCloths();
         }
      }
      
      private function loadSittingCloths() : void
      {
         var actionBmp:* = null;
         var point:Point = PositionUtils.creatPoint("hall.playerView.bodyPos2");
         var rectangle1:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var rectangle2:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,10));
         loadMounts();
      }
      
      private function loadRideCloths() : void
      {
         var points:* = undefined;
         var actionBmp:* = null;
         if(_playerInfo.MountsType == 121)
         {
            points = _upDownPoints;
         }
         var point:Point = PositionUtils.creatPoint("hall.playerView.bodyPos");
         var rectangle1:Rectangle = new Rectangle(_bodyBitmapData.width / 3 * 2,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,3,_upDownPoints,true,7));
         var rectangle2:Rectangle = new Rectangle(_bodyBitmapData.width / 3 * 2,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,4,points));
         var rectangle3:Rectangle = new Rectangle(_bodyBitmapData.width / 3,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle3,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var rectangle4:Rectangle = new Rectangle(_bodyBitmapData.width / 3,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle4,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,10,points));
         loadMounts();
      }
      
      private function loadRugCloths() : void
      {
         var actionBmp:* = null;
         var point:Point = PositionUtils.creatPoint("hall.playerView.bodyPos");
         var rectangle1:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var rectangle2:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,10));
         loadMountsSaddle();
      }
      
      private function loadMountsSaddle() : void
      {
         var saddleLoader:HallSceneCharacterLoaderLayer = new HallSceneCharacterLoaderLayer(_playerInfo,1);
         saddleLoader.load(saddleLoaderCompleteCallBack);
      }
      
      private function saddleLoaderCompleteCallBack(saddleLoader:HallSceneCharacterLoaderLayer, isAllLoadSucceed:Boolean) : void
      {
         var actionBmp:* = null;
         if(!callBackSetInfo(saddleLoader,isAllLoadSucceed))
         {
            return;
         }
         var point:Point = PositionUtils.creatPoint("hall.playerView.saddlePos");
         var rectangle1:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontSaddle","NaturalFrontAction",actionBmp,1,1,playerWidth,playerHeight,7,_upDownPoints,true,7));
         var rectangle2:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,point);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseSaddle","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,8));
         loadMounts();
      }
      
      private function loadMounts() : void
      {
         var mountsLoader:HallSceneCharacterLoaderLayer = new HallSceneCharacterLoaderLayer(_playerInfo,2);
         mountsLoader.load(mountsLoaderCompleteCallBack);
      }
      
      private function mountsLoaderCompleteCallBack(mountsLoader:HallSceneCharacterLoaderLayer, isAllLoadSucceed:Boolean) : void
      {
         var actionBmp:* = null;
         var pos:* = null;
         if(!callBackSetInfo(mountsLoader,isAllLoadSucceed))
         {
            return;
         }
         var rectangle1:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         if(_playerInfo.MountsType == 106)
         {
            pos = new Point(_mountsPos.x,_mountsPos.y - 5);
         }
         else if(_playerInfo.MountsType == 131 || _playerInfo.MountsType == 133 || _playerInfo.MountsType == 136)
         {
            pos = new Point(_mountsPos.x,_mountsPos.y - 15);
         }
         else
         {
            pos = _mountsPos;
         }
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,pos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontMounts","NaturalFrontAction",actionBmp,1,7,playerWidth,playerHeight,5));
         var rectangle2:Rectangle = new Rectangle(0,0,MountsWidth,MountsHeight);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,pos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseMounts","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,6));
         setPlayerAndMountsAction();
      }
      
      private function setPlayerAndMountsAction() : void
      {
         var sceneCharacterActionItem1:* = null;
         if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType))
         {
            sceneCharacterActionItem1 = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6],true);
         }
         else if(HorseManager.instance.getIsKeepMovingRide(_playerInfo.MountsType))
         {
            sceneCharacterActionItem1 = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6],true);
         }
         else if(_playerInfo.MountsType == 130 || _playerInfo.MountsType == 131 || _playerInfo.MountsType == 134 || _playerInfo.MountsType == 133)
         {
            sceneCharacterActionItem1 = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],true);
         }
         else
         {
            sceneCharacterActionItem1 = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         }
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem2);
         setSceneState();
      }
      
      private function callBackSetInfo(loader:HallSceneCharacterLoaderLayer, isAllLoadSucceed:Boolean) : Boolean
      {
         if(!_sceneCharacterSetNatural)
         {
            return false;
         }
         _bodyBitmapData = loader.getContent()[0] as BitmapData;
         if(loader)
         {
            loader.dispose();
         }
         if(!isAllLoadSucceed || !_bodyBitmapData)
         {
            if(_callBack != null)
            {
               _callBack(this,false,-1);
            }
            return false;
         }
         return true;
      }
      
      private function peopleWalkAnimation() : void
      {
         var actionBmp:* = null;
         var rectangle1:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,resourceHeight);
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle1,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",actionBmp,1,7,playerWidth,playerHeight,3));
         var rectangle2:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         actionBmp = new BitmapData(playerWidth,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle2,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",actionBmp,1,1,playerWidth,playerHeight,4));
         var rectangle3:Rectangle = new Rectangle(0,resourceHeight,_bodyBitmapData.width,resourceHeight);
         actionBmp = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         actionBmp.copyPixels(_bodyBitmapData,rectangle3,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackBody","NaturalBackAction",actionBmp,1,7,playerWidth,playerHeight,5));
         var sceneCharacterActionItem1:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem1);
         var sceneCharacterActionItem2:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[8],false);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem2);
         var sceneCharacterActionItem3:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem3);
         var sceneCharacterActionItem4:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[9,9,9,10,10,10,11,11,11,12,12,12,13,13,13,14,14,14],true);
         _sceneCharacterActionSetNatural.push(sceneCharacterActionItem4);
      }
      
      private function setSceneState() : void
      {
         _loadComplete = true;
         var sceneCharacterStateItemNatural:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_sceneCharacterSetNatural,_sceneCharacterActionSetNatural);
         _sceneCharacterStateSet.push(sceneCharacterStateItemNatural);
         .super.loadComplete = true;
         .super.isDefaultCharacter = false;
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
         disposeDefaultSource();
         createHitArea();
      }
      
      private function copyVector(vector:Vector.<Point>) : void
      {
         var i:int = 0;
         _upDownPoints = new Vector.<Point>();
         for(i = 0; i < vector.length; )
         {
            _upDownPoints.push(vector[i]);
            i++;
         }
      }
      
      private function createHitArea() : void
      {
         if(!_playerInfo.isSelf && _sceneCharacterStateSet.dataSet[0].frameBitmap.length > 0)
         {
            playerHitArea = PNGHitAreaFactory.drawHitArea(DisplayUtils.getDisplayBitmapData(_sceneCharacterStateSet.dataSet[0].frameBitmap[0]));
            playerHitArea.alpha = 0;
            PositionUtils.setPos(playerHitArea,character);
            playerHitArea.buttonMode = true;
            addChild(playerHitArea);
            playerHitArea.addEventListener("click",__onMouseClick);
            playerHitArea.addEventListener("mouseOver",__onMouseOver);
            playerHitArea.addEventListener("mouseOut",__onMouseOut);
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
      }
      
      protected function __onMouseOver(event:MouseEvent) : void
      {
         setCharacterFilter(true);
      }
      
      protected function __onMouseOut(event:MouseEvent) : void
      {
         setCharacterFilter(false);
      }
      
      private function disposeDefaultSource() : void
      {
         if(_defaultSceneCharacterStateSet)
         {
            _defaultSceneCharacterStateSet.dispose();
         }
         _defaultSceneCharacterStateSet = null;
         if(_defaultSceneCharacterSetNatural)
         {
            _defaultSceneCharacterSetNatural.dispose();
         }
         _defaultSceneCharacterSetNatural = null;
         if(_defaultSceneCharacterActionSetNatural)
         {
            _defaultSceneCharacterActionSetNatural.dispose();
         }
         _defaultSceneCharacterActionSetNatural = null;
      }
      
      override public function dispose() : void
      {
         disposeDefaultSource();
         _playerInfo = null;
         _callBack = null;
         if(_sceneCharacterSetNatural)
         {
            _sceneCharacterSetNatural.dispose();
         }
         _sceneCharacterSetNatural = null;
         if(_sceneCharacterActionSetNatural)
         {
            _sceneCharacterActionSetNatural.dispose();
         }
         _sceneCharacterActionSetNatural = null;
         if(_sceneCharacterStateSet)
         {
            _sceneCharacterStateSet.dispose();
         }
         _sceneCharacterStateSet = null;
         ObjectUtils.disposeObject(_sceneCharacterLoaderBody);
         _sceneCharacterLoaderBody = null;
         ObjectUtils.disposeObject(_sceneCharacterLoaderHead);
         _sceneCharacterLoaderHead = null;
         ObjectUtils.disposeObject(playerHitArea);
         playerHitArea = null;
         if(_headBitmapData)
         {
            _headBitmapData.dispose();
         }
         _headBitmapData = null;
         if(_bodyBitmapData)
         {
            _bodyBitmapData.dispose();
         }
         _bodyBitmapData = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
