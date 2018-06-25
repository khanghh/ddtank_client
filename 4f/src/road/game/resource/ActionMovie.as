package road.game.resource{   import flash.display.FrameLabel;   import flash.display.MovieClip;   import flash.events.Event;   import flash.geom.Point;   import flash.media.SoundTransform;   import flash.utils.Dictionary;   import flash.utils.getDefinitionByName;      public class ActionMovie extends MovieClip   {            public static var LEFT:String = "left";            public static var RIGHT:String = "right";            public static var DEFAULT_ACTION:String = "stand";            public static var STAND_ACTION:String = "stand";                   private var _labelLastFrames:Array;            private var _soundControl:SoundTransform;            private var _labelLastFrame:Dictionary;            private var _currentAction:String;            private var lastAction:String = "";            private var _callBacks:Dictionary;            private var _argsDic:Dictionary;            private var _actionEnded:Boolean = true;            protected var _actionRelative:Object;            public var labelMapping:Dictionary;            private var _soundEffectInstance;            private var _shouldReplace:Boolean = true;            private var _die:MovieClip;            private var _isMute:Boolean = false;            public function ActionMovie() { super(); }
            public function get shouldReplace() : Boolean { return false; }
            public function set shouldReplace(value:Boolean) : void { }
            private function initMovie() : void { }
            private function addEvent() : void { }
            public function doAction(type:String, callBack:Function = null, args:Array = null) : void { }
            private function hasThisAction(type:String) : Boolean { return false; }
            private function loop(e:Event) : void { }
            private function callCallBack(key:String) : void { }
            private function deleteFun(key:String) : void { }
            private function callFun(fun:Function, args:Array) : void { }
            public function get currentAction() : String { return null; }
            public function setActionRelative(value:Object) : void { }
            public function get popupPos() : Point { return null; }
            public function get popupDir() : Point { return null; }
            public function set direction(value:String) : void { }
            public function get direction() : String { return null; }
            public function setActionMapping(source:String, target:String) : void { }
            private function stopMovieClip(mc:MovieClip) : void { }
            override public function gotoAndStop(frame:Object, scene:String = null) : void { }
            protected function endAction() : void { }
            protected function startAction() : void { }
            protected function send(type:String) : void { }
            protected function sendCommand(type:String, data:Object = null) : void { }
            override public function gotoAndPlay(frame:Object, scene:String = null) : void { }
            public function MCGotoAndPlay(frame:Object) : void { }
            private function __onActionEnd(evt:ActionMovieEvent) : void { }
            public function get versionTag() : String { return null; }
            public function doSomethingSpecial() : void { }
            public function mute() : void { }
            public function dispose() : void { }
   }}