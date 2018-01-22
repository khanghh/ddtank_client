package church.view.churchScene
{
   import baglocked.BaglockedManager;
   import church.model.ChurchRoomModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class MoonSceneMap extends SceneMap
   {
      
      public static const YF_OFSET:int = 230;
      
      public static const FIRE_TEMPLETEID:int = 22001;
       
      
      private var _model:ChurchRoomModel;
      
      private var saluteContainer:Sprite;
      
      private var saluteMask:MovieClip;
      
      private var _isSaluteFiring:Boolean;
      
      private var saluteQueue:Array;
      
      private var timer:TimerJuggler;
      
      public function MoonSceneMap(param1:ChurchRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null)
      {
         _model = param1;
         super(_model,param2,param3,param4,param5,param6,param7);
         SoundManager.instance.playMusic("3003");
         initSaulte();
      }
      
      private function get isSaluteFiring() : Boolean
      {
         return _isSaluteFiring;
      }
      
      private function set isSaluteFiring(param1:Boolean) : void
      {
         if(_isSaluteFiring == param1)
         {
            return;
         }
         _isSaluteFiring = param1;
         if(_isSaluteFiring)
         {
            playSaluteSound();
         }
         else
         {
            stopSaluteSound();
         }
      }
      
      override public function setCenter(param1:SceneCharacterEvent = null) : void
      {
         var _loc3_:* = NaN;
         var _loc2_:* = NaN;
         if(reference)
         {
            _loc3_ = Number(-(reference.x - 1000 / 2));
            _loc2_ = Number(-(reference.y - 600 / 2) + 230);
         }
         else
         {
            _loc3_ = Number(-(sceneMapVO.defaultPos.x - 1000 / 2));
            _loc2_ = Number(-(sceneMapVO.defaultPos.y - 600 / 2) + 230);
         }
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < 1000 - sceneMapVO.mapW)
         {
            _loc3_ = Number(1000 - sceneMapVO.mapW);
         }
         if(_loc2_ > 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ < 600 - sceneMapVO.mapH)
         {
            _loc2_ = Number(600 - sceneMapVO.mapH);
         }
         x = _loc3_;
         y = _loc2_;
      }
      
      private function initSaulte() : void
      {
         var _loc1_:int = this.getChildIndex(articleLayer);
         saluteContainer = new Sprite();
         addChildAt(saluteContainer,_loc1_);
         saluteMask = new (ClassUtils.uiSourceDomain.getDefinition("asset.church.room.FireMaskOfMoonSceneAsset") as Class)() as MovieClip;
         addChild(saluteMask);
         saluteContainer.mask = saluteMask;
         saluteQueue = [];
         nameVisible();
         chatBallVisible();
         fireVisible();
      }
      
      override public function setSalute(param1:int) : void
      {
         if(isSaluteFiring && param1 == PlayerManager.Instance.Self.ID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.scene.MoonSceneMap.lipao"));
            return;
         }
         if(param1 == PlayerManager.Instance.Self.ID)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SocketManager.Instance.out.sendGunSalute(param1,22001);
         }
         var _loc4_:Class = ClassUtils.uiSourceDomain.getDefinition("tank.church.fireAcect.Salute") as Class;
         var _loc3_:MovieClip = new _loc4_();
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("church.MoonSceneMap.saluteFirePos");
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y;
         if(isSaluteFiring)
         {
            saluteQueue.push(_loc3_);
         }
         else
         {
            isSaluteFiring = true;
            _loc3_.addEventListener("enterFrame",saluteFireFrameHandler);
            _loc3_.gotoAndPlay(1);
            saluteContainer.addChild(_loc3_);
         }
      }
      
      private function saluteFireFrameHandler(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc3_.currentFrame == _loc3_.totalFrames)
         {
            isSaluteFiring = false;
            clearnSaluteFire();
            _loc2_ = saluteQueue.shift();
            if(_loc2_)
            {
               isSaluteFiring = true;
               _loc2_.addEventListener("enterFrame",saluteFireFrameHandler);
               _loc2_.gotoAndPlay(1);
               saluteContainer.addChild(_loc2_);
            }
         }
      }
      
      private function clearnSaluteFire() : void
      {
         while(saluteContainer.numChildren > 0)
         {
            saluteContainer.getChildAt(0).removeEventListener("enterFrame",saluteFireFrameHandler);
            saluteContainer.removeChildAt(0);
         }
      }
      
      private function playSaluteSound() : void
      {
         timer = TimerManager.getInstance().addTimerJuggler(100);
         timer.addEventListener("timer",__timer);
         timer.start();
      }
      
      private function __timer(param1:Event) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Boolean = false;
         _loc2_ = uint(Math.round(Math.random() * 15));
         if(_loc2_ < 6)
         {
            _loc3_ = !(Math.round(Math.random() * 9) % 3)?true:false;
            if(_loc3_)
            {
               SoundManager.instance.play("118");
            }
         }
      }
      
      private function stopSaluteSound() : void
      {
         if(timer)
         {
            timer.stop();
            timer.removeEventListener("timer",__timer);
            TimerManager.getInstance().removeJugglerByTimer(timer);
            timer = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(timer)
         {
            timer.removeEventListener("timer",__timer);
            TimerManager.getInstance().removeJugglerByTimer(timer);
         }
         timer = null;
         if(saluteMask && saluteMask.parent)
         {
            saluteMask.parent.removeChild(saluteMask);
         }
         saluteMask = null;
         clearnSaluteFire();
         stopSaluteSound();
         if(saluteContainer && saluteContainer.parent)
         {
            saluteContainer.parent.removeChild(saluteContainer);
         }
         saluteContainer = null;
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
