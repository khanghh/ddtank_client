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
         var sClass:* = undefined;
         _labelLastFrames = [];
         _labelLastFrame = new Dictionary();
         _argsDic = new Dictionary();
         labelMapping = new Dictionary();
         super();
         try
         {
            sClass = getDefinitionByName("ddt.manager.SoundEffectManager");
            if(sClass)
            {
               _soundEffectInstance = sClass.Instance;
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
      
      public function set shouldReplace(value:Boolean) : void
      {
         _shouldReplace = value;
      }
      
      private function initMovie() : void
      {
         var i:int = 0;
         var labels:Array = currentLabels;
         if(labels.length > 0)
         {
            for(i = 0; i < labels.length; )
            {
               if(i != 0)
               {
                  _labelLastFrame[labels[i - 1].name] = int(labels[i].frame - 1);
               }
               i++;
            }
            _labelLastFrame[labels[labels.length - 1].name] = int(totalFrames);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("actionEnd",__onActionEnd);
      }
      
      public function doAction(type:String, callBack:Function = null, args:Array = null) : void
      {
         var actionLabel:* = null;
         if(labelMapping[type])
         {
            actionLabel = labelMapping[type];
         }
         else
         {
            actionLabel = type;
         }
         if(!hasThisAction(actionLabel))
         {
            if(callBack != null)
            {
               callFun(callBack,args);
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
         if(callBack != null && _callBacks != null && _callBacks[actionLabel] != callBack)
         {
            _callBacks[actionLabel] = callBack;
            _argsDic[actionLabel] = args;
         }
         lastAction = currentAction;
         _currentAction = actionLabel;
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
      
      private function hasThisAction(type:String) : Boolean
      {
         var result:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = currentLabels;
         for each(var i in currentLabels)
         {
            if(i.name == type)
            {
               result = true;
               break;
            }
         }
         return result;
      }
      
      private function loop(e:Event) : void
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
      
      private function callCallBack(key:String) : void
      {
         var args:Array = _argsDic[key];
         if(_callBacks[key] == null)
         {
            return;
         }
         callFun(_callBacks[key],args);
         deleteFun(key);
      }
      
      private function deleteFun(key:String) : void
      {
         if(_callBacks)
         {
            _callBacks[key] = null;
            delete _callBacks[key];
         }
         if(_argsDic)
         {
            _argsDic[key] = null;
            delete _argsDic[key];
         }
      }
      
      private function callFun(fun:Function, args:Array) : void
      {
         if(args == null || args.length == 0)
         {
            fun();
         }
         else if(args.length == 1)
         {
            fun(args[0]);
         }
         else if(args.length == 2)
         {
            fun(args[0],args[1]);
         }
         else if(args.length == 3)
         {
            fun(args[0],args[1],args[2]);
         }
         else if(args.length == 4)
         {
            fun(args[0],args[1],args[2],args[3]);
         }
      }
      
      public function get currentAction() : String
      {
         return _currentAction;
      }
      
      public function setActionRelative(value:Object) : void
      {
         _actionRelative = value;
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
      
      public function set direction(value:String) : void
      {
         if(ActionMovie.LEFT == value)
         {
            scaleX = 1;
         }
         else if(ActionMovie.RIGHT == value)
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
      
      public function setActionMapping(source:String, target:String) : void
      {
         if(source.length <= 0)
         {
            return;
         }
         labelMapping[source] = target;
      }
      
      private function stopMovieClip(mc:MovieClip) : void
      {
         var i:int = 0;
         if(mc)
         {
            mc.gotoAndStop(1);
            if(mc.numChildren > 0)
            {
               for(i = 0; i < mc.numChildren; )
               {
                  stopMovieClip(mc.getChildAt(i) as MovieClip);
                  i++;
               }
            }
         }
      }
      
      override public function gotoAndStop(frame:Object, scene:String = null) : void
      {
         if(frame is String)
         {
            var _loc5_:int = 0;
            var _loc4_:* = currentLabels;
            for each(var s in currentLabels)
            {
               if(s.name == frame)
               {
                  super.gotoAndStop(frame);
                  return;
               }
            }
         }
         else
         {
            super.gotoAndStop(frame);
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
      
      protected function send(type:String) : void
      {
         dispatchEvent(new ActionMovieEvent(type));
      }
      
      protected function sendCommand(type:String, data:Object = null) : void
      {
         dispatchEvent(new ActionMovieEvent(type,data));
      }
      
      override public function gotoAndPlay(frame:Object, scene:String = null) : void
      {
         doAction(String(frame));
      }
      
      public function MCGotoAndPlay(frame:Object) : void
      {
         super.gotoAndPlay(frame);
      }
      
      private function __onActionEnd(evt:ActionMovieEvent) : void
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
