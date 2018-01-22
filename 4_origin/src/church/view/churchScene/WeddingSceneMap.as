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
      
      public function WeddingSceneMap(param1:ChurchRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null)
      {
         _fatherPaopaoConfig = [];
         _model = param1;
         super(_model,param2,param3,param4,param5,param6,param7);
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
      
      public function fireImdily(param1:Point, param2:uint, param3:Boolean = false) : void
      {
         if(param2 > 1)
         {
            return;
         }
         var _loc4_:int = _model.fireTemplateIDList[param2];
         var _loc5_:ChurchFireEffectPlayer = new ChurchFireEffectPlayer(_loc4_);
         _loc5_.x = param1.x;
         _loc5_.y = param1.y;
         addChild(_loc5_);
         _loc5_.firePlayer(param3);
      }
      
      public function playWeddingMovie() : void
      {
         bride = _characters[ChurchManager.instance.currentRoom.brideID] as ChurchPlayer;
         groom = _characters[ChurchManager.instance.currentRoom.groomID] as ChurchPlayer;
         bride.moveSpeed = 0.055;
         groom.moveSpeed = 0.055;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.bridePos");
         bride.x = _loc1_.x;
         bride.y = _loc1_.y;
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.groomPos");
         groom.x = _loc2_.x;
         groom.y = _loc2_.y;
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
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("church.WeddingSceneMap.bridePosII");
         bride.x = _loc1_.x;
         bride.y = _loc1_.y;
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
      
      private function __arrive(param1:SceneCharacterEvent) : void
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         getGuestPos();
         var _loc2_:Array = _characters.list;
         _loc2_.sortOn("ID",16);
         while(_loc4_ < _characters.length)
         {
            _loc1_ = _loc2_[_loc4_] as ChurchPlayer;
            if(!ChurchManager.instance.isAdmin(_loc1_.playerVO.playerInfo))
            {
               if(_loc3_ % 2)
               {
                  _loc1_.x = (guestPos[0][0] as Point).x;
                  _loc1_.y = (guestPos[0][0] as Point).y;
                  (guestPos[0] as Array).shift();
                  _loc1_.sceneCharacterActionType = "naturalStandBack";
                  _loc1_.sceneCharacterDirection = SceneCharacterDirection.RT;
               }
               else
               {
                  _loc1_.x = (guestPos[1][0] as Point).x;
                  _loc1_.y = (guestPos[1][0] as Point).y;
                  (guestPos[1] as Array).shift();
                  _loc1_.sceneCharacterActionType = "naturalStandBack";
                  _loc1_.sceneCharacterDirection = SceneCharacterDirection.LT;
                  if((guestPos[1] as Array).length == 0)
                  {
                     guestPos.shift();
                     guestPos.shift();
                  }
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      private function getGuestPos() : void
      {
         var _loc1_:* = 0;
         var _loc3_:* = 0;
         guestPos = [];
         var _loc4_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.church.room.GuestLineAsset") as Class;
         var _loc2_:MovieClip = new _loc4_() as MovieClip;
         addChild(_loc2_);
         _loc3_ = uint(1);
         while(_loc3_ <= 8)
         {
            if(_loc3_ == 1 || _loc3_ == 2)
            {
               _loc1_ = uint(19);
               guestPos.push(spliceLine(_loc2_["line" + _loc3_],_loc1_,false,false));
            }
            else if(_loc3_ == 3 || _loc3_ == 5 || _loc3_ == 7)
            {
               _loc1_ = uint(14);
               guestPos.push(spliceLine(_loc2_["line" + _loc3_],_loc1_,false,true));
            }
            else if(_loc3_ == 4 || _loc3_ == 6 || _loc3_ == 8)
            {
               _loc1_ = uint(14);
               guestPos.push(spliceLine(_loc2_["line" + _loc3_],_loc1_,true,false));
            }
            _loc3_++;
         }
         removeChild(_loc2_);
      }
      
      private function spliceLine(param1:DisplayObject, param2:uint, param3:Boolean, param4:Boolean) : Array
      {
         var _loc10_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Number = param1.width / param2;
         var _loc7_:Number = param1.height / param2;
         var _loc11_:int = !!param3?1:-1;
         var _loc9_:int = !!param4?-1:1;
         var _loc8_:Array = [];
         while(_loc10_ <= param2)
         {
            _loc5_ = new Point();
            _loc5_.x = param1.x + _loc6_ * _loc10_ * _loc11_;
            _loc5_.y = param1.y + _loc7_ * _loc10_ * _loc9_;
            _loc8_.push(_loc5_);
            _loc10_++;
         }
         return _loc8_;
      }
      
      private function playDialogue() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         frame = 1;
         if(father_read)
         {
            father_read.visible = true;
         }
         if(father_com)
         {
            father_com.visible = false;
         }
         _loc2_ = 0;
         while(_loc2_ < 23)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("church.room.FatherBallConfigVO" + (_loc2_ + 1));
            _fatherPaopaoConfig.push(_loc1_);
            _loc2_++;
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
         var _loc1_:* = null;
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
         var _loc2_:FatherBallConfigVO = _fatherPaopaoConfig[frame - 1] as FatherBallConfigVO;
         if(_loc2_.isMask == "true")
         {
            _loc1_ = new Shape();
            _loc1_.x = _fatherPaopao.x + _fatherPaopao.getFrameImage(frame - 1).x;
            _loc1_.y = _fatherPaopao.y + _fatherPaopao.getFrameImage(frame - 1).y;
         }
         frame = Number(frame) + 1;
         BitmapUtils.maskMovie(_fatherPaopao,_loc1_,_loc2_.isMask,_loc2_.rowNumber,_loc2_.rowWitdh,_loc2_.rowHeight,_loc2_.frameStep,_loc2_.sleepSecond,playerFatherPaopaoFrame);
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
         var _loc1_:Class = ClassUtils.uiSourceDomain.getDefinition("tank.church.KissMovie") as Class;
         kissMovie = new _loc1_() as MovieClip;
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
      
      private function __fireTimer(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc3_:Boolean = false;
         _loc4_ = getFirePosition();
         _loc2_ = uint(Math.round(Math.random() * 3));
         _loc3_ = !(Math.round(Math.random() * 9) % 3)?true:false;
         fireImdily(_loc4_,_loc2_,_loc3_);
      }
      
      private function getFirePosition() : Point
      {
         var _loc1_:* = null;
         var _loc2_:Number = Math.round(Math.random() * 900) + 50;
         var _loc3_:Number = Math.round(Math.random() * 500) + 50;
         _loc1_ = this.globalToLocal(new Point(_loc2_,_loc3_));
         return _loc1_;
      }
      
      private function __fireTimerComplete(param1:TimerEvent) : void
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
      
      override protected function __click(param1:MouseEvent) : void
      {
         if(ChurchManager.instance.currentRoom.status == "wedding_ing")
         {
            return;
         }
         super.__click(param1);
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
