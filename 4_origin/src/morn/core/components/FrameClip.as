package morn.core.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import morn.core.events.UIEvent;
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
      
      public function FrameClip(param1:String = null)
      {
         this._interval = Config.MOVIE_INTERVAL;
         super();
         this.skin = param1;
      }
      
      override protected function initialize() : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         if(this._autoPlay)
         {
            this.play();
         }
      }
      
      protected function onRemovedFromStage(param1:Event) : void
      {
         if(this._autoStopAtRemoved)
         {
            this.stop();
         }
      }
      
      public function get skin() : String
      {
         return this._skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(param1 != null && param1 != "")
         {
            if(this._skin != param1)
            {
               this._skin = param1;
               this.mc = App.asset.getAsset(param1);
            }
         }
         else
         {
            this.clear();
         }
      }
      
      public function get mc() : MovieClip
      {
         return this._mc;
      }
      
      public function set mc(param1:MovieClip) : void
      {
         if(this._mc != param1)
         {
            this.clear();
            this._mc = param1;
            if(this._mc)
            {
               this._mc.stop();
               addChild(this._mc);
               _contentWidth = this.mc.width;
               _contentHeight = this.mc.height;
               this.mc.width = width;
               this.mc.height = height;
            }
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(this._mc)
         {
            this._mc.width = _width;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(this._mc)
         {
            this._mc.height = _height;
         }
      }
      
      public function get frame() : int
      {
         return this._frame;
      }
      
      public function set frame(param1:int) : void
      {
         var _loc2_:Handler = null;
         this._frame = param1;
         if(this._mc)
         {
            this._frame = this._frame < this._mc.totalFrames && this._frame > -1?int(this._frame):0;
            this._mc.gotoAndStop(this._frame + 1);
            sendEvent(UIEvent.FRAME_CHANGED);
            if(this._to && (this._frame == this._to || this._mc.currentLabel == this._to))
            {
               this.stop();
               this._to = null;
               if(this._complete != null)
               {
                  _loc2_ = this._complete;
                  this._complete = null;
                  _loc2_.execute();
               }
            }
         }
      }
      
      public function get index() : int
      {
         return this._frame;
      }
      
      public function set index(param1:int) : void
      {
         this.frame = param1;
      }
      
      public function get totalFrame() : int
      {
         return !!this._mc?int(this._mc.totalFrames):0;
      }
      
      public function get autoStopAtRemoved() : Boolean
      {
         return this._autoStopAtRemoved;
      }
      
      public function set autoStopAtRemoved(param1:Boolean) : void
      {
         this._autoStopAtRemoved = param1;
      }
      
      public function get autoPlay() : Boolean
      {
         return this._autoPlay;
      }
      
      public function set autoPlay(param1:Boolean) : void
      {
         if(this._autoPlay != param1)
         {
            this._autoPlay = param1;
            if(this._autoPlay)
            {
               this.play();
            }
            else
            {
               this.stop();
            }
         }
      }
      
      public function get interval() : int
      {
         return this._interval;
      }
      
      public function set interval(param1:int) : void
      {
         if(this._interval != param1)
         {
            this._interval = param1;
            if(this._isPlaying)
            {
               this.play();
            }
         }
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         this._isPlaying = param1;
      }
      
      public function play() : void
      {
         this._isPlaying = true;
         this.frame = this._frame;
         App.timer.doLoop(this._interval,this.loop);
      }
      
      protected function loop() : void
      {
         this.frame++;
      }
      
      public function stop() : void
      {
         App.timer.clearTimer(this.loop);
         this._isPlaying = false;
      }
      
      public function gotoAndPlay(param1:int) : void
      {
         this.frame = param1;
         this.play();
      }
      
      public function gotoAndStop(param1:int) : void
      {
         this.stop();
         this.frame = param1;
      }
      
      public function playFromTo(param1:Object = null, param2:Object = null, param3:Handler = null) : void
      {
         param1 = param1 || 0;
         this._to = param2 == null?this._mc.totalFrames - 1:param2;
         this._complete = param3;
         if(param1 is int)
         {
            this.gotoAndPlay(param1 as int);
         }
         else
         {
            this._mc.gotoAndStop(param1);
            this.gotoAndPlay(this._mc.currentFrame - 1);
         }
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is int || param1 is String)
         {
            this.frame = int(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      private function clear() : void
      {
         this.stop();
         if(this._mc && this._mc.parent)
         {
            this._mc.stop();
            removeChild(this._mc);
         }
         this._skin = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._mc = null;
         this._to = null;
         this._complete = null;
      }
   }
}
