package consortionBattle.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleController;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.event.ConsBatEvent;
   import consortionBattle.player.ConsortiaBattlePlayer;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class ConsortiaBattleMapView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZE:Array = [3208,2000];
       
      
      protected var _mapClassDefinition:String;
      
      protected var _playerModel:DictionaryData;
      
      protected var _bgLayer:Sprite;
      
      protected var _articleLayer:Sprite;
      
      protected var _decorationLayer:Sprite;
      
      protected var _meshLayer:Sprite;
      
      protected var _sceneScene:SceneScene;
      
      protected var _selfPlayer:ConsortiaBattlePlayer;
      
      protected var _lastClick:Number = 0;
      
      protected var _clickInterval:Number = 200;
      
      protected var _mouseMovie:MovieClip;
      
      protected var _characters:DictionaryData;
      
      protected var _clickEnemy:ConsortiaBattlePlayer;
      
      protected var _judgeCreateCount:int = 0;
      
      public function ConsortiaBattleMapView(param1:String, param2:DictionaryData)
      {
         super();
         _mapClassDefinition = param1;
         _playerModel = param2;
         initData();
         initMap();
         initMouseMovie();
         initSceneScene();
         initEvent();
         initBeforeTimeView();
      }
      
      private function initBeforeTimeView() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = ConsortiaBattleManager.instance.beforeStartTime;
         if(_loc1_ > 0)
         {
            _loc2_ = new ConsBatBeforeTimer(_loc1_);
            LayerManager.Instance.addToLayer(_loc2_,3,true);
         }
      }
      
      protected function initData() : void
      {
         _characters = new DictionaryData(true);
      }
      
      protected function initMap() : void
      {
         var _loc4_:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(_mapClassDefinition) as Class)() as MovieClip;
         var _loc1_:Sprite = _loc4_.getChildByName("articleLayer") as Sprite;
         var _loc6_:Sprite = _loc4_.getChildByName("mesh") as Sprite;
         var _loc3_:Sprite = _loc4_.getChildByName("bg") as Sprite;
         var _loc5_:Sprite = _loc4_.getChildByName("bgSize") as Sprite;
         var _loc2_:Sprite = _loc4_.getChildByName("decoration") as Sprite;
         this._bgLayer = _loc3_ == null?new Sprite():_loc3_;
         this._articleLayer = _loc1_ == null?new Sprite():_loc1_;
         this._decorationLayer = _loc2_ == null?new Sprite():_loc2_;
         var _loc7_:Boolean = false;
         this._decorationLayer.mouseEnabled = _loc7_;
         this._decorationLayer.mouseChildren = _loc7_;
         this._meshLayer = _loc6_ == null?new Sprite():_loc6_;
         this._meshLayer.alpha = 0;
         this._meshLayer.mouseChildren = false;
         this._meshLayer.mouseEnabled = false;
         this.addChild(_bgLayer);
         this.addChild(_articleLayer);
         this.addChild(_decorationLayer);
         this.addChild(_meshLayer);
         if(_loc5_)
         {
            MAP_SIZE[0] = _loc5_.width;
            MAP_SIZE[1] = _loc5_.height;
         }
         else
         {
            MAP_SIZE[0] = _loc3_.width;
            MAP_SIZE[1] = _loc3_.height;
         }
      }
      
      protected function initMouseMovie() : void
      {
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.consortiaBattle.MouseClickMovie") as Class;
         _mouseMovie = new _loc1_() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         _bgLayer.addChild(_mouseMovie);
      }
      
      protected function initSceneScene() : void
      {
         _sceneScene = new SceneScene();
         _sceneScene.setHitTester(new PathMapHitTester(this._meshLayer));
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _playerModel.addEventListener("add",__addPlayer);
         _playerModel.addEventListener("remove",__removePlayer);
         _playerModel.addEventListener("update",__updatePlayerStatus);
         addEventListener("consBatPlayerClick",playerClickHandler);
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleMovePlayer",movePlayer);
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleHideRecordChange",hidePlayer);
         PlayerManager.Instance.addEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void
      {
         __click(param1.data[0]);
      }
      
      private function hidePlayer(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var _loc2_ in _characters)
         {
            _loc2_.visible = ConsortiaBattleController.instance.judgePlayerVisible(_loc2_);
         }
      }
      
      private function playerClickHandler(param1:Event) : void
      {
         _clickEnemy = param1.target as ConsortiaBattlePlayer;
      }
      
      protected function __addPlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:ConsortiaBattlePlayerInfo = param1.data as ConsortiaBattlePlayerInfo;
         var _loc3_:ConsortiaBattlePlayer = new ConsortiaBattlePlayer(_loc2_,addPlayerCallBack);
      }
      
      protected function addPlayerCallBack(param1:ConsortiaBattlePlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            if(!_articleLayer || !param1)
            {
               return;
            }
            param1.playerPoint = param1.playerData.pos;
            param1.sceneCharacterStateType = "natural";
            var _loc4_:* = SceneCharacterDirection.RB;
            param1.sceneCharacterDirection = _loc4_;
            param1.setSceneCharacterDirectionDefault = _loc4_;
            if(!_selfPlayer && param1.playerData.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer = param1;
               _articleLayer.addChild(_selfPlayer);
               _selfPlayer.addEventListener("characterMovement",setCenter);
               _loc4_ = false;
               _selfPlayer.mouseChildren = _loc4_;
               _selfPlayer.mouseEnabled = _loc4_;
               setCenter(null,false);
               _selfPlayer.addEventListener("characterActionChange",playerActionChange);
               SocketManager.Instance.out.sendConsBatRequestPlayerInfo();
               SocketManager.Instance.out.sendConsBatConfirmEnter();
            }
            else
            {
               _articleLayer.addChild(param1);
               param1.mouseEnabled = false;
            }
            _characters.add(param1.playerData.id,param1);
         }
      }
      
      protected function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:int = (param1.data as ConsortiaBattlePlayerInfo).id;
         var _loc3_:ConsortiaBattlePlayer = _characters[_loc2_] as ConsortiaBattlePlayer;
         _characters.remove(_loc2_);
         if(_loc3_ == _clickEnemy)
         {
            _clickEnemy = null;
         }
         if(_loc3_)
         {
            if(_loc3_.parent)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.removeEventListener("characterMovement",setCenter);
            _loc3_.removeEventListener("characterActionChange",playerActionChange);
            _loc3_.dispose();
         }
         _loc3_ = null;
      }
      
      protected function __updatePlayerStatus(param1:DictionaryEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = (param1.data as ConsortiaBattlePlayerInfo).id;
         if(_characters[_loc2_])
         {
            _loc3_ = _characters[_loc2_] as ConsortiaBattlePlayer;
            _loc3_.refreshStatus();
         }
      }
      
      private function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack")
         {
            if(_mouseMovie)
            {
               _mouseMovie.gotoAndStop(1);
            }
         }
      }
      
      public function setCenter(param1:SceneCharacterEvent = null, param2:Boolean = true, param3:Point = null) : void
      {
         var _loc6_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = null;
         if(!_selfPlayer && !param3 || param2 && ConsortiaBattleManager.instance.beforeStartTime > 0)
         {
            return;
         }
         if(_selfPlayer)
         {
            _loc5_ = _selfPlayer.playerPoint;
         }
         else
         {
            _loc5_ = param3;
         }
         _loc6_ = Number(-(_loc5_.x - 1000 / 2));
         _loc4_ = Number(-(_loc5_.y - 600 / 2) + 50);
         if(_loc6_ > 0)
         {
            _loc6_ = 0;
         }
         if(_loc6_ < 1000 - MAP_SIZE[0])
         {
            _loc6_ = Number(1000 - MAP_SIZE[0]);
         }
         if(_loc4_ > 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ < 600 - MAP_SIZE[1])
         {
            _loc4_ = Number(600 - MAP_SIZE[1]);
         }
         x = _loc6_;
         y = _loc4_;
      }
      
      protected function __click(param1:MouseEvent) : void
      {
         if(!_selfPlayer || !_selfPlayer.isCanWalk)
         {
            return;
         }
         var _loc2_:Point = this.globalToLocal(new Point(param1.stageX,param1.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!_sceneScene.hit(_loc2_))
            {
               _selfPlayer.playerData.walkPath = _sceneScene.searchPath(_selfPlayer.playerPoint,_loc2_);
               _selfPlayer.playerData.walkPath.shift();
               _selfPlayer.playerData.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerData.walkPath.concat());
               _mouseMovie.x = _loc2_.x;
               _mouseMovie.y = _loc2_.y;
               _mouseMovie.play();
            }
         }
      }
      
      protected function sendMyPosition(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         while(_loc4_ < param1.length)
         {
            _loc2_.push(int(param1[_loc4_].x),int(param1[_loc4_].y));
            _loc4_++;
         }
         var _loc3_:String = _loc2_.toString();
         SocketManager.Instance.out.sendConsBatMove(param1[param1.length - 1].x,param1[param1.length - 1].y,_loc3_);
      }
      
      protected function movePlayer(param1:ConsBatEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = param1.data.id;
         var _loc3_:Array = param1.data.path;
         if(_characters[_loc2_])
         {
            _loc4_ = _characters[_loc2_] as ConsortiaBattlePlayer;
            _loc4_.playerData.walkPath = _loc3_;
            _loc4_.isWalkPathChange = true;
            _loc4_.playerWalk(_loc3_);
         }
      }
      
      protected function updateMap(param1:Event) : void
      {
         _judgeCreateCount = Number(_judgeCreateCount) + 1;
         if(_judgeCreateCount > 25)
         {
            ConsortiaBattleManager.instance.judgeCreatePlayer(this.x,this.y);
            _judgeCreateCount = 0;
         }
         if(!_characters || _characters.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var _loc2_ in _characters)
         {
            _loc2_.updatePlayer();
         }
         BuildEntityDepth();
         judgeEnemy();
      }
      
      protected function judgeEnemy() : void
      {
         if(!_clickEnemy || !_selfPlayer)
         {
            return;
         }
         if(Point.distance(new Point(_selfPlayer.x,_selfPlayer.y),new Point(_clickEnemy.x,_clickEnemy.y)) < 100)
         {
            SocketManager.Instance.out.sendConsBatChallenge(_clickEnemy.playerData.id);
            _clickEnemy = null;
         }
      }
      
      protected function BuildEntityDepth() : void
      {
         var _loc9_:int = 0;
         var _loc4_:* = null;
         var _loc8_:Number = NaN;
         var _loc7_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Number = NaN;
         var _loc2_:int = _articleLayer.numChildren;
         _loc9_ = 0;
         while(_loc9_ < _loc2_ - 1)
         {
            _loc4_ = _articleLayer.getChildAt(_loc9_);
            _loc8_ = this.getPointDepth(_loc4_.x,_loc4_.y);
            _loc5_ = 1.79769313486232e308;
            _loc6_ = _loc9_ + 1;
            while(_loc6_ < _loc2_)
            {
               _loc3_ = _articleLayer.getChildAt(_loc6_);
               _loc1_ = this.getPointDepth(_loc3_.x,_loc3_.y);
               if(_loc1_ < _loc5_)
               {
                  _loc7_ = _loc6_;
                  _loc5_ = _loc1_;
               }
               _loc6_++;
            }
            if(_loc8_ > _loc5_)
            {
               _articleLayer.swapChildrenAt(_loc9_,_loc7_);
            }
            _loc9_++;
         }
      }
      
      protected function getPointDepth(param1:Number, param2:Number) : Number
      {
         return MAP_SIZE[0] * param2 + param1;
      }
      
      public function addSelfPlayer() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!_selfPlayer)
         {
            _loc2_ = ConsortiaBattleManager.instance.getPlayerInfo(PlayerManager.Instance.Self.ID);
            _loc1_ = new ConsortiaBattlePlayer(_loc2_,addPlayerCallBack);
            setCenter(null,false,_loc2_.pos);
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__click);
         removeEventListener("enterFrame",updateMap);
         if(_playerModel)
         {
            _playerModel.removeEventListener("add",__addPlayer);
         }
         if(_playerModel)
         {
            _playerModel.removeEventListener("remove",__removePlayer);
         }
         if(_playerModel)
         {
            _playerModel.removeEventListener("update",__updatePlayerStatus);
         }
         removeEventListener("consBatPlayerClick",playerClickHandler);
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleMovePlayer",movePlayer);
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleHideRecordChange",hidePlayer);
         PlayerManager.Instance.removeEventListener("setselfplayerpos",__onSetSelfPlayerPos);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _playerModel = null;
         if(_mouseMovie)
         {
            _mouseMovie.gotoAndStop(1);
         }
         ObjectUtils.disposeAllChildren(_articleLayer);
         ObjectUtils.disposeAllChildren(this);
         if(_sceneScene)
         {
            _sceneScene.dispose();
         }
         _bgLayer = null;
         _articleLayer = null;
         _decorationLayer = null;
         _meshLayer = null;
         _sceneScene = null;
         _selfPlayer = null;
         _clickEnemy = null;
         _mouseMovie = null;
         _characters = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
