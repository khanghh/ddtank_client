package church.view.churchFire
{
   import com.pickgliss.utils.ClassUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ChurchFireEffectPlayer extends Sprite
   {
      
      public static const FIER_TIMER:int = 3500;
       
      
      private var _fireTemplateID:int;
      
      private var _fireMovie:MovieClip;
      
      private var _playerFramesCount:int = 0;
      
      private var _playerTimer:TimerJuggler;
      
      public var owerID:int;
      
      public function ChurchFireEffectPlayer(fireTemplateID:int)
      {
         _fireTemplateID = fireTemplateID;
         addFire();
         super();
      }
      
      private function addFire() : void
      {
         var fireClassPath:String = "";
         switch(int(_fireTemplateID) - 21002)
         {
            case 0:
               fireClassPath = "tank.church.fireAcect.FireItemAccect02";
               break;
            default:
               fireClassPath = "tank.church.fireAcect.FireItemAccect02";
               break;
            default:
               fireClassPath = "tank.church.fireAcect.FireItemAccect02";
               break;
            default:
               fireClassPath = "tank.church.fireAcect.FireItemAccect02";
               break;
            case 4:
               fireClassPath = "tank.church.fireAcect.FireItemAccect06";
         }
         if(!fireClassPath || fireClassPath == "" || fireClassPath.length <= 0)
         {
            return;
         }
         var fireClass:Class = ClassUtils.uiSourceDomain.getDefinition(fireClassPath) as Class;
         if(fireClass)
         {
            _fireMovie = new fireClass() as MovieClip;
            if(_fireMovie)
            {
               addChild(_fireMovie);
            }
         }
      }
      
      public function firePlayer(playSound:Boolean = true) : void
      {
         if(playSound)
         {
            SoundManager.instance.play("117");
         }
         if(_fireMovie)
         {
            _fireMovie.gotoAndPlay(1);
            _fireMovie.addEventListener("enterFrame",enterFrameHander);
            _playerFramesCount = 0;
            _playerTimer = TimerManager.getInstance().addTimerJuggler(3500,0);
            _playerTimer.start();
            _playerTimer.addEventListener("timer",timerHander);
         }
         else
         {
            removeFire();
         }
      }
      
      public function removeFire() : void
      {
         if(_fireMovie)
         {
            if(_fireMovie.parent)
            {
               _fireMovie.parent.removeChild(_fireMovie);
            }
            _fireMovie.removeEventListener("enterFrame",enterFrameHander);
            _fireMovie = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function timerHander(evt:Event) : void
      {
         if(_playerTimer)
         {
            _playerTimer.removeEventListener("timer",timerHander);
            _playerTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_playerTimer);
            _playerTimer = null;
         }
         removeFire();
      }
      
      private function enterFrameHander(e:Event) : void
      {
         _playerFramesCount = Number(_playerFramesCount) + 1;
         if(_playerFramesCount >= _fireMovie.totalFrames)
         {
            removeFire();
         }
      }
      
      public function dispose() : void
      {
         if(_fireMovie)
         {
            _fireMovie.removeEventListener("enterFrame",enterFrameHander);
         }
         _fireMovie = null;
         if(_playerTimer)
         {
            _playerTimer.removeEventListener("timer",timerHander);
            _playerTimer.stop();
            TimerManager.getInstance().removeJugglerByTimer(_playerTimer);
         }
         _playerTimer = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
