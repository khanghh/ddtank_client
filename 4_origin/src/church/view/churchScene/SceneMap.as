package church.view.churchScene
{
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.player.ChurchPlayer;
   import church.view.churchFire.ChurchFireEffectPlayer;
   import church.vo.PlayerVO;
   import church.vo.SceneMapVO;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class SceneMap extends Sprite
   {
      
      public static const SCENE_ALLOW_FIRES:int = 6;
       
      
      private const CLICK_INTERVAL:Number = 200;
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      protected var _selfPlayer:ChurchPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _mouseMovie:MovieClip;
      
      private var _currentLoadingPlayer:ChurchPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:ChurchRoomModel;
      
      protected var reference:ChurchPlayer;
      
      public function SceneMap(model:ChurchRoomModel, sceneScene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null)
      {
         super();
         _model = model;
         this.sceneScene = sceneScene;
         this._data = data;
         if(bg == null)
         {
            this.bgLayer = new Sprite();
         }
         else
         {
            this.bgLayer = bg;
         }
         this.meshLayer = mesh == null?new Sprite():mesh;
         this.meshLayer.alpha = 0;
         this.articleLayer = acticle == null?new Sprite():acticle;
         this.skyLayer = sky == null?new Sprite():sky;
         this.addChild(meshLayer);
         this.addChild(bgLayer);
         this.addChild(articleLayer);
         this.addChild(skyLayer);
         init();
         addEvent();
      }
      
      public function get sceneMapVO() : SceneMapVO
      {
         return _sceneMapVO;
      }
      
      public function set sceneMapVO(value:SceneMapVO) : void
      {
         _sceneMapVO = value;
      }
      
      protected function init() : void
      {
         _characters = new DictionaryData(true);
         var mvClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.church.room.MouseClickMovie") as Class;
         _mouseMovie = new mvClass() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         bgLayer.addChild(_mouseMovie);
         last_click = 0;
      }
      
      protected function addEvent() : void
      {
         _model.addEventListener("playerNameVisible",menuChange);
         _model.addEventListener("playerChatBallVisible",menuChange);
         _model.addEventListener("playerFireVisible",menuChange);
         addEventListener("click",__click);
         addEventListener("enterFrame",updateMap);
         _data.addEventListener("add",__addPlayer);
         _data.addEventListener("remove",__removePlayer);
      }
      
      private function menuChange(evt:WeddingRoomEvent) : void
      {
         var _loc2_:* = evt.type;
         if("playerNameVisible" !== _loc2_)
         {
            if("playerChatBallVisible" !== _loc2_)
            {
               if("playerFireVisible" === _loc2_)
               {
                  fireVisible();
               }
            }
            else
            {
               chatBallVisible();
            }
         }
         else
         {
            nameVisible();
         }
      }
      
      public function nameVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var churchPlayer in _characters)
         {
            churchPlayer.isShowName = _model.playerNameVisible;
         }
      }
      
      public function chatBallVisible() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _characters;
         for each(var churchPlayer in _characters)
         {
            churchPlayer.isChatBall = _model.playerChatBallVisible;
         }
      }
      
      public function fireVisible() : void
      {
      }
      
      protected function updateMap(event:Event) : void
      {
         if(!_characters || _characters.length <= 0)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _characters;
         for each(var player in _characters)
         {
            player.updatePlayer();
            player.isChatBall = _model.playerChatBallVisible;
            player.isShowName = _model.playerNameVisible;
         }
         BuildEntityDepth();
      }
      
      protected function __click(event:MouseEvent) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         var targetPoint:Point = this.globalToLocal(new Point(event.stageX,event.stageY));
         if(getTimer() - _lastClick > _clickInterval)
         {
            _lastClick = getTimer();
            if(!sceneScene.hit(targetPoint))
            {
               _selfPlayer.playerVO.walkPath = sceneScene.searchPath(_selfPlayer.playerPoint,targetPoint);
               _selfPlayer.playerVO.walkPath.shift();
               _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
               _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               sendMyPosition(_selfPlayer.playerVO.walkPath.concat());
               _mouseMovie.x = targetPoint.x;
               _mouseMovie.y = targetPoint.y;
               _mouseMovie.play();
            }
         }
      }
      
      public function sendMyPosition(p:Array) : void
      {
         var i:int = 0;
         var arr:Array = [];
         while(i < p.length)
         {
            arr.push(int(p[i].x),int(p[i].y));
            i++;
         }
         var pathStr:String = arr.toString();
         SocketManager.Instance.out.sendChurchMove(p[p.length - 1].x,p[p.length - 1].y,pathStr);
      }
      
      public function useFire(playerID:int, fireTemplateID:int) : void
      {
         var churchFireEffectPlayer:* = null;
         if(_characters[playerID] == null)
         {
            return;
         }
         if(_characters[playerID])
         {
            if(playerID == PlayerManager.Instance.Self.ID)
            {
               _model.fireEnable = false;
               if(!_model.playerFireVisible)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.scene.SceneMap.lihua"));
               }
            }
            churchFireEffectPlayer = new ChurchFireEffectPlayer(fireTemplateID);
            churchFireEffectPlayer.addEventListener("complete",fireCompleteHandler);
            churchFireEffectPlayer.owerID = playerID;
            if(_model.playerFireVisible)
            {
               churchFireEffectPlayer.x = (_characters[playerID] as ChurchPlayer).x;
               churchFireEffectPlayer.y = (_characters[playerID] as ChurchPlayer).y - 190;
               addChild(churchFireEffectPlayer);
            }
            churchFireEffectPlayer.firePlayer();
         }
      }
      
      protected function fireCompleteHandler(e:Event) : void
      {
         var fire:ChurchFireEffectPlayer = e.currentTarget as ChurchFireEffectPlayer;
         fire.removeEventListener("complete",fireCompleteHandler);
         if(fire.owerID == PlayerManager.Instance.Self.ID)
         {
            _model.fireEnable = true;
         }
         if(fire.parent)
         {
            fire.parent.removeChild(fire);
         }
         fire.dispose();
         fire = null;
      }
      
      public function movePlayer(id:int, p:Array) : void
      {
         var churchPlayer:* = null;
         if(_characters[id])
         {
            churchPlayer = _characters[id] as ChurchPlayer;
            churchPlayer.playerVO.walkPath = p;
            churchPlayer.playerWalk(p);
         }
      }
      
      public function setCenter(event:SceneCharacterEvent = null) : void
      {
         var xf:* = NaN;
         var yf:* = NaN;
         if(reference)
         {
            xf = Number(-(reference.x - 1000 / 2));
            yf = Number(-(reference.y - 600 / 2) + 50);
         }
         else
         {
            xf = Number(-(_sceneMapVO.defaultPos.x - 1000 / 2));
            yf = Number(-(_sceneMapVO.defaultPos.y - 600 / 2) + 50);
         }
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - _sceneMapVO.mapW)
         {
            xf = Number(1000 - _sceneMapVO.mapW);
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < 600 - _sceneMapVO.mapH)
         {
            yf = Number(600 - _sceneMapVO.mapH);
         }
         x = xf;
         y = yf;
      }
      
      public function addSelfPlayer() : void
      {
         var selfPlayerVO:* = null;
         if(!_selfPlayer)
         {
            selfPlayerVO = new PlayerVO();
            selfPlayerVO.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new ChurchPlayer(selfPlayerVO,addPlayerCallBack);
         }
      }
      
      protected function ajustScreen(churchPlayer:ChurchPlayer) : void
      {
         if(churchPlayer == null)
         {
            if(reference)
            {
               reference.removeEventListener("characterMovement",setCenter);
               reference = null;
            }
            return;
         }
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         reference = churchPlayer;
         reference.addEventListener("characterMovement",setCenter);
      }
      
      protected function __addPlayer(event:DictionaryEvent) : void
      {
         var playerVO:PlayerVO = event.data as PlayerVO;
         _currentLoadingPlayer = new ChurchPlayer(playerVO,addPlayerCallBack);
      }
      
      private function addPlayerCallBack(churchPlayer:ChurchPlayer, isLoadSucceed:Boolean, vFlag:int) : void
      {
         if(vFlag == 0)
         {
            if(!articleLayer || !churchPlayer)
            {
               return;
            }
            _currentLoadingPlayer = null;
            churchPlayer.sceneScene = sceneScene;
            var _loc4_:* = churchPlayer.playerVO.scenePlayerDirection;
            churchPlayer.sceneCharacterDirection = _loc4_;
            churchPlayer.setSceneCharacterDirectionDefault = _loc4_;
            if(!_selfPlayer && churchPlayer.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               churchPlayer.playerVO.playerPos = _sceneMapVO.defaultPos;
               _selfPlayer = churchPlayer;
               articleLayer.addChild(_selfPlayer);
               ajustScreen(_selfPlayer);
               setCenter();
               _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               articleLayer.addChild(churchPlayer);
            }
            churchPlayer.playerPoint = churchPlayer.playerVO.playerPos;
            churchPlayer.sceneCharacterStateType = "natural";
            _characters.add(churchPlayer.playerVO.playerInfo.ID,churchPlayer);
            churchPlayer.isShowName = _model.playerNameVisible;
            churchPlayer.isChatBall = _model.playerChatBallVisible;
         }
      }
      
      private function playerActionChange(evt:SceneCharacterEvent) : void
      {
         var type:String = evt.data.toString();
         if(type == "naturalStandFront" || type == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
         }
      }
      
      protected function __removePlayer(event:DictionaryEvent) : void
      {
         var id:int = (event.data as PlayerVO).playerInfo.ID;
         var player:ChurchPlayer = _characters[id] as ChurchPlayer;
         _characters.remove(id);
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
         var count:int = articleLayer.numChildren;
         for(i = 0; i < count - 1; )
         {
            obj = articleLayer.getChildAt(i);
            depth = this.getPointDepth(obj.x,obj.y);
            minDepth = 1.79769313486232e308;
            for(j = i + 1; j < count; )
            {
               temp = articleLayer.getChildAt(j);
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
               articleLayer.swapChildrenAt(i,minIndex);
            }
            i++;
         }
      }
      
      protected function getPointDepth(x:Number, y:Number) : Number
      {
         return sceneMapVO.mapW * y + x;
      }
      
      public function setSalute(id:int) : void
      {
      }
      
      protected function removeEvent() : void
      {
         _model.removeEventListener("playerNameVisible",menuChange);
         _model.removeEventListener("playerChatBallVisible",menuChange);
         _model.removeEventListener("playerFireVisible",menuChange);
         removeEventListener("click",__click);
         removeEventListener("enterFrame",updateMap);
         _data.removeEventListener("add",__addPlayer);
         _data.removeEventListener("remove",__removePlayer);
         if(reference)
         {
            reference.removeEventListener("characterMovement",setCenter);
         }
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterActionChange",playerActionChange);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var player:* = null;
         removeEvent();
         _data.clear();
         _data = null;
         _sceneMapVO = null;
         var _loc5_:int = 0;
         var _loc4_:* = _characters;
         for each(var p in _characters)
         {
            if(p.parent)
            {
               p.parent.removeChild(p);
            }
            p.removeEventListener("characterMovement",setCenter);
            p.removeEventListener("characterActionChange",playerActionChange);
            p.dispose();
            p = null;
         }
         _characters.clear();
         _characters = null;
         if(articleLayer)
         {
            for(i = articleLayer.numChildren; i > 0; )
            {
               player = articleLayer.getChildAt(i - 1) as ChurchPlayer;
               if(player)
               {
                  player.removeEventListener("characterMovement",setCenter);
                  player.removeEventListener("characterActionChange",playerActionChange);
                  if(player.parent)
                  {
                     player.parent.removeChild(player);
                  }
                  player.dispose();
               }
               player = null;
               try
               {
                  articleLayer.removeChildAt(i - 1);
               }
               catch(e:RangeError)
               {
                  trace(e);
               }
               i--;
            }
            if(articleLayer && articleLayer.parent)
            {
               articleLayer.parent.removeChild(articleLayer);
            }
         }
         articleLayer = null;
         if(_selfPlayer)
         {
            if(_selfPlayer.parent)
            {
               _selfPlayer.parent.removeChild(_selfPlayer);
            }
            _selfPlayer.dispose();
         }
         _selfPlayer = null;
         if(_currentLoadingPlayer)
         {
            if(_currentLoadingPlayer.parent)
            {
               _currentLoadingPlayer.parent.removeChild(_currentLoadingPlayer);
            }
            _currentLoadingPlayer.dispose();
         }
         _currentLoadingPlayer = null;
         if(_mouseMovie && _mouseMovie.parent)
         {
            _mouseMovie.parent.removeChild(_mouseMovie);
         }
         _mouseMovie = null;
         if(meshLayer && meshLayer.parent)
         {
            meshLayer.parent.removeChild(meshLayer);
         }
         meshLayer = null;
         if(bgLayer && bgLayer.parent)
         {
            bgLayer.parent.removeChild(bgLayer);
         }
         bgLayer = null;
         if(skyLayer && skyLayer.parent)
         {
            skyLayer.parent.removeChild(skyLayer);
         }
         skyLayer = null;
         sceneScene = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
