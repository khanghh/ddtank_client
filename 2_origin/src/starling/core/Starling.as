package starling.core
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.ui.Multitouch;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import starling.animation.Juggler;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.EventDispatcher;
   import starling.events.ResizeEvent;
   import starling.events.TouchProcessor;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   
   [Event(name="context3DCreate",type="starling.events.Event")]
   [Event(name="rootCreated",type="starling.events.Event")]
   [Event(name="fatalError",type="starling.events.Event")]
   [Event(name="render",type="starling.events.Event")]
   public class Starling extends EventDispatcher
   {
      
      public static const VERSION:String = "1.7";
      
      private static const PROGRAM_DATA_NAME:String = "Starling.programs";
      
      private static var sCurrent:Starling;
      
      private static var sHandleLostContext:Boolean = true;
      
      private static var sContextData:Dictionary = new Dictionary(true);
      
      private static var sAll:Vector.<Starling> = new Vector.<Starling>(0);
       
      
      private var mStage3D:Stage3D;
      
      private var mStage:starling.display.Stage;
      
      private var mRootClass:Class;
      
      private var mRoot:DisplayObject;
      
      private var mJuggler:Juggler;
      
      private var mSupport:RenderSupport;
      
      private var mTouchProcessor:TouchProcessor;
      
      private var mAntiAliasing:int;
      
      private var mSimulateMultitouch:Boolean;
      
      private var mEnableErrorChecking:Boolean;
      
      private var mLastFrameTimestamp:Number;
      
      private var mLeftMouseDown:Boolean;
      
      private var mStatsDisplay:StatsDisplay;
      
      private var mShareContext:Boolean;
      
      private var mProfile:String;
      
      private var mContext:Context3D;
      
      private var mStarted:Boolean;
      
      private var mRendering:Boolean;
      
      private var mSupportHighResolutions:Boolean;
      
      private var mViewPort:Rectangle;
      
      private var mPreviousViewPort:Rectangle;
      
      private var mClippedViewPort:Rectangle;
      
      private var mNativeStage:flash.display.Stage;
      
      private var mNativeOverlay:Sprite;
      
      private var mNativeStageContentScaleFactor:Number;
      
      public function Starling(rootClass:Class, stage:flash.display.Stage, viewPort:Rectangle = null, stage3D:Stage3D = null, renderMode:String = "auto", profile:Object = "baselineConstrained")
      {
         super();
         if(stage == null)
         {
            throw new ArgumentError("Stage must not be null");
         }
         if(viewPort == null)
         {
            viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
         }
         if(stage3D == null)
         {
            stage3D = stage.stage3Ds[0];
         }
         SystemUtil.initialize();
         sAll.push(this);
         makeCurrent();
         mRootClass = rootClass;
         mViewPort = viewPort;
         mPreviousViewPort = new Rectangle();
         mStage3D = stage3D;
         mStage = new starling.display.Stage(viewPort.width,viewPort.height,stage.color);
         mNativeOverlay = new Sprite();
         mNativeStage = stage;
         mNativeStage.addChild(mNativeOverlay);
         mNativeStageContentScaleFactor = 1;
         mTouchProcessor = new TouchProcessor(mStage);
         mJuggler = new Juggler();
         mAntiAliasing = 0;
         mSimulateMultitouch = false;
         mEnableErrorChecking = false;
         mSupportHighResolutions = false;
         mLastFrameTimestamp = getTimer() / 1000;
         mSupport = new RenderSupport();
         sContextData[stage3D] = new Dictionary();
         sContextData[stage3D]["Starling.programs"] = new Dictionary();
         stage.scaleMode = "noScale";
         stage.align = "TL";
         var _loc9_:int = 0;
         var _loc8_:* = touchEventTypes;
         for each(var touchEventType in touchEventTypes)
         {
            stage.addEventListener(touchEventType,onTouch,false,0,true);
         }
         stage.addEventListener("enterFrame",onEnterFrame,false,0,true);
         stage.addEventListener("keyDown",onKey,false,0,true);
         stage.addEventListener("keyUp",onKey,false,0,true);
         stage.addEventListener("resize",onResize,false,0,true);
         stage.addEventListener("mouseLeave",onMouseLeave,false,0,true);
         mStage3D.addEventListener("context3DCreate",onContextCreated,false,10,true);
         mStage3D.addEventListener("error",onStage3DError,false,10,true);
         if(mStage3D.context3D && mStage3D.context3D.driverInfo != "Disposed")
         {
            if(profile == "auto" || profile is Array)
            {
               throw new ArgumentError("When sharing the context3D, the actual profile has to be supplied");
            }
            mProfile = "profile" in mStage3D.context3D?mStage3D.context3D["profile"]:profile as String;
            mShareContext = true;
            setTimeout(initialize,1);
         }
         else
         {
            if(!SystemUtil.supportsDepthAndStencil)
            {
               trace("[Starling] Mask support requires \'depthAndStencil\' to be enabled in the application descriptor.");
            }
            mShareContext = false;
            requestContext3D(stage3D,renderMode,profile);
         }
      }
      
      public static function get current() : Starling
      {
         return sCurrent;
      }
      
      public static function get all() : Vector.<Starling>
      {
         return sAll;
      }
      
      public static function get context() : Context3D
      {
         return !!sCurrent?sCurrent.context:null;
      }
      
      public static function get juggler() : Juggler
      {
         return !!sCurrent?sCurrent.juggler:null;
      }
      
      public static function get contentScaleFactor() : Number
      {
         return !!sCurrent?sCurrent.contentScaleFactor:1;
      }
      
      public static function get multitouchEnabled() : Boolean
      {
         return Multitouch.inputMode == "touchPoint";
      }
      
      public static function set multitouchEnabled(value:Boolean) : void
      {
         if(sCurrent)
         {
            throw new IllegalOperationError("\'multitouchEnabled\' must be set before Starling instance is created");
         }
         Multitouch.inputMode = !!value?"touchPoint":"none";
      }
      
      public static function get handleLostContext() : Boolean
      {
         return sHandleLostContext;
      }
      
      public static function set handleLostContext(value:Boolean) : void
      {
         if(sCurrent)
         {
            throw new IllegalOperationError("\'handleLostContext\' must be set before Starling instance is created");
         }
         sHandleLostContext = value;
      }
      
      public function dispose() : void
      {
         stop(true);
         mNativeStage.removeEventListener("enterFrame",onEnterFrame,false);
         mNativeStage.removeEventListener("keyDown",onKey,false);
         mNativeStage.removeEventListener("keyUp",onKey,false);
         mNativeStage.removeEventListener("resize",onResize,false);
         mNativeStage.removeEventListener("mouseLeave",onMouseLeave,false);
         mNativeStage.removeChild(mNativeOverlay);
         mStage3D.removeEventListener("context3DCreate",onContextCreated,false);
         mStage3D.removeEventListener("error",onStage3DError,false);
         var _loc4_:int = 0;
         var _loc3_:* = touchEventTypes;
         for each(var touchEventType in touchEventTypes)
         {
            mNativeStage.removeEventListener(touchEventType,onTouch,false);
         }
         if(mStage)
         {
            mStage.dispose();
         }
         if(mSupport)
         {
            mSupport.dispose();
         }
         if(mTouchProcessor)
         {
            mTouchProcessor.dispose();
         }
         if(sCurrent == this)
         {
            sCurrent = null;
         }
         if(mContext && !mShareContext)
         {
            execute(mContext.dispose,false);
         }
         var index:int = sAll.indexOf(this);
         if(index != -1)
         {
            sAll.splice(index,1);
         }
      }
      
      private function requestContext3D(stage3D:Stage3D, renderMode:String, profile:Object) : void
      {
         stage3D = stage3D;
         renderMode = renderMode;
         profile = profile;
         requestNextProfile = function():void
         {
            currentProfile = profiles.shift();
            try
            {
               execute(mStage3D.requestContext3D,renderMode,currentProfile);
               return;
            }
            catch(error:Error)
            {
               if(profiles.length != 0)
               {
                  setTimeout(requestNextProfile,1);
               }
               else
               {
                  throw error;
               }
               return;
            }
         };
         onCreated = function(event:Event):void
         {
            var context:Context3D = stage3D.context3D;
            if(renderMode == "auto" && profiles.length != 0 && context.driverInfo.indexOf("Software") != -1)
            {
               onError(event);
            }
            else
            {
               mProfile = currentProfile;
               onFinished();
            }
         };
         onError = function(event:Event):void
         {
            if(profiles.length != 0)
            {
               event.stopImmediatePropagation();
               setTimeout(requestNextProfile,1);
            }
            else
            {
               onFinished();
            }
         };
         onFinished = function():void
         {
            mStage3D.removeEventListener("context3DCreate",onCreated);
            mStage3D.removeEventListener("error",onError);
         };
         if(profile == "auto")
         {
            var profiles:Array = ["standardExtended","standard","standardConstrained","baselineExtended","baseline","baselineConstrained"];
         }
         else if(profile is String)
         {
            profiles = [profile as String];
         }
         else if(profile is Array)
         {
            profiles = profile as Array;
         }
         else
         {
            throw new ArgumentError("Profile must be of type \'String\' or \'Array\'");
         }
         mStage3D.addEventListener("context3DCreate",onCreated,false,100);
         mStage3D.addEventListener("error",onError,false,100);
      }
      
      private function initialize() : void
      {
         makeCurrent();
         initializeGraphicsAPI();
         initializeRoot();
         mTouchProcessor.simulateMultitouch = mSimulateMultitouch;
         mLastFrameTimestamp = getTimer() / 1000;
      }
      
      private function initializeGraphicsAPI() : void
      {
         mContext = mStage3D.context3D;
         mContext.enableErrorChecking = mEnableErrorChecking;
         contextData["Starling.programs"] = new Dictionary();
         trace("[Starling] Initialization complete.");
         trace("[Starling] Display Driver:",mContext.driverInfo);
         updateViewPort(true);
         dispatchEventWith("context3DCreate",false,mContext);
      }
      
      private function initializeRoot() : void
      {
         if(mRoot == null && mRootClass != null)
         {
            mRoot = new mRootClass() as DisplayObject;
            if(mRoot == null)
            {
               throw new Error("Invalid root class: " + mRootClass);
            }
            mStage.addChildAt(mRoot,0);
            dispatchEventWith("rootCreated",false,mRoot);
         }
      }
      
      public function nextFrame() : void
      {
         var now:Number = getTimer() / 1000;
         var passedTime:* = Number(now - mLastFrameTimestamp);
         mLastFrameTimestamp = now;
         if(passedTime > 1)
         {
            passedTime = 1;
         }
         if(passedTime < 0)
         {
            passedTime = Number(1 / mNativeStage.frameRate);
         }
         advanceTime(passedTime);
         render();
      }
      
      public function advanceTime(passedTime:Number) : void
      {
         if(!contextValid)
         {
            return;
         }
         makeCurrent();
         mTouchProcessor.advanceTime(passedTime);
         mStage.advanceTime(passedTime);
         mJuggler.advanceTime(passedTime);
      }
      
      public function render() : void
      {
         if(!contextValid)
         {
            return;
         }
         makeCurrent();
         updateViewPort();
         dispatchEventWith("render");
         var scaleX:Number = mViewPort.width / mStage.stageWidth;
         var scaleY:Number = mViewPort.height / mStage.stageHeight;
         mContext.setDepthTest(false,"always");
         mContext.setCulling("none");
         mSupport.nextFrame();
         mSupport.stencilReferenceValue = 0;
         mSupport.renderTarget = null;
         mSupport.setProjectionMatrix(mViewPort.x < 0?-mViewPort.x / scaleX:0,mViewPort.y < 0?-mViewPort.y / scaleY:0,mClippedViewPort.width / scaleX,mClippedViewPort.height / scaleY,mStage.stageWidth,mStage.stageHeight,mStage.cameraPosition);
         if(!mShareContext)
         {
            RenderSupport.clear(mStage.color,1);
         }
         mStage.render(mSupport,1);
         mSupport.finishQuadBatch();
         if(mStatsDisplay)
         {
            mStatsDisplay.drawCount = mSupport.drawCount;
         }
         if(!mShareContext)
         {
            mContext.present();
         }
      }
      
      private function updateViewPort(forceUpdate:Boolean = false) : void
      {
         if(forceUpdate || mPreviousViewPort.width != mViewPort.width || mPreviousViewPort.height != mViewPort.height || mPreviousViewPort.x != mViewPort.x || mPreviousViewPort.y != mViewPort.y)
         {
            mPreviousViewPort.setTo(mViewPort.x,mViewPort.y,mViewPort.width,mViewPort.height);
            mClippedViewPort = mViewPort.intersection(new Rectangle(0,0,mNativeStage.stageWidth,mNativeStage.stageHeight));
            if(!mShareContext)
            {
               if(mProfile == "baselineConstrained")
               {
                  configureBackBuffer(32,32,mAntiAliasing,true);
               }
               mStage3D.x = mClippedViewPort.x;
               mStage3D.y = mClippedViewPort.y;
               configureBackBuffer(mClippedViewPort.width,mClippedViewPort.height,mAntiAliasing,true,mSupportHighResolutions);
               if(mSupportHighResolutions && "contentsScaleFactor" in mNativeStage)
               {
                  mNativeStageContentScaleFactor = mNativeStage["contentsScaleFactor"];
               }
               else
               {
                  mNativeStageContentScaleFactor = 1;
               }
            }
         }
      }
      
      private function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean, wantsBestResolution:Boolean = false) : void
      {
         if(enableDepthAndStencil)
         {
            enableDepthAndStencil = SystemUtil.supportsDepthAndStencil;
         }
         var configureBackBuffer:Function = mContext.configureBackBuffer;
         var methodArgs:Array = [width,height,antiAlias,enableDepthAndStencil];
         if(configureBackBuffer.length > 4)
         {
            methodArgs.push(wantsBestResolution);
         }
         configureBackBuffer.apply(mContext,methodArgs);
      }
      
      private function updateNativeOverlay() : void
      {
         mNativeOverlay.x = mViewPort.x;
         mNativeOverlay.y = mViewPort.y;
         mNativeOverlay.scaleX = mViewPort.width / mStage.stageWidth;
         mNativeOverlay.scaleY = mViewPort.height / mStage.stageHeight;
      }
      
      public function stopWithFatalError(message:String) : void
      {
         var background:Shape = new Shape();
         background.graphics.beginFill(0,0.8);
         background.graphics.drawRect(0,0,mStage.stageWidth,mStage.stageHeight);
         background.graphics.endFill();
         var textField:TextField = new TextField();
         var textFormat:TextFormat = new TextFormat("Verdana",14,16777215);
         textFormat.align = "center";
         textField.defaultTextFormat = textFormat;
         textField.wordWrap = true;
         textField.width = mStage.stageWidth * 0.75;
         textField.autoSize = "center";
         textField.text = message;
         textField.x = (mStage.stageWidth - textField.width) / 2;
         textField.y = (mStage.stageHeight - textField.height) / 2;
         textField.background = true;
         textField.backgroundColor = 5570560;
         updateNativeOverlay();
         nativeOverlay.addChild(background);
         nativeOverlay.addChild(textField);
         stop(true);
         trace("[Starling]",message);
         dispatchEventWith("fatalError",false,message);
      }
      
      public function makeCurrent() : void
      {
         sCurrent = this;
      }
      
      public function start() : void
      {
         mRendering = true;
         mStarted = true;
         mLastFrameTimestamp = getTimer() / 1000;
      }
      
      public function stop(suspendRendering:Boolean = false) : void
      {
         mStarted = false;
         mRendering = !suspendRendering;
      }
      
      private function onStage3DError(event:ErrorEvent) : void
      {
         var mode:* = null;
         if(event.errorID == 3702)
         {
            mode = Capabilities.playerType == "Desktop"?"renderMode":"wmode";
            stopWithFatalError("Context3D not available! Possible reasons: wrong " + mode + " or missing device support.");
         }
         else
         {
            stopWithFatalError("Stage3D error: " + event.text);
         }
      }
      
      private function onContextCreated(event:Event) : void
      {
         if(!Starling.handleLostContext && mContext)
         {
            event.stopImmediatePropagation();
            stopWithFatalError("The application lost the device context!");
            trace("[Starling] Enable \'Starling.handleLostContext\' to avoid this error.");
         }
         else
         {
            initialize();
         }
      }
      
      private function onEnterFrame(event:Event) : void
      {
         if(!mShareContext)
         {
            if(mStarted)
            {
               nextFrame();
            }
            else if(mRendering)
            {
               render();
            }
         }
         updateNativeOverlay();
      }
      
      private function onKey(event:flash.events.KeyboardEvent) : void
      {
         if(!mStarted)
         {
            return;
         }
         var keyEvent:starling.events.KeyboardEvent = new starling.events.KeyboardEvent(event.type,event.charCode,event.keyCode,event.keyLocation,event.ctrlKey,event.altKey,event.shiftKey);
         makeCurrent();
         mStage.broadcastEvent(keyEvent);
         if(keyEvent.isDefaultPrevented())
         {
            event.preventDefault();
         }
      }
      
      private function onResize(event:Event) : void
      {
         event = event;
         dispatchResizeEvent = function():void
         {
            makeCurrent();
            removeEventListener("context3DCreate",dispatchResizeEvent);
            mStage.dispatchEvent(new ResizeEvent("resize",stageWidth,stageHeight));
         };
         var stageWidth:int = event.target.stageWidth;
         var stageHeight:int = event.target.stageHeight;
         if(contextValid)
         {
            dispatchResizeEvent();
         }
         else
         {
            addEventListener("context3DCreate",dispatchResizeEvent);
         }
      }
      
      private function onMouseLeave(event:Event) : void
      {
         mTouchProcessor.enqueueMouseLeftStage();
      }
      
      private function onTouch(event:Event) : void
      {
         var globalX:Number = NaN;
         var globalY:Number = NaN;
         var touchID:int = 0;
         var phase:* = null;
         var mouseEvent:* = null;
         var touchEvent:* = null;
         if(!mStarted)
         {
            return;
         }
         var pressure:* = 1;
         var width:* = 1;
         var height:* = 1;
         if(event is MouseEvent)
         {
            mouseEvent = event as MouseEvent;
            globalX = mouseEvent.stageX;
            globalY = mouseEvent.stageY;
            touchID = 0;
            if(event.type == "mouseDown")
            {
               mLeftMouseDown = true;
            }
            else if(event.type == "mouseUp")
            {
               mLeftMouseDown = false;
            }
         }
         else
         {
            touchEvent = event as TouchEvent;
            if(Mouse.supportsCursor && touchEvent.isPrimaryTouchPoint)
            {
               return;
            }
            globalX = touchEvent.stageX;
            globalY = touchEvent.stageY;
            touchID = touchEvent.touchPointID;
            pressure = Number(touchEvent.pressure);
            width = Number(touchEvent.sizeX);
            height = Number(touchEvent.sizeY);
         }
         var _loc11_:* = event.type;
         if("touchBegin" !== _loc11_)
         {
            if("touchMove" !== _loc11_)
            {
               if("touchEnd" !== _loc11_)
               {
                  if("mouseDown" !== _loc11_)
                  {
                     if("mouseUp" !== _loc11_)
                     {
                        if("mouseMove" === _loc11_)
                        {
                           phase = !!mLeftMouseDown?"moved":"hover";
                        }
                     }
                     else
                     {
                        phase = "ended";
                     }
                  }
                  else
                  {
                     phase = "began";
                  }
               }
               else
               {
                  phase = "ended";
               }
            }
            else
            {
               phase = "moved";
            }
         }
         else
         {
            phase = "began";
         }
         globalX = mStage.stageWidth * (globalX - mViewPort.x) / mViewPort.width;
         globalY = mStage.stageHeight * (globalY - mViewPort.y) / mViewPort.height;
         mTouchProcessor.enqueue(touchID,phase,globalX,globalY,pressure,width,height);
         if(event.type == "mouseUp" && Mouse.supportsCursor)
         {
            mTouchProcessor.enqueue(touchID,"hover",globalX,globalY);
         }
      }
      
      private function get touchEventTypes() : Array
      {
         var types:Array = [];
         if(multitouchEnabled)
         {
            types.push("touchBegin","touchMove","touchEnd");
         }
         if(!multitouchEnabled || Mouse.supportsCursor)
         {
            types.push("mouseDown","mouseMove","mouseUp");
         }
         return types;
      }
      
      public function registerProgram(name:String, vertexShader:ByteArray, fragmentShader:ByteArray) : Program3D
      {
         deleteProgram(name);
         var program:Program3D = mContext.createProgram();
         program.upload(vertexShader,fragmentShader);
         programs[name] = program;
         return program;
      }
      
      public function registerProgramFromSource(name:String, vertexShader:String, fragmentShader:String) : Program3D
      {
         deleteProgram(name);
         var program:Program3D = RenderSupport.assembleAgal(vertexShader,fragmentShader);
         programs[name] = program;
         return program;
      }
      
      public function deleteProgram(name:String) : void
      {
         var program:Program3D = getProgram(name);
         if(program)
         {
            program.dispose();
            delete programs[name];
         }
      }
      
      public function getProgram(name:String) : Program3D
      {
         return programs[name] as Program3D;
      }
      
      public function hasProgram(name:String) : Boolean
      {
         return name in programs;
      }
      
      private function get programs() : Dictionary
      {
         return contextData["Starling.programs"];
      }
      
      public function get isStarted() : Boolean
      {
         return mStarted;
      }
      
      public function get juggler() : Juggler
      {
         return mJuggler;
      }
      
      public function get context() : Context3D
      {
         return mContext;
      }
      
      public function get contextData() : Dictionary
      {
         return sContextData[mStage3D] as Dictionary;
      }
      
      public function get backBufferWidth() : int
      {
         return mClippedViewPort.width;
      }
      
      public function get backBufferHeight() : int
      {
         return mClippedViewPort.height;
      }
      
      public function get backBufferPixelsPerPoint() : int
      {
         return mNativeStageContentScaleFactor;
      }
      
      public function get simulateMultitouch() : Boolean
      {
         return mSimulateMultitouch;
      }
      
      public function set simulateMultitouch(value:Boolean) : void
      {
         mSimulateMultitouch = value;
         if(mContext)
         {
            mTouchProcessor.simulateMultitouch = value;
         }
      }
      
      public function get enableErrorChecking() : Boolean
      {
         return mEnableErrorChecking;
      }
      
      public function set enableErrorChecking(value:Boolean) : void
      {
         mEnableErrorChecking = value;
         if(mContext)
         {
            mContext.enableErrorChecking = value;
         }
      }
      
      public function get antiAliasing() : int
      {
         return mAntiAliasing;
      }
      
      public function set antiAliasing(value:int) : void
      {
         if(mAntiAliasing != value)
         {
            mAntiAliasing = value;
            if(contextValid)
            {
               updateViewPort(true);
            }
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return mViewPort;
      }
      
      public function set viewPort(value:Rectangle) : void
      {
         mViewPort = value.clone();
      }
      
      public function get contentScaleFactor() : Number
      {
         return mViewPort.width * mNativeStageContentScaleFactor / mStage.stageWidth;
      }
      
      public function get nativeOverlay() : Sprite
      {
         return mNativeOverlay;
      }
      
      public function get showStats() : Boolean
      {
         return mStatsDisplay && mStatsDisplay.parent;
      }
      
      public function set showStats(value:Boolean) : void
      {
         if(value == showStats)
         {
            return;
         }
         if(value)
         {
            if(mStatsDisplay)
            {
               mStage.addChild(mStatsDisplay);
            }
            else
            {
               showStatsAt();
            }
         }
         else
         {
            mStatsDisplay.removeFromParent();
         }
      }
      
      public function showStatsAt(hAlign:String = "left", vAlign:String = "top", scale:Number = 1) : void
      {
         hAlign = hAlign;
         vAlign = vAlign;
         scale = scale;
         onRootCreated = function():void
         {
            showStatsAt(hAlign,vAlign,scale);
            removeEventListener("rootCreated",onRootCreated);
         };
         if(mContext == null)
         {
            addEventListener("rootCreated",onRootCreated);
         }
         else
         {
            if(mStatsDisplay == null)
            {
               mStatsDisplay = new StatsDisplay();
               mStatsDisplay.touchable = false;
               mStage.addChild(mStatsDisplay);
            }
            var stageWidth:int = mStage.stageWidth;
            var stageHeight:int = mStage.stageHeight;
            var _loc5_:* = scale;
            mStatsDisplay.scaleY = _loc5_;
            mStatsDisplay.scaleX = _loc5_;
            if(hAlign == "left")
            {
               mStatsDisplay.x = 0;
            }
            else if(hAlign == "right")
            {
               mStatsDisplay.x = stageWidth - mStatsDisplay.width;
            }
            else
            {
               mStatsDisplay.x = int((stageWidth - mStatsDisplay.width) / 2);
            }
            if(vAlign == "top")
            {
               mStatsDisplay.y = 0;
            }
            else if(vAlign == "bottom")
            {
               mStatsDisplay.y = stageHeight - mStatsDisplay.height;
            }
            else
            {
               mStatsDisplay.y = int((stageHeight - mStatsDisplay.height) / 2);
            }
         }
      }
      
      public function get stage() : starling.display.Stage
      {
         return mStage;
      }
      
      public function get stage3D() : Stage3D
      {
         return mStage3D;
      }
      
      public function get nativeStage() : flash.display.Stage
      {
         return mNativeStage;
      }
      
      public function get root() : DisplayObject
      {
         return mRoot;
      }
      
      public function get rootClass() : Class
      {
         return mRootClass;
      }
      
      public function set rootClass(value:Class) : void
      {
         if(mRootClass != null && mRoot != null)
         {
            throw new Error("Root class may not change after root has been instantiated");
         }
         if(mRootClass == null)
         {
            mRootClass = value;
            if(mContext)
            {
               initializeRoot();
            }
         }
      }
      
      public function get shareContext() : Boolean
      {
         return mShareContext;
      }
      
      public function set shareContext(value:Boolean) : void
      {
         mShareContext = value;
      }
      
      public function get profile() : String
      {
         return mProfile;
      }
      
      public function get supportHighResolutions() : Boolean
      {
         return mSupportHighResolutions;
      }
      
      public function set supportHighResolutions(value:Boolean) : void
      {
         if(mSupportHighResolutions != value)
         {
            mSupportHighResolutions = value;
            if(contextValid)
            {
               updateViewPort(true);
            }
         }
      }
      
      public function get touchProcessor() : TouchProcessor
      {
         return mTouchProcessor;
      }
      
      public function set touchProcessor(value:TouchProcessor) : void
      {
         if(value != mTouchProcessor)
         {
            mTouchProcessor.dispose();
            mTouchProcessor = value;
         }
      }
      
      public function get contextValid() : Boolean
      {
         var _loc1_:* = null;
         if(mContext)
         {
            _loc1_ = mContext.driverInfo;
            return _loc1_ != null && _loc1_ != "" && _loc1_ != "Disposed";
         }
         return false;
      }
   }
}
