package morn.core.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import morn.core.handlers.Handler;
   import morn.editor.core.IClip;
   
   [Event(name="frameChanged",type="morn.core.events.UIEvent")]
   public class FrameClip extends Component implements IClip
   {
       
      
      protected var _autoStopAtRemoved:Boolean = true;
      
      protected var _mc:MovieClip;
      
      protected var _skin:String;
      
      protected var _frame:int;
      
      protected var _autoPlay:Boolean;
      
      protected var _interval:int;
      
      protected var _to:Object;
      
      protected var _complete:Handler;
      
      protected var _isPlaying:Boolean;
      
      public function FrameClip(skin:String = null)
      {
         _interval = Config.MOVIE_INTERVAL;
         super();
         this.skin = skin;
      }
      
      override protected function initialize() : void
      {
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      protected function onAddedToStage(e:Event) : void
      {
         if(_autoPlay)
         {
            play();
         }
      }
      
      protected function onRemovedFromStage(e:Event) : void
      {
         if(_autoStopAtRemoved)
         {
            stop();
         }
      }
      
      public function get skin() : String
      {
         return _skin;
      }
      
      public function set skin(value:String) : void
      {
         if(value != null && value != "")
         {
            if(_skin != value)
            {
               _skin = value;
               mc = App.asset.getAsset(value);
            }
         }
         else
         {
            clear();
         }
      }
      
      public function get mc() : MovieClip
      {
         return _mc;
      }
      
      public function set mc(value:MovieClip) : void
      {
         if(_mc != value)
         {
            clear();
            _mc = value;
            if(_mc)
            {
               _mc.stop();
               addChild(_mc);
               _contentWidth = mc.width;
               _contentHeight = mc.height;
               mc.width = width;
               mc.height = height;
            }
         }
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         if(_mc)
         {
            _mc.width = _width;
         }
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         if(_mc)
         {
            _mc.height = _height;
         }
      }
      
      public function get frame() : int
      {
         return _frame;
      }
      
      public function set frame(value:int) : void
      {
         var handler:* = null;
         _frame = value;
         if(_mc)
         {
            _frame = _frame < _mc.totalFrames && _frame > -1?_frame:0;
            _mc.gotoAndStop(_frame + 1);
            sendEvent("frameChanged");
            if(_to && (_frame == _to || _mc.currentLabel == _to))
            {
               stop();
               _to = null;
               if(_complete != null)
               {
                  handler = _complete;
                  _complete = null;
                  handler.execute();
               }
            }
         }
      }
      
      public function get index() : int
      {
         return _frame;
      }
      
      public function set index(value:int) : void
      {
         frame = value;
      }
      
      public function get totalFrame() : int
      {
         return !!_mc?_mc.totalFrames:0;
      }
      
      public function get autoStopAtRemoved() : Boolean
      {
         return _autoStopAtRemoved;
      }
      
      public function set autoStopAtRemoved(value:Boolean) : void
      {
         _autoStopAtRemoved = value;
      }
      
      public function get autoPlay() : Boolean
      {
         return _autoPlay;
      }
      
      public function set autoPlay(value:Boolean) : void
      {
         if(_autoPlay != value)
         {
            _autoPlay = value;
            !!_autoPlay?play():stop();
         }
      }
      
      public function get interval() : int
      {
         return _interval;
      }
      
      public function set interval(value:int) : void
      {
         if(_interval != value)
         {
            _interval = value;
            if(_isPlaying)
            {
               play();
            }
         }
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(value:Boolean) : void
      {
         _isPlaying = value;
      }
      
      public function play() : void
      {
         _isPlaying = true;
         frame = _frame;
         App.timer.doLoop(_interval,loop);
      }
      
      protected function loop() : void
      {
         frame = Number(frame) + 1;
      }
      
      public function stop() : void
      {
         App.timer.clearTimer(loop);
         _isPlaying = false;
      }
      
      public function gotoAndPlay(frame:int) : void
      {
         this.frame = frame;
         play();
      }
      
      public function gotoAndStop(frame:int) : void
      {
         stop();
         this.frame = frame;
      }
      
      public function playFromTo(from:Object = null, to:Object = null, complete:Handler = null) : void
      {
         if(!from)
         {
            from = 0;
         }
         _to = to == null?_mc.totalFrames - 1:to;
         _complete = complete;
         if(from is int)
         {
            gotoAndPlay(from as int);
         }
         else
         {
            _mc.gotoAndStop(from);
            gotoAndPlay(_mc.currentFrame - 1);
         }
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is int || value is String)
         {
            frame = int(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      private function clear() : void
      {
         stop();
         if(_mc && _mc.parent)
         {
            _mc.stop();
            removeChild(_mc);
         }
         _skin = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _mc = null;
         _to = null;
         _complete = null;
      }
   }
}
