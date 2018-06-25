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
      
      public function MoonSceneMap(model:ChurchRoomModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null)
      {
         _model = model;
         super(_model,scene,data,bg,mesh,acticle,sky);
         SoundManager.instance.playMusic("3003");
         initSaulte();
      }
      
      private function get isSaluteFiring() : Boolean
      {
         return _isSaluteFiring;
      }
      
      private function set isSaluteFiring(value:Boolean) : void
      {
         if(_isSaluteFiring == value)
         {
            return;
         }
         _isSaluteFiring = value;
         if(_isSaluteFiring)
         {
            playSaluteSound();
         }
         else
         {
            stopSaluteSound();
         }
      }
      
      override public function setCenter(event:SceneCharacterEvent = null) : void
      {
         var xf:* = NaN;
         var yf:* = NaN;
         if(reference)
         {
            xf = Number(-(reference.x - 1000 / 2));
            yf = Number(-(reference.y - 600 / 2) + 230);
         }
         else
         {
            xf = Number(-(sceneMapVO.defaultPos.x - 1000 / 2));
            yf = Number(-(sceneMapVO.defaultPos.y - 600 / 2) + 230);
         }
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - sceneMapVO.mapW)
         {
            xf = Number(1000 - sceneMapVO.mapW);
         }
         if(yf > 0)
         {
            yf = 0;
         }
         if(yf < 600 - sceneMapVO.mapH)
         {
            yf = Number(600 - sceneMapVO.mapH);
         }
         x = xf;
         y = yf;
      }
      
      private function initSaulte() : void
      {
         var index:int = this.getChildIndex(articleLayer);
         saluteContainer = new Sprite();
         addChildAt(saluteContainer,index);
         saluteMask = new (ClassUtils.uiSourceDomain.getDefinition("asset.church.room.FireMaskOfMoonSceneAsset") as Class)() as MovieClip;
         addChild(saluteMask);
         saluteContainer.mask = saluteMask;
         saluteQueue = [];
         nameVisible();
         chatBallVisible();
         fireVisible();
      }
      
      override public function setSalute(id:int) : void
      {
         if(isSaluteFiring && id == PlayerManager.Instance.Self.ID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.scene.MoonSceneMap.lipao"));
            return;
         }
         if(id == PlayerManager.Instance.Self.ID)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            SocketManager.Instance.out.sendGunSalute(id,22001);
         }
         var SaluteClass:Class = ClassUtils.uiSourceDomain.getDefinition("tank.church.fireAcect.Salute") as Class;
         var saluteFire:MovieClip = new SaluteClass();
         var saluteFirePos:Point = ComponentFactory.Instance.creatCustomObject("church.MoonSceneMap.saluteFirePos");
         saluteFire.x = saluteFirePos.x;
         saluteFire.y = saluteFirePos.y;
         if(isSaluteFiring)
         {
            saluteQueue.push(saluteFire);
         }
         else
         {
            isSaluteFiring = true;
            saluteFire.addEventListener("enterFrame",saluteFireFrameHandler);
            saluteFire.gotoAndPlay(1);
            saluteContainer.addChild(saluteFire);
         }
      }
      
      private function saluteFireFrameHandler(e:Event) : void
      {
         var nextMovie:* = null;
         var movie:MovieClip = e.currentTarget as MovieClip;
         if(movie.currentFrame == movie.totalFrames)
         {
            isSaluteFiring = false;
            clearnSaluteFire();
            nextMovie = saluteQueue.shift();
            if(nextMovie)
            {
               isSaluteFiring = true;
               nextMovie.addEventListener("enterFrame",saluteFireFrameHandler);
               nextMovie.gotoAndPlay(1);
               saluteContainer.addChild(nextMovie);
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
      
      private function __timer(event:Event) : void
      {
         var random:* = 0;
         var playSound:Boolean = false;
         random = uint(Math.round(Math.random() * 15));
         if(random < 6)
         {
            playSound = !(Math.round(Math.random() * 9) % 3)?true:false;
            if(playSound)
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
