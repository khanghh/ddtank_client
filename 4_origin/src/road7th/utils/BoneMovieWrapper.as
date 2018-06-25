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
      
      public function BoneMovieWrapper(style:*, autoplay:Boolean = false, autodisappear:Boolean = false, type:int = 0)
      {
         super();
         if(style is String)
         {
            _movie = BoneMovieFactory.instance.creatBoneMovie(style,type);
         }
         else if(style is IBoneMovie)
         {
            _movie = style;
         }
         _movie.stop();
         _autoDisappear = autodisappear;
         _autoPlay = autoplay;
         _script = new DictionaryData();
         _labelMapping = new DictionaryData();
         addDefaultScript();
         if(_movie.loadComplete)
         {
            init();
         }
         else
         {
            _movie.onLoadComplete = init;
         }
      }
      
      private function init() : void
      {
         _movie.armature.addEventListener("animationFrameEvent",__onFrameEventHandler);
         _movie.armature.addEventListener("complete",__onAnimationComplete);
         if(_autoPlay)
         {
            playAction();
         }
      }
      
      private function check() : void
      {
      }
      
      protected function addDefaultScript() : void
      {
         addFrameScript("goto",function(boneMovie:BoneMovieWrapper, args:Array = null):void
         {
            _gotoAction = args[0] as String;
         });
         addFrameScript("gotoplay",function(boneMovie:BoneMovieWrapper, args:Array = null):void
         {
            boneMovie.playAction(args[0]);
         });
         addFrameScript("dispose",function(boneMovie:BoneMovieWrapper, args:Array = null):void
         {
            boneMovie.dispose();
         });
         addFrameScript("sound",function(boneMovie:BoneMovieWrapper, args:Array = null):void
         {
            var soundEvent:* = null;
            if(SoundEventManager.getInstance().hasEventListener("sound"))
            {
               soundEvent = new SoundEvent("sound");
               soundEvent.animationState = boneMovie.movie.animationState;
               soundEvent.sound = args[0];
               SoundEventManager.getInstance().dispatchEvent(soundEvent);
            }
         });
         addFrameScript("stop",function(boneMovie:BoneMovieWrapper, args:Array = null):void
         {
            boneMovie.movie.stop();
         });
      }
      
      private function __onFrameEventHandler(e:FrameEvent) : void
      {
         var len:int = 0;
         var frameLabel:String = e.frameLabel;
         var event:* = frameLabel;
         if(frameLabel == "")
         {
            return;
         }
         var args:Array = null;
         if(!(frameLabel == "frame" || frameLabel == "dispose"))
         {
            len = frameLabel.indexOf("_");
            if(len < 0)
            {
               throw new Error(_movie.armature.name + " boneMovie:: " + frameLabel + " 帧事件 未指定参数！请尽快解决");
            }
            event = frameLabel.slice(0,len);
            args = e.frameLabel.slice(len + 1,e.frameLabel.length).split("|");
         }
         if(_script.hasKey(event))
         {
            _script[event](this,args);
         }
      }
      
      private function __onAnimationComplete(e:AnimationEvent) : void
      {
         if(_playCell && _args)
         {
            _playCell(_args);
         }
         else if(_playCell)
         {
            _playCell();
         }
         if(_gotoAction)
         {
            playAction(_gotoAction);
         }
         _gotoAction = null;
         _playCell = null;
         _args = null;
         if(_autoDisappear)
         {
            dispose();
         }
      }
      
      public function addFrameScript(frameType:String, cell:Function, replace:Boolean = true) : void
      {
         if(_script.hasKey(frameType) && !replace)
         {
            return;
         }
         _script.add(frameType,cell);
      }
      
      public function removeFrameScript(frameType:String) : void
      {
         _script.remove(frameType);
      }
      
      public function removeFrameScriptAll() : void
      {
         _script.clear();
      }
      
      public function playAction(action:String = "", cell:Function = null, args:Array = null) : void
      {
         var actionLabel:* = null;
         if(_labelMapping.hasKey(action))
         {
            actionLabel = _labelMapping[action];
         }
         else
         {
            actionLabel = action;
         }
         if(actionLabel == "" || _movie.armature && _movie.armature.animation.hasAnimation(actionLabel))
         {
            _movie.play(actionLabel);
            _playCell = cell;
            _args = args;
         }
         else if(cell && args)
         {
            cell(args);
         }
         else if(cell)
         {
            cell();
         }
      }
      
      public function stop() : void
      {
         _movie.stop();
      }
      
      public function setActionMapping(source:String, target:String) : void
      {
         if(source.length <= 0)
         {
            return;
         }
         _labelMapping.add(source,target);
      }
      
      public function get movie() : IBoneMovie
      {
         return _movie;
      }
      
      public function get asDisplay() : *
      {
         return _movie;
      }
      
      public function dispose() : void
      {
         _movie.stop();
         _script.clear();
         _labelMapping.clear();
         if(_movie && _movie.armature)
         {
            _movie.armature.removeEventListener("complete",__onAnimationComplete);
            _movie.armature.removeEventListener("animationFrameEvent",__onFrameEventHandler);
         }
         if(_movie as DisplayObject)
         {
            ObjectUtils.disposeObject(_movie);
         }
         else
         {
            StarlingObjectUtils.disposeObject(_movie);
         }
         _gotoAction = null;
         _movie = null;
         _script = null;
         _playCell = null;
         _args = null;
         _labelMapping = null;
      }
   }
}
