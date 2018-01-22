package road.game.resource
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class ActionMovie extends MovieClip
   {
      
      public static var LEFT:String = "left";
      
      public static var RIGHT:String = "right";
      
      public static var DEFAULT_ACTION:String = "stand";
      
      public static var STAND_ACTION:String = "stand";
       
      
      private var _labelLastFrames:Array;
      
      private var _soundControl:SoundTransform;
      
      private var _labelLastFrame:Dictionary;
      
      private var _currentAction:String;
      
      private var lastAction:String = "";
      
      private var _callBacks:Dictionary;
      
      private var _argsDic:Dictionary;
      
      private var _actionEnded:Boolean = true;
      
      protected var _actionRelative:Object;
      
      public var labelMapping:Dictionary;
      
      private var _soundEffectInstance;
      
      private var _shouldReplace:Boolean = true;
      
      private var _die:MovieClip;
      
      private var _isMute:Boolean = false;
      
      public function ActionMovie()
      {
         var _loc1_:* = undefined;
         _labelLastFrames = [];
         _labelLastFrame = new Dictionary();
         _argsDic = new Dictionary();
         labelMapping = new Dictionary();
         super();
         try
         {
            _loc1_ = getDefinitionByName("ddt.manager.SoundEffectManager");
            if(_loc1_)
            {
               _soundEffectInstance = _loc1_.Instance;
            }
         }
         catch(e:Error)
         {
         }
         _callBacks = new Dictionary();
         mouseEnabled = false;
         mouseChildren = false;
         scrollRect = null;
         _soundControl = new SoundTransform();
         soundTransform = _soundControl;
         initMovie();
         addEvent();
      }
      
      public function get shouldReplace() : Boolean
      {
         return _shouldReplace;
      }
      
      public function set shouldReplace(param1:Boolean) : void
      {
         _shouldReplace = param1;
      }
      
      private function initMovie() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = currentLabels;
         if(_loc1_.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               if(_loc2_ != 0)
               {
                  _labelLastFrame[_loc1_[_loc2_ - 1].name] = int(_loc1_[_loc2_].frame - 1);
               }
               _loc2_++;
            }
            _labelLastFrame[_loc1_[_loc1_.length - 1].name] = int(totalFrames);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("actionEnd",__onActionEnd);
      }
      
      public function doAction(param1:String, param2:Function = null, param3:Array = null) : void
      {
         var _loc4_:* = null;
         if(labelMapping[param1])
         {
            _loc4_ = labelMapping[param1];
         }
         else
         {
            _loc4_ = param1;
         }
         if(!hasThisAction(_loc4_))
         {
            if(param2 != null)
            {
               callFun(param2,param3);
            }
            return;
         }
         if(!_actionEnded)
         {
            _actionEnded = true;
            if(_callBacks && _callBacks[currentAction] != null)
            {
               callCallBack(currentAction);
            }
            dispatchEvent(new ActionMovieEvent("actionEnd"));
         }
         _actionEnded = false;
         if(param2 != null && _callBacks != null && _callBacks[_loc4_] != param2)
         {
            _callBacks[_loc4_] = param2;
            _argsDic[_loc4_] = param3;
         }
         lastAction = currentAction;
         _currentAction = _loc4_;
         if(_soundControl)
         {
            _soundControl.volume = !!_isMute?0:1;
         }
         if(soundTransform && _soundControl)
         {
            soundTransform = _soundControl;
         }
         addEventListener("enterFrame",loop);
         MCGotoAndPlay(currentAction);
         dispatchEvent(new ActionMovieEvent("actionStart"));
      }
      
      private function hasThisAction(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = currentLabels;
         for each(var _loc3_ in currentLabels)
         {
            if(_loc3_.name == param1)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      private function loop(param1:Event) : void
      {
         if(currentFrame == _labelLastFrame[currentAction] || currentLabel != currentAction)
         {
            removeEventListener("enterFrame",loop);
            _actionEnded = true;
            if(_callBacks && _callBacks[currentAction] != null)
            {
               callCallBack(currentAction);
            }
            dispatchEvent(new ActionMovieEvent("actionEnd"));
         }
      }
      
      private function callCallBack(param1:String) : void
      {
         var _loc2_:Array = _argsDic[param1];
         if(_callBacks[param1] == null)
         {
            return;
         }
         callFun(_callBacks[param1],_loc2_);
         deleteFun(param1);
      }
      
      private function deleteFun(param1:String) : void
      {
         if(_callBacks)
         {
            _callBacks[param1] = null;
            delete _callBacks[param1];
         }
         if(_argsDic)
         {
            _argsDic[param1] = null;
            delete _argsDic[param1];
         }
      }
      
      private function callFun(param1:Function, param2:Array) : void
      {
         if(param2 == null || param2.length == 0)
         {
            param1();
         }
         else if(param2.length == 1)
         {
            param1(param2[0]);
         }
         else if(param2.length == 2)
         {
            param1(param2[0],param2[1]);
         }
         else if(param2.length == 3)
         {
            param1(param2[0],param2[1],param2[2]);
         }
         else if(param2.length == 4)
         {
            param1(param2[0],param2[1],param2[2],param2[3]);
         }
      }
      
      public function get currentAction() : String
      {
         return _currentAction;
      }
      
      public function setActionRelative(param1:Object) : void
      {
         _actionRelative = param1;
      }
      
      public function get popupPos() : Point
      {
         if(this["_popPos"])
         {
            return new Point(this["_popPos"].x * scaleX,this["_popPos"].y);
         }
         return null;
      }
      
      public function get popupDir() : Point
      {
         if(this["_popDir"])
         {
            return new Point(this["_popDir"].x,this["_popDir"].y);
         }
         return null;
      }
      
      public function set direction(param1:String) : void
      {
         if(ActionMovie.LEFT == param1)
         {
            scaleX = 1;
         }
         else if(ActionMovie.RIGHT == param1)
         {
            scaleX = -1;
         }
      }
      
      public function get direction() : String
      {
         if(scaleX > 0)
         {
            return ActionMovie.LEFT;
         }
         return ActionMovie.RIGHT;
      }
      
      public function setActionMapping(param1:String, param2:String) : void
      {
         if(param1.length <= 0)
         {
            return;
         }
         labelMapping[param1] = param2;
      }
      
      private function stopMovieClip(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            param1.gotoAndStop(1);
            if(param1.numChildren > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.numChildren)
               {
                  stopMovieClip(param1.getChildAt(_loc2_) as MovieClip);
                  _loc2_++;
               }
            }
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(param1 is String)
         {
            var _loc5_:int = 0;
            var _loc4_:* = currentLabels;
            for each(var _loc3_ in currentLabels)
            {
               if(_loc3_.name == param1)
               {
                  super.gotoAndStop(param1);
                  return;
               }
            }
         }
         else
         {
            super.gotoAndStop(param1);
         }
      }
      
      protected function endAction() : void
      {
         dispatchEvent(new ActionMovieEvent("end"));
      }
      
      protected function startAction() : void
      {
         dispatchEvent(new ActionMovieEvent("start"));
      }
      
      protected function send(param1:String) : void
      {
         dispatchEvent(new ActionMovieEvent(param1));
      }
      
      protected function sendCommand(param1:String, param2:Object = null) : void
      {
         dispatchEvent(new ActionMovieEvent(param1,param2));
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         doAction(String(param1));
      }
      
      public function MCGotoAndPlay(param1:Object) : void
      {
         super.gotoAndPlay(param1);
      }
      
      private function __onActionEnd(param1:ActionMovieEvent) : void
      {
         if(!_actionRelative)
         {
            return;
         }
         if(!_actionRelative[_currentAction])
         {
            doAction(DEFAULT_ACTION);
            return;
         }
         if(_actionRelative[_currentAction] is Function)
         {
            _actionRelative[_currentAction]();
         }
         else
         {
            doAction(_actionRelative[_currentAction]);
         }
      }
      
      public function get versionTag() : String
      {
         return "road.game.resource.ActionMovie version:1.02";
      }
      
      public function doSomethingSpecial() : void
      {
      }
      
      public function mute() : void
      {
         _soundControl.volume = 0;
         _isMute = true;
      }
      
      public function dispose() : void
      {
         if(_soundControl)
         {
            _soundControl.volume = 0;
         }
         removeEventListener("enterFrame",loop);
         stopMovieClip(this);
         stop();
         _soundControl = null;
         _labelLastFrames = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _callBacks = null;
      }
   }
}
