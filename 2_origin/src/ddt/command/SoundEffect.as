package ddt.command
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundEffectManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.getTimer;
   
   public class SoundEffect extends EventDispatcher implements Disposeable
   {
       
      
      private var _id:String;
      
      private var _delay:int;
      
      private var _sound:Sound;
      
      private var _channel:SoundChannel;
      
      public function SoundEffect(id:String)
      {
         super();
         _id = id;
         init();
      }
      
      private function init() : void
      {
         var soundClass:* = SoundEffectManager.Instance.definition(_id);
         _sound = new soundClass();
         _channel = new SoundChannel();
         _channel.soundTransform = new SoundTransform(SharedManager.Instance.soundVolumn);
         _channel.addEventListener("soundComplete",__onSoundComplete);
      }
      
      public function play() : void
      {
         _delay = getTimer();
         _channel = _sound.play();
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get delay() : int
      {
         return _delay;
      }
      
      private function __onSoundComplete(e:Event) : void
      {
         dispatchEvent(new Event("soundComplete"));
      }
      
      public function dispose() : void
      {
         _id = null;
         if(_sound)
         {
            _sound.close();
         }
         _sound = null;
         if(_channel)
         {
            _channel.stop();
         }
         _channel = null;
      }
   }
}
