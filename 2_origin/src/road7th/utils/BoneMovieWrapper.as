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
      
      public function BoneMovieWrapper(param1:*, param2:Boolean = false, param3:Boolean = false, param4:int = 0)
      {
         super();
         if(param1 is String)
         {
            _movie = BoneMovieFactory.instance.creatBoneMovie(param1,param4);
         }
         else if(param1 is IBoneMovie)
         {
            _movie = param1;
         }
         _movie.stop();
         _autoDisappear = param3;
         _autoPlay = param2;
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
         addFrameScript("goto",function(param1:BoneMovieWrapper, param2:Array = null):void
         {
            _gotoAction = param2[0] as String;
         });
         addFrameScript("gotoplay",function(param1:BoneMovieWrapper, param2:Array = null):void
         {
            param1.playAction(param2[0]);
         });
         addFrameScript("dispose",function(param1:BoneMovieWrapper, param2:Array = null):void
         {
            param1.dispose();
         });
         addFrameScript("sound",function(param1:BoneMovieWrapper, param2:Array = null):void
         {
            var _loc3_:* = null;
            if(SoundEventManager.getInstance().hasEventListener("sound"))
            {
               _loc3_ = new SoundEvent("sound");
               _loc3_.animationState = param1.movie.animationState;
               _loc3_.sound = param2[0];
               SoundEventManager.getInstance().dispatchEvent(_loc3_);
            }
         });
         addFrameScript("stop",function(param1:BoneMovieWrapper, param2:Array = null):void
         {
            param1.movie.stop();
         });
      }
      
      private function __onFrameEventHandler(param1:FrameEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = param1.frameLabel;
         var _loc3_:* = _loc5_;
         if(_loc5_ == "")
         {
            return;
         }
         var _loc2_:Array = null;
         if(!(_loc5_ == "frame" || _loc5_ == "dispose"))
         {
            _loc4_ = _loc5_.indexOf("_");
            if(_loc4_ < 0)
            {
               throw new Error(_movie.armature.name + " boneMovie:: " + _loc5_ + " 帧事件 未指定参数！请尽快解决");
            }
            _loc3_ = _loc5_.slice(0,_loc4_);
            _loc2_ = param1.frameLabel.slice(_loc4_ + 1,param1.frameLabel.length).split("|");
         }
         if(_script.hasKey(_loc3_))
         {
            _script[_loc3_](this,_loc2_);
         }
      }
      
      private function __onAnimationComplete(param1:AnimationEvent) : void
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
      
      public function addFrameScript(param1:String, param2:Function, param3:Boolean = true) : void
      {
         if(_script.hasKey(param1) && !param3)
         {
            return;
         }
         _script.add(param1,param2);
      }
      
      public function removeFrameScript(param1:String) : void
      {
         _script.remove(param1);
      }
      
      public function removeFrameScriptAll() : void
      {
         _script.clear();
      }
      
      public function playAction(param1:String = "", param2:Function = null, param3:Array = null) : void
      {
         var _loc4_:* = null;
         if(_labelMapping.hasKey(param1))
         {
            _loc4_ = _labelMapping[param1];
         }
         else
         {
            _loc4_ = param1;
         }
         if(_loc4_ == "" || _movie.armature && _movie.armature.animation.hasAnimation(_loc4_))
         {
            _movie.play(_loc4_);
            _playCell = param2;
            _args = param3;
         }
         else if(param2 && param3)
         {
            param2(param3);
         }
         else if(param2)
         {
            param2();
         }
      }
      
      public function stop() : void
      {
         _movie.stop();
      }
      
      public function setActionMapping(param1:String, param2:String) : void
      {
         if(param1.length <= 0)
         {
            return;
         }
         _labelMapping.add(param1,param2);
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
