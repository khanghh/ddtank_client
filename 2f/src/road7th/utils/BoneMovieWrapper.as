package road7th.utils
{
   import bones.BoneMovieFactory;
   import bones.display.IBoneMovie;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import dragonBones.events.AnimationEvent;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import flash.display.DisplayObject;
   import road7th.data.DictionaryData;
   
   public class BoneMovieWrapper implements Disposeable
   {
       
      
      private var _movie:IBoneMovie;
      
      private var _autoDisappear:Boolean;
      
      private var _autoPlay:Boolean;
      
      private var _isDispose:Boolean;
      
      private var _script:DictionaryData;
      
      private var _playCell:Function;
      
      private var _args:Array;
      
      private var _gotoAction:String = null;
      
      private var _labelMapping:DictionaryData;
      
      public function BoneMovieWrapper(param1:*, param2:Boolean = false, param3:Boolean = false, param4:int = 0){super();}
      
      private function init() : void{}
      
      private function check() : void{}
      
      protected function addDefaultScript() : void{}
      
      private function __onFrameEventHandler(param1:FrameEvent) : void{}
      
      private function __onAnimationComplete(param1:AnimationEvent) : void{}
      
      public function addFrameScript(param1:String, param2:Function, param3:Boolean = true) : void{}
      
      public function removeFrameScript(param1:String) : void{}
      
      public function removeFrameScriptAll() : void{}
      
      public function playAction(param1:String = "", param2:Function = null, param3:Array = null) : void{}
      
      public function stop() : void{}
      
      public function setActionMapping(param1:String, param2:String) : void{}
      
      public function get movie() : IBoneMovie{return null;}
      
      public function get asDisplay() : *{return null;}
      
      public function dispose() : void{}
   }
}
