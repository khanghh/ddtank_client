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
      
      public function ConsortiaBattleMapView(mapClassDefinition:String, playerModel:DictionaryData)
      {
         super();
         _mapClassDefinition = mapClassDefinition;
         _playerModel = playerModel;
         initData();
         initMap();
         initMouseMovie();
         initSceneScene();
         initEvent();
         initBeforeTimeView();
      }
      
      private function initBeforeTimeView() : void
      {
         var beforeTimeView:* = null;
         var tmpTime:int = ConsortiaBattleManager.instance.beforeStartTime;
         if(tmpTime > 0)
         {
            beforeTimeView = new ConsBatBeforeTimer(tmpTime);
            LayerManager.Instance.addToLayer(beforeTimeView,3,true);
         }
      }
      
      protected function initData() : void
      {
         _characters = new DictionaryData(true);
      }
      
      protected function initMap() : void
      {
         var mapRes:MovieClip = new (ClassUtils.uiSourceDomain.getDefinition(_mapClassDefinition) as Class)() as MovieClip;
         var acticle:Sprite = mapRes.getChildByName("articleLayer") as Sprite;
         var mesh:Sprite = mapRes.getChildByName("mesh") as Sprite;
         var bg:Sprite = mapRes.getChildByName("bg") as Sprite;
         var bgSize:Sprite = mapRes.getChildByName("bgSize") as Sprite;
         var decoration:Sprite = mapRes.getChildByName("decoration") as Sprite;
         this._bgLayer = bg == null?new Sprite():bg;
         this._articleLayer = acticle == null?new Sprite():acticle;
         this._decorationLayer = decoration == null?new Sprite():decoration;
         var _loc7_:Boolean = false;
         this._decorationLayer.mouseEnabled = _loc7_;
         this._decorationLayer.mouseChildren = _loc7_;
         this._meshLayer = mesh == null?new Sprite():mesh;
         this._meshLayer.alpha = 0;
         this._meshLayer.mouseChildren = false;
         this._meshLayer.mouseEnabled = false;
         this.addChild(_bgLayer);
         this.addChild(_articleLayer);
         this.addChild(_decorationLayer);
         this.addChild(_meshLayer);
         if(bgSize)
         {
            MAP_SIZE[0] = bgSize.width;
            MAP_SIZE[1] = bgSize.height;
         }
         else
         {
            MAP_SIZE[0] = bg.width;
            MAP_SIZE[1] = bg.height;
         }
      }
      
      protected function initMouseMovie() : void
      {
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.consortiaBattle.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
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
      
      protected function __onSetSelfPlayerPos(event:NewHallEvent) : void
      {
         __click(event.data[0]);
      }
      
      private function hidePlayer(event:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var tmp in _characters)
         {
            tmp.visible = ConsortiaBattleController.instance.judgePlayerVisible(tmp);
         }
      }
      
      private function playerClickHandler(event:Event) : void
      {
         _clickEnemy = event.target as ConsortiaBattlePlayer;
      }
      
      protected function __addPlayer(event:DictionaryEvent) : void
      {
         var player:ConsortiaBattlePlayerInfo = event.data as ConsortiaBattlePlayerInfo;
         var loadingPlayer:ConsortiaBattlePlayer = new ConsortiaBattlePlayer(player,addPlayerCallBack);
      }
      
      protected function addPlayerCallBack(scencPlayer:ConsortiaBattlePlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!_articleLayer || !scencPlayer)
            {
               return;
            }
            scencPlayer.playerPoint = scencPlayer.playerData.pos;
            scencPlayer.sceneCharacterStateType = "natural";
            var _loc4_:* = SceneCharacterDirection.RB;
            scencPlayer.sceneCharacterDirection = _loc4_;
            scencPlayer.setSceneCharacterDirectionDefault = _loc4_;
            if(!_selfPlayer && scencPlayer.playerData.id == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer = scencPlayer;
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
               _articleLayer.addChild(scencPlayer);
               scencPlayer.mouseEnabled = false;
            }
            _characters.add(scencPlayer.playerData.id,scencPlayer);
         }
      }
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var id:int = (event.data as ConsortiaBattlePlayerInfo).id;
         var player:ConsortiaBattlePlayer = _characters[id] as ConsortiaBattlePlayer;
         _characters.remove(id);
         if(player == _clickEnemy)
         {
            _clickEnemy = null;
         }
         if(player)
         {
            if(player.parent)
            {
               player.parent.removeChild(player);
            }
            player.removeEventListener("characterMovement",setCenter);
            player.removeEventListener("characterActionChange",playerActionChange);
            player.dispose();
         }
         player = null;
      }
      
      protected function __updatePlayerStatus(event:DictionaryEvent) : void
      {
         var player:* = null;
         var id:int = (event.data as ConsortiaBattlePlayerInfo).id;
         if(_characters[id])
         {
            player = _characters[id] as ConsortiaBattlePlayer;
            player.refreshStatus();
         }
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            if(_mouseMovie)
            {
               _mouseMovie.gotoAndStop(1);
            }
         }
      }
      
      public function setCenter(event:SceneCharacterEvent = null, isReturn:Boolean = true, pos:Point = null) : void
      {
         var xf:* = NaN;
         var yf:* = NaN;
         var tmpPos:* = null;
         if(!_selfPlayer && !pos || isReturn && ConsortiaBattleManager.instance.beforeStartTime > 0)
         {
            return;
         }
         if(_selfPlayer)
         {
            tmpPos = _selfPlayer.playerPoint;
         }
         else
         {
            tmpPos = pos;
         }
         xf = Number(-(tmpPos.x - 1000 / 2));
         yf = Number(-(tmpPos.y - 600 / 2) + 50);
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - MAP_SIZE[0])
         {
            xf = Number(1000 - MAP_SIZE[0]);
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < 600 - MAP_SIZE[1])
         {
            yf = Number(600 - MAP_SIZE[1]);
         }
         x = xf;
         y = yf;
      }
      
      protected function __click(event:MouseEvent) : void
      {
         if(!_selfPlayer || !_selfPlayer.isCanWalk)
         {
            return;
         }
         var targetPoint:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!_sceneScene.hit(targetPoint))
            {
               _selfPlayer.playerData.walkPath = _sceneScene.searchPath(_selfPlayer.playerPoint,targetPoint);
               _selfPlayer.playerData.walkPath.shift();
               _selfPlayer.playerData.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerData.walkPath.concat());
               _mouseMovie.x = targetPoint.x;
               _mouseMovie.y = targetPoint.y;
               _mouseMovie.play();
            }
         }
      }
      
      protected function sendMyPosition(p:Array) : void
      {
         var i:int = 0;
         var arr:Array = [];
         while(i < p.length)
         {
            arr.push(int(p[i].x),int(p[i].y));
            i++;
         }
         var pathStr:String = arr.toString();
         SocketManager.Instance.out.sendConsBatMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      protected function movePlayer(event:ConsBatEvent) : void
      {
         var tmpPlayer:* = null;
         var id:int = event.data.id;
         var p:Array = event.data.path;
         if(_characters[id])
         {
            tmpPlayer = _characters[id] as ConsortiaBattlePlayer;
            tmpPlayer.playerData.walkPath = p;
            tmpPlayer.isWalkPathChange = true;
            tmpPlayer.playerWalk(p);
         }
      }
      
      protected function updateMap(event:Event) : void
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
         for each(var player in _characters)
         {
            player.updatePlayer();
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
         var i:int = 0;
         var obj:* = null;
         var depth:Number = NaN;
         var minIndex:* = 0;
         var minDepth:* = NaN;
         var j:int = 0;
         var temp:* = null;
         var tempDepth:Number = NaN;
         var count:int = _articleLayer.numChildren;
         for(i = 0; i < count - 1; )
         {
            obj = _articleLayer.getChildAt(i);
            depth = this.getPointDepth(obj.x,obj.y);
            minDepth = 1.79769313486232e308;
            for(j = i + 1; j < count; )
            {
               temp = _articleLayer.getChildAt(j);
               tempDepth = this.getPointDepth(temp.x,temp.y);
               if(tempDepth < minDepth)
               {
                  minIndex = j;
                  minDepth = tempDepth;
               }
               j++;
            }
            if(depth > minDepth)
            {
               _articleLayer.swapChildrenAt(i,minIndex);
            }
            i++;
         }
      }
      
      protected function getPointDepth(x:Number, y:Number) : Number
      {
         return MAP_SIZE[0] * y + x;
      }
      
      public function addSelfPlayer() : void
      {
         var tmpSelfData:* = null;
         var tmp:* = null;
         if(!_selfPlayer)
         {
            tmpSelfData = ConsortiaBattleManager.instance.getPlayerInfo(PlayerManager.Instance.Self.ID);
            tmp = new ConsortiaBattlePlayer(tmpSelfData,addPlayerCallBack);
            setCenter(null,false,tmpSelfData.pos);
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
