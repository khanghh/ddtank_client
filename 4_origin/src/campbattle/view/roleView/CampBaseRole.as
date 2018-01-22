package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterActionItem;
   import ddt.view.sceneCharacter.SceneCharacterActionSet;
   import ddt.view.sceneCharacter.SceneCharacterItem;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.sceneCharacter.SceneCharacterSet;
   import ddt.view.sceneCharacter.SceneCharacterStateItem;
   import ddt.view.sceneCharacter.SceneCharacterStateSet;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import hall.player.HallPlayerView;
   import horse.HorseManager;
   
   public class CampBaseRole extends SceneCharacterPlayerBase
   {
      
      private static var MountsWidth:int = 500;
      
      private static var MountsHeight:int = 400;
       
      
      public var playerWidth:Number = 170;
      
      public var playerHeight:Number = 175;
      
      public var resourceWidth:int = 120;
      
      public var resourceHeight:int = 175;
      
      private var _loadComplete:Boolean = false;
      
      private var _callBack:Function;
      
      private var _sceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _sceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterStateSet:SceneCharacterStateSet;
      
      private var _defaultSceneCharacterActionSetNatural:SceneCharacterActionSet;
      
      private var _defaultSceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterSetNatural:SceneCharacterSet;
      
      private var _sceneCharacterLoaderHead:LoaderHeadOrBody;
      
      private var _sceneCharacterLoaderBody:LoaderHeadOrBody;
      
      private var _headBitmapData:BitmapData;
      
      private var _bodyBitmapData:BitmapData;
      
      private var _personPos:Point;
      
      private var _mountsPos:Point;
      
      private var _upDownPoints:Vector.<Point>;
      
      protected var playerHitArea:Sprite;
      
      protected var _playerInfo:RoleData;
      
      public function CampBaseRole(param1:RoleData, param2:Function = null)
      {
         super(param2);
         _playerInfo = param1;
         _callBack = param2;
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
         if(_playerInfo.IsMounts)
         {
            playerWidth = 500;
            playerHeight = 225;
         }
         else
         {
            playerWidth = 120;
            _personPos = new Point(0,0);
         }
      }
      
      private function sceneCharacterLoadHead() : void
      {
         _sceneCharacterLoaderHead = new LoaderHeadOrBody(_playerInfo,1);
         _sceneCharacterLoaderHead.load(sceneCharacterLoaderHeadCallBack);
         if(!_loadComplete)
         {
            _headBitmapData = ComponentFactory.Instance.creatBitmapData("game.player.defaultPlayerCharacter");
            showDefaultCharacter();
         }
      }
      
      private function showDefaultCharacter() : void
      {
         var _loc6_:* = null;
         _defaultSceneCharacterSetNatural = new SceneCharacterSet();
         var _loc2_:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         _loc6_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc6_.copyPixels(_headBitmapData,_loc2_,new Point(25,20));
         _defaultSceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",_loc6_,1,1,playerWidth,playerHeight,1));
         var _loc5_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(_loc5_);
         var _loc4_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(_loc4_);
         var _loc3_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[0],false);
         _defaultSceneCharacterActionSetNatural.push(_loc3_);
         var _loc1_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[0],false);
         _defaultSceneCharacterActionSetNatural.push(_loc1_);
         var _loc7_:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_defaultSceneCharacterSetNatural,_defaultSceneCharacterActionSetNatural);
         _defaultSceneCharacterStateSet.push(_loc7_);
         .super.loadComplete = false;
         .super.isDefaultCharacter = true;
         .super.sceneCharacterStateSet = _defaultSceneCharacterStateSet;
      }
      
      private function sceneCharacterLoaderHeadCallBack(param1:LoaderHeadOrBody, param2:Boolean = true) : void
      {
         _headBitmapData = param1.getContent()[0] as BitmapData;
         if(param1)
         {
            param1.dispose();
         }
         if(!param2 || !_headBitmapData)
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
         var _loc2_:* = null;
         _sceneCharacterSetNatural = new SceneCharacterSet();
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
         var _loc1_:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_headBitmapData,_loc1_,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontHead","NaturalFrontAction",_loc2_,1,1,playerWidth,playerHeight,1,_upDownPoints,true,7));
         _loc1_.x = resourceWidth;
         _loc1_.y = 0;
         _loc1_.width = resourceWidth;
         _loc1_.height = resourceHeight;
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_headBitmapData,_loc1_,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseHead","NaturalFrontEyesCloseAction",_loc2_,1,1,playerWidth,playerHeight,2));
         if(_playerInfo && !_playerInfo.IsMounts)
         {
            _loc1_.x = resourceWidth * 2;
            _loc1_.y = 0;
            _loc1_.width = resourceWidth;
            _loc1_.height = resourceHeight;
            _loc2_ = new BitmapData(resourceWidth,resourceHeight * 2,true,0);
            _loc2_.copyPixels(_headBitmapData,_loc1_,_personPos);
            _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackHead","NaturalBackAction",_loc2_,1,1,playerWidth,playerHeight,6,_upDownPoints,true,7));
         }
         sceneCharacterLoadBodyNatural();
      }
      
      private function copyVector(param1:Vector.<Point>) : void
      {
         var _loc2_:int = 0;
         _upDownPoints = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _upDownPoints.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function sceneCharacterLoadBodyNatural() : void
      {
         _sceneCharacterLoaderBody = new LoaderHeadOrBody(_playerInfo,2);
         _sceneCharacterLoaderBody.load(sceneCharacterLoaderBodyNaturalCallBack);
      }
      
      private function sceneCharacterLoaderBodyNaturalCallBack(param1:LoaderHeadOrBody, param2:Boolean) : void
      {
         if(!callBackSetInfo(param1,param2))
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
         var _loc2_:* = null;
         var _loc1_:Point = PositionUtils.creatPoint("hall.playerView.bodyPos2");
         var _loc3_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc3_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc2_,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var _loc4_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc4_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc2_,1,1,playerWidth,playerHeight,10));
         loadMounts();
      }
      
      private function loadRideCloths() : void
      {
         var _loc2_:* = null;
         var _loc1_:Point = PositionUtils.creatPoint("hall.playerView.bodyPos");
         var _loc5_:Rectangle = new Rectangle(_bodyBitmapData.width / 3 * 2,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc5_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc2_,1,1,playerWidth,playerHeight,3,_upDownPoints,true,7));
         var _loc6_:Rectangle = new Rectangle(_bodyBitmapData.width / 3 * 2,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc6_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc2_,1,1,playerWidth,playerHeight,4));
         var _loc3_:Rectangle = new Rectangle(_bodyBitmapData.width / 3,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc3_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc2_,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var _loc4_:Rectangle = new Rectangle(_bodyBitmapData.width / 3,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc4_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc2_,1,1,playerWidth,playerHeight,10));
         loadMounts();
      }
      
      private function loadRugCloths() : void
      {
         var _loc2_:* = null;
         var _loc1_:Point = PositionUtils.creatPoint("hall.playerView.bodyPos");
         var _loc3_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc3_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc2_,1,1,playerWidth,playerHeight,9,_upDownPoints,true,7));
         var _loc4_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width / 3,_bodyBitmapData.height);
         _loc2_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc2_.copyPixels(_bodyBitmapData,_loc4_,_loc1_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc2_,1,1,playerWidth,playerHeight,10));
         loadMountsSaddle();
      }
      
      private function loadMountsSaddle() : void
      {
         var _loc1_:LoaderHeadOrBody = new LoaderHeadOrBody(_playerInfo,3);
         _loc1_.load(saddleLoaderCompleteCallBack);
      }
      
      private function saddleLoaderCompleteCallBack(param1:LoaderHeadOrBody, param2:Boolean) : void
      {
         var _loc4_:* = null;
         if(!callBackSetInfo(param1,param2))
         {
            return;
         }
         var _loc3_:Point = PositionUtils.creatPoint("hall.playerView.saddlePos");
         var _loc5_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         _loc4_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc4_.copyPixels(_bodyBitmapData,_loc5_,_loc3_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontSaddle","NaturalFrontAction",_loc4_,1,1,playerWidth,playerHeight,7,_upDownPoints,true,7));
         var _loc6_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         _loc4_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc4_.copyPixels(_bodyBitmapData,_loc6_,_loc3_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseSaddle","NaturalFrontEyesCloseAction",_loc4_,1,1,playerWidth,playerHeight,8));
         loadMounts();
      }
      
      private function loadMounts() : void
      {
         var _loc1_:LoaderHeadOrBody = new LoaderHeadOrBody(_playerInfo,4);
         _loc1_.load(mountsLoaderCompleteCallBack);
      }
      
      private function mountsLoaderCompleteCallBack(param1:LoaderHeadOrBody, param2:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         if(!callBackSetInfo(param1,param2))
         {
            return;
         }
         if(_playerInfo.MountsType == 106)
         {
            _loc6_ = new Point(_mountsPos.x,_mountsPos.y - 5);
         }
         else if(_playerInfo.MountsType == 131 || _playerInfo.MountsType == 133)
         {
            _loc6_ = new Point(_mountsPos.x,_mountsPos.y - 15);
         }
         else
         {
            _loc6_ = _mountsPos;
         }
         var _loc4_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,_bodyBitmapData.height);
         _loc3_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc3_.copyPixels(_bodyBitmapData,_loc4_,_loc6_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontMounts","NaturalFrontAction",_loc3_,1,7,playerWidth,playerHeight,5));
         var _loc5_:Rectangle = new Rectangle(0,0,MountsWidth,MountsHeight);
         _loc3_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc3_.copyPixels(_bodyBitmapData,_loc5_,_loc6_);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseMounts","NaturalFrontEyesCloseAction",_loc3_,1,1,playerWidth,playerHeight,6));
         setPlayerAndMountsAction();
      }
      
      private function setPlayerAndMountsAction() : void
      {
         var _loc2_:* = null;
         if(HorseManager.instance.getIsShakeRide(_playerInfo.MountsType))
         {
            _loc2_ = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6,0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6,7,7,7,0,0,0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6],true);
         }
         else if(_playerInfo.MountsType == 130 || _playerInfo.MountsType == 131 || _playerInfo.MountsType == 134 || _playerInfo.MountsType == 133)
         {
            _loc2_ = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],true);
         }
         else
         {
            _loc2_ = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         }
         _sceneCharacterActionSetNatural.push(_loc2_);
         var _loc1_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(_loc1_);
         setSceneState();
      }
      
      private function callBackSetInfo(param1:LoaderHeadOrBody, param2:Boolean) : Boolean
      {
         if(!_sceneCharacterSetNatural)
         {
            return false;
         }
         _bodyBitmapData = param1.getContent()[0] as BitmapData;
         if(param1)
         {
            param1.dispose();
         }
         if(!param2 || !_bodyBitmapData)
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
         var _loc5_:* = null;
         var _loc7_:Rectangle = new Rectangle(0,0,_bodyBitmapData.width,resourceHeight);
         _loc5_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc5_.copyPixels(_bodyBitmapData,_loc7_,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontBody","NaturalFrontAction",_loc5_,1,7,playerWidth,playerHeight,3));
         var _loc8_:Rectangle = new Rectangle(0,0,resourceWidth,resourceHeight);
         _loc5_ = new BitmapData(playerWidth,playerHeight,true,0);
         _loc5_.copyPixels(_bodyBitmapData,_loc8_,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalFrontEyesCloseBody","NaturalFrontEyesCloseAction",_loc5_,1,1,playerWidth,playerHeight,4));
         var _loc6_:Rectangle = new Rectangle(0,resourceHeight,_bodyBitmapData.width,resourceHeight);
         _loc5_ = new BitmapData(_bodyBitmapData.width,playerHeight,true,0);
         _loc5_.copyPixels(_bodyBitmapData,_loc6_,_personPos);
         _sceneCharacterSetNatural.push(new SceneCharacterItem("NaturalBackBody","NaturalBackAction",_loc5_,1,7,playerWidth,playerHeight,5));
         var _loc4_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandFront",[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7],true);
         _sceneCharacterActionSetNatural.push(_loc4_);
         var _loc3_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalStandBack",[8],false);
         _sceneCharacterActionSetNatural.push(_loc3_);
         var _loc2_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkFront",[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6],true);
         _sceneCharacterActionSetNatural.push(_loc2_);
         var _loc1_:SceneCharacterActionItem = new SceneCharacterActionItem("naturalWalkBack",[9,9,9,10,10,10,11,11,11,12,12,12,13,13,13,14,14,14],true);
         _sceneCharacterActionSetNatural.push(_loc1_);
      }
      
      private function setSceneState() : void
      {
         _loadComplete = true;
         var _loc1_:SceneCharacterStateItem = new SceneCharacterStateItem("natural",_sceneCharacterSetNatural,_sceneCharacterActionSetNatural);
         _sceneCharacterStateSet.push(_loc1_);
         .super.loadComplete = true;
         .super.isDefaultCharacter = false;
         .super.sceneCharacterStateSet = _sceneCharacterStateSet;
         disposeDefaultSource();
         createHitArea();
      }
      
      private function createHitArea() : void
      {
         if(_playerInfo.ID != PlayerManager.Instance.Self.ID && _sceneCharacterStateSet.dataSet[0].frameBitmap.length > 0)
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
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         setCharacterFilter(true);
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
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
