package church.view.churchScene
{
   import church.ChurchManager;
   import church.model.ChurchRoomModel;
   import church.player.ChurchPlayer;
   import church.view.churchFire.ChurchFireEffectPlayer;
   import church.vo.FatherBallConfigVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.BitmapUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class WeddingSceneMap extends SceneMap
   {
      
      public static const MOVE_SPEED:Number = 0.055;
      
      public static const MOVE_SPEEDII:Number = 0.15;
       
      
      private var _model:ChurchRoomModel;
      
      private var father_read:MovieClip;
      
      private var father_com:MovieClip;
      
      private var bride:ChurchPlayer;
      
      private var groom:ChurchPlayer;
      
      private var guestPos:Array;
      
      private var _fatherPaopaoBg:ScaleFrameImage;
      
      private var _fatherPaopao:ScaleFrameImage;
      
      private var _fatherPaopaoConfig:Array;
      
      private var frame:uint = 1;
      
      private var _brideName:FilterFrameText;
      
      private var _groomName:FilterFrameText;
      
      private var kissMovie:MovieClip;
      
      private var fireTimer:TimerJuggler;
      
      public function WeddingSceneMap(model:ChurchRoomModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null)
      {
         _fatherPaopaoConfig = [];
         _model = model;
         super(_model,scene,data,bg,mesh,acticle,sky);
         SoundManager.instance.playMusic("3002");
         initFather();
      }
      
      private function initFather() : void
      {
         if(bgLayer != null)
         {
            father_read = bgLayer.getChildByName("father_read") as MovieClip;
            father_com = bgLayer.getChildByName("father_com") as MovieClip;
            if(father_read)
            {
               father_read.visible = false;
            }
         }
      }
      
      public function fireImdily(pt:Point, type:uint, playSound:Boolean = false) : void
      {
         if(type > 1)
         {
            return;
         }
         var fireID:int = _model.fireTemplateIDList[type];
         var fire:ChurchFireEffectPlayer = new ChurchFireEffectPlayer(fireID);
         fire.x = pt.x;
         fire.y = pt.y;
         addChild(fire);
         fire.firePlayer(playSound);
      }
      
      public function playWeddingMovie() : void
      {
         bride = _characters[ChurchManager.instance.currentRoom.brideID] as ChurchPlayer;
         groom = _characters[ChurchManager.instance.currentRoom.groomID] as ChurchPlayer;
         bride.moveSpeed = 0.055;
         groom.moveSpeed = 0.055;
         var bridePos:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.bridePos");
         bride.x = bridePos.x;
         bride.y = bridePos.y;
         var groomPos:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.groomPos");
         groom.x = groomPos.x;
         groom.y = groomPos.y;
         rangeGuest();
         ajustScreen(bride);
         bride.addEventListener("characterArrivedNextStep",__arrive);
         groom.addEventListener("characterArrivedNextStep",__arrive);
         bride.sceneCharacterActionType = "naturalWalkBack";
         bride.playerVO.walkPath = [new Point(1104,660)];
         bride.playerWalk(bride.playerVO.walkPath);
         groom.sceneCharacterActionType = "naturalWalkBack";
         groom.playerVO.walkPath = [new Point(1003,651)];
         groom.playerWalk(groom.playerVO.walkPath);
      }
      
      public function stopWeddingMovie() : void
      {
         var bridePosII:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.bridePosII");
         bride.x = bridePosII.x;
         bride.y = bridePosII.y;
         bride.sceneCharacterDirection = SceneCharacterDirection.LB;
         groom.moveSpeed = 0.15;
         groom.moveSpeed = 0.15;
         ajustScreen(_selfPlayer);
         setCenter(null);
         if(father_read)
         {
            father_read.visible = false;
         }
         if(father_com)
         {
            father_com.visible = true;
         }
         hideDialogue();
         stopKissMovie();
         stopFireMovie();
         bride.removeEventListener("characterArrivedNextStep",__arrive);
      }
      
      private function __arrive(event:SceneCharacterEvent) : void
      {
         bride.removeEventListener("characterArrivedNextStep",__arrive);
         groom.removeEventListener("characterArrivedNextStep",__arrive);
         ajustScreen(null);
         bride.sceneCharacterActionType = "naturalStandFront";
         groom.sceneCharacterActionType = "naturalStandFront";
         bride.sceneCharacterDirection = SceneCharacterDirection.LB;
         groom.sceneCharacterDirection = SceneCharacterDirection.LB;
         playDialogue();
      }
      
      public function rangeGuest() : void
      {
         var j:int = 0;
         var i:int = 0;
         var player:* = null;
         getGuestPos();
         var playerArr:Array = _characters.list;
         playerArr.sortOn("ID",16);
         while(i < _characters.length)
         {
            player = playerArr[i] as ChurchPlayer;
            if(!ChurchManager.instance.isAdmin(player.playerVO.playerInfo))
            {
               if(j % 2)
               {
                  player.x = (guestPos[0][0] as Point).x;
                  player.y = (guestPos[0][0] as Point).y;
                  (guestPos[0] as Array).shift();
                  player.sceneCharacterActionType = "naturalStandBack";
                  player.sceneCharacterDirection = SceneCharacterDirection.RT;
               }
               else
               {
                  player.x = (guestPos[1][0] as Point).x;
                  player.y = (guestPos[1][0] as Point).y;
                  (guestPos[1] as Array).shift();
                  player.sceneCharacterActionType = "naturalStandBack";
                  player.sceneCharacterDirection = SceneCharacterDirection.LT;
                  if((guestPos[1] as Array).length == 0)
                  {
                     guestPos.shift();
                     guestPos.shift();
                  }
               }
               j++;
            }
            i++;
         }
      }
      
      private function getGuestPos() : void
      {
         var count:* = 0;
         var i:* = 0;
         guestPos = [];
         var lineClass:Class = ClassUtils.uiSourceDomain.getDefinition("asset.church.room.GuestLineAsset") as Class;
         var lineAsset:MovieClip = new lineClass() as MovieClip;
         addChild(lineAsset);
         for(i = uint(1); i <= 8; )
         {
            if(i == 1 || i == 2)
            {
               count = uint(19);
               guestPos.push(spliceLine(lineAsset["line" + i],count,false,false));
            }
            else if(i == 3 || i == 5 || i == 7)
            {
               count = uint(14);
               guestPos.push(spliceLine(lineAsset["line" + i],count,false,true));
            }
            else if(i == 4 || i == 6 || i == 8)
            {
               count = uint(14);
               guestPos.push(spliceLine(lineAsset["line" + i],count,true,false));
            }
            i++;
         }
         removeChild(lineAsset);
      }
      
      private function spliceLine(line:DisplayObject, count:uint, right:Boolean, top:Boolean) : Array
      {
         var i:int = 0;
         var point:* = null;
         var stepX:Number = line.width / count;
         var stepY:Number = line.height / count;
         var dirX:int = !!right?1:-1;
         var dirY:int = !!top?-1:1;
         var arr:Array = [];
         while(i <= count)
         {
            point = new Point();
            point.x = line.x + stepX * i * dirX;
            point.y = line.y + stepY * i * dirY;
            arr.push(point);
            i++;
         }
         return arr;
      }
      
      private function playDialogue() : void
      {
         var i:int = 0;
         var _fatherPaopaoConfigVO:* = null;
         frame = 1;
         if(father_read)
         {
            father_read.visible = true;
         }
         if(father_com)
         {
            father_com.visible = false;
         }
         i = 0;
         while(i < 23)
         {
            _fatherPaopaoConfigVO = ComponentFactory.Instance.creatCustomObject("church.room.FatherBallConfigVO" + (i + 1));
            _fatherPaopaoConfig.push(_fatherPaopaoConfigVO);
            i++;
         }
         _fatherPaopaoBg = ComponentFactory.Instance.creatComponentByStylename("church.room.FatherPaopaoBg");
         _fatherPaopaoBg.setFrame(frame);
         addChild(_fatherPaopaoBg);
         _fatherPaopao = ComponentFactory.Instance.creatComponentByStylename("church.room.FatherPaopao");
         _fatherPaopao.setFrame(frame);
         addChild(_fatherPaopao);
         playerFatherPaopaoFrame();
      }
      
      private function playerFatherPaopaoFrame() : void
      {
         var maskShape:* = null;
         ObjectUtils.disposeObject(_brideName);
         _brideName = null;
         ObjectUtils.disposeObject(_groomName);
         _groomName = null;
         if(!_fatherPaopaoBg || !_fatherPaopao)
         {
            return;
         }
         if(_fatherPaopao.getFrame >= _fatherPaopao.totalFrames)
         {
            hideDialogue();
            if(bride && groom && groom.playerVO && _selfPlayer)
            {
               readyForKiss();
            }
            return;
         }
         _fatherPaopaoBg.setFrame(frame);
         _fatherPaopao.setFrame(frame);
         var _loc3_:* = frame;
         if(3 !== _loc3_)
         {
            if(7 !== _loc3_)
            {
               if(22 === _loc3_)
               {
                  _groomName = ComponentFactory.Instance.creat("church.room.FatherPaopaoGroomName2");
                  _groomName.text = ChurchManager.instance.currentRoom.groomName;
                  addChild(_groomName);
                  _brideName = ComponentFactory.Instance.creat("church.room.FatherPaopaoBrideName2");
                  _brideName.text = ChurchManager.instance.currentRoom.brideName;
                  addChild(_brideName);
               }
            }
            else
            {
               _groomName = ComponentFactory.Instance.creat("church.room.FatherPaopaoGroomName");
               _groomName.text = ChurchManager.instance.currentRoom.groomName;
               addChild(_groomName);
            }
         }
         else
         {
            _brideName = ComponentFactory.Instance.creat("church.room.FatherPaopaoBrideName");
            _brideName.text = ChurchManager.instance.currentRoom.brideName;
            addChild(_brideName);
         }
         var fatherPaopaoConfigVO:FatherBallConfigVO = _fatherPaopaoConfig[frame - 1] as FatherBallConfigVO;
         if(fatherPaopaoConfigVO.isMask == "true")
         {
            maskShape = new Shape();
            maskShape.x = _fatherPaopao.x + _fatherPaopao.getFrameImage(frame - 1).x;
            maskShape.y = _fatherPaopao.y + _fatherPaopao.getFrameImage(frame - 1).y;
         }
         frame = Number(frame) + 1;
         BitmapUtils.maskMovie(_fatherPaopao,maskShape,fatherPaopaoConfigVO.isMask,fatherPaopaoConfigVO.rowNumber,fatherPaopaoConfigVO.rowWitdh,fatherPaopaoConfigVO.rowHeight,fatherPaopaoConfigVO.frameStep,fatherPaopaoConfigVO.sleepSecond,playerFatherPaopaoFrame);
      }
      
      private function readyForKiss() : void
      {
         bride.moveSpeed = 0.025;
         groom.moveSpeed = 0.025;
         groom.sceneCharacterActionType = "naturalWalkFront";
         groom.playerVO.walkPath = [new Point(1026,666)];
         groom.playerWalk(groom.playerVO.walkPath);
         bride.sceneCharacterActionType = "naturalWalkBack";
         bride.playerVO.walkPath = [new Point(1060,707),new Point(1044,694)];
         bride.playerWalk(bride.playerVO.walkPath);
         playKissMovie();
         playFireMovie();
         ajustPosition();
      }
      
      private function ajustPosition() : void
      {
         SocketManager.Instance.out.sendPosition(_selfPlayer.x,_selfPlayer.y);
      }
      
      private function hideDialogue() : void
      {
         ObjectUtils.disposeObject(_fatherPaopaoBg);
         _fatherPaopaoBg = null;
         ObjectUtils.disposeObject(_fatherPaopao);
         _fatherPaopao = null;
         if(father_read)
         {
            father_read.visible = false;
         }
         if(father_com)
         {
            father_com.visible = true;
         }
      }
      
      private function playKissMovie() : void
      {
         var kissClass:Class = ClassUtils.uiSourceDomain.getDefinition("tank.church.KissMovie") as Class;
         kissMovie = new kissClass() as MovieClip;
         kissMovie.x = 1040;
         kissMovie.y = 610;
         addChild(kissMovie);
      }
      
      private function stopKissMovie() : void
      {
         if(kissMovie)
         {
            removeChild(kissMovie);
         }
         kissMovie = null;
      }
      
      public function playFireMovie() : void
      {
         fireTimer = TimerManager.getInstance().addTimerJuggler(100);
         fireTimer.addEventListener("timer",__fireTimer);
         fireTimer.start();
      }
      
      private function __fireTimer(event:Event) : void
      {
         var pos:* = null;
         var type:* = 0;
         var playSound:Boolean = false;
         pos = getFirePosition();
         type = uint(Math.round(Math.random() * 3));
         playSound = !(Math.round(Math.random() * 9) % 3)?true:false;
         fireImdily(pos,type,playSound);
      }
      
      private function getFirePosition() : Point
      {
         var point:* = null;
         var tempX:Number = Math.round(Math.random() * 900) + 50;
         var tempY:Number = Math.round(Math.random() * 500) + 50;
         point = this.globalToLocal(new Point(tempX,tempY));
         return point;
      }
      
      private function __fireTimerComplete(event:TimerEvent) : void
      {
         if(!fireTimer)
         {
            return;
         }
         fireTimer.stop();
         fireTimer.removeEventListener("timer",__fireTimer);
         TimerManager.getInstance().removeJugglerByTimer(fireTimer);
         fireTimer = null;
      }
      
      private function stopFireMovie() : void
      {
         __fireTimerComplete(null);
      }
      
      override protected function __click(event:MouseEvent) : void
      {
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            return;
         }
         super.__click(event);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(bride)
         {
            bride.removeEventListener("characterArrivedNextStep",__arrive);
         }
         if(groom)
         {
            groom.removeEventListener("characterArrivedNextStep",__arrive);
         }
         if(fireTimer)
         {
            fireTimer.stop();
            fireTimer.removeEventListener("timer",__fireTimer);
            TimerManager.getInstance().removeJugglerByTimer(fireTimer);
         }
         fireTimer = null;
         stopKissMovie();
         stopFireMovie();
         ObjectUtils.disposeObject(_fatherPaopaoBg);
         _fatherPaopaoBg = null;
         ObjectUtils.disposeObject(_fatherPaopao);
         _fatherPaopao = null;
         if(father_read && father_read.parent)
         {
            father_read.parent.removeChild(father_read);
         }
         father_read = null;
         if(father_com && father_com.parent)
         {
            father_com.parent.removeChild(father_com);
         }
         father_com = null;
         bride = null;
         groom = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
