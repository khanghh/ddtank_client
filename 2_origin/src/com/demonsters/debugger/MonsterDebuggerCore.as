package com.demonsters.debugger
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import starling.core.Starling;
   
   class MonsterDebuggerCore
   {
      
      private static const MONITOR_UPDATE:int = 1000;
      
      private static const HIGHLITE_COLOR:uint = 3381759;
      
      private static var _monitorTimer:Timer;
      
      private static var _monitorSprite:Sprite;
      
      private static var _monitorTime:Number;
      
      private static var _monitorStart:Number;
      
      private static var _monitorFrames:int;
      
      private static var _base:Object = null;
      
      private static var _stage:flash.display.Stage = null;
      
      private static var _starlingStage:starling.display.Stage = null;
      
      private static var _highlight:Sprite;
      
      private static var _highlightInfo:TextField;
      
      private static var _highlightTarget:flash.display.DisplayObject;
      
      private static var _starlingHighlightTarget:starling.display.DisplayObject;
      
      private static var _highlightMouse:Boolean;
      
      private static var _highlightUpdate:Boolean;
      
      static const ID:String = "com.demonsters.debugger.core";
       
      
      function MonsterDebuggerCore()
      {
         super();
      }
      
      static function initialize() : void
      {
         _monitorTime = new Date().time;
         _monitorStart = new Date().time;
         _monitorFrames = 0;
         _monitorTimer = new Timer(1000);
         _monitorTimer.addEventListener("timer",monitorTimerCallback,false,0,true);
         _monitorTimer.start();
         if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is flash.display.Stage)
         {
            _stage = _base["stage"] as flash.display.Stage;
         }
         if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is starling.display.Stage)
         {
            _starlingStage = _base["stage"] as starling.display.Stage;
         }
         _monitorSprite = new Sprite();
         _monitorSprite.addEventListener("enterFrame",frameHandler,false,0,true);
         var format:TextFormat = new TextFormat();
         format.font = "Arial";
         format.color = 16777215;
         format.size = 11;
         format.leftMargin = 5;
         format.rightMargin = 5;
         _highlightInfo = new TextField();
         _highlightInfo.embedFonts = false;
         _highlightInfo.autoSize = "left";
         _highlightInfo.mouseWheelEnabled = false;
         _highlightInfo.mouseEnabled = false;
         _highlightInfo.condenseWhite = false;
         _highlightInfo.embedFonts = false;
         _highlightInfo.multiline = false;
         _highlightInfo.selectable = false;
         _highlightInfo.wordWrap = false;
         _highlightInfo.defaultTextFormat = format;
         _highlightInfo.text = "";
         _highlight = new Sprite();
         _highlightMouse = false;
         _highlightTarget = null;
         _starlingHighlightTarget = null;
         _highlightUpdate = false;
      }
      
      static function get base() : *
      {
         return _base;
      }
      
      static function set base(value:*) : void
      {
         _base = value;
      }
      
      static function trace(caller:*, object:*, person:String = "", label:String = "", color:uint = 0, depth:int = 5) : void
      {
         var xml:* = null;
         var data:* = null;
         if(MonsterDebugger.enabled)
         {
            xml = XML(MonsterDebuggerUtils.parse(object,"",1,depth,false));
            data = {
               "command":"TRACE",
               "memory":MonsterDebuggerUtils.getMemory(),
               "date":new Date(),
               "target":String(caller),
               "reference":MonsterDebuggerUtils.getReferenceID(caller),
               "xml":xml,
               "person":person,
               "label":label,
               "color":color
            };
            send(data);
         }
      }
      
      static function snapshot(caller:*, object:flash.display.DisplayObject, person:String = "", label:String = "") : void
      {
         var bitmapData:* = null;
         var bytes:* = null;
         var data:* = null;
         if(MonsterDebugger.enabled)
         {
            bitmapData = MonsterDebuggerUtils.snapshot(object);
            if(bitmapData != null)
            {
               bytes = bitmapData.getPixels(new Rectangle(0,0,bitmapData.width,bitmapData.height));
               data = {
                  "command":"SNAPSHOT",
                  "memory":MonsterDebuggerUtils.getMemory(),
                  "date":new Date(),
                  "target":String(caller),
                  "reference":MonsterDebuggerUtils.getReferenceID(caller),
                  "bytes":bytes,
                  "width":bitmapData.width,
                  "height":bitmapData.height,
                  "person":person,
                  "label":label
               };
               send(data);
            }
         }
      }
      
      static function breakpoint(caller:*, id:String = "breakpoint") : void
      {
         var stack:* = null;
         var data:* = null;
         if(MonsterDebugger.enabled && MonsterDebuggerConnection.connected)
         {
            stack = MonsterDebuggerUtils.stackTrace();
            data = {
               "command":"PAUSE",
               "memory":MonsterDebuggerUtils.getMemory(),
               "date":new Date(),
               "target":String(caller),
               "reference":MonsterDebuggerUtils.getReferenceID(caller),
               "stack":stack,
               "id":id
            };
            send(data);
            MonsterDebuggerUtils.pause();
         }
      }
      
      static function inspect(object:*) : void
      {
         var obj:* = undefined;
         var xml:* = null;
         if(MonsterDebugger.enabled)
         {
            _base = object;
            obj = MonsterDebuggerUtils.getObject(_base,"",0);
            if(obj != null)
            {
               xml = XML(MonsterDebuggerUtils.parse(obj,"",1,2,true));
               send({
                  "command":"BASE",
                  "xml":xml
               });
            }
         }
      }
      
      static function clear() : void
      {
         if(MonsterDebugger.enabled)
         {
            send({"command":"CLEAR_TRACES"});
         }
      }
      
      static function sendInformation() : void
      {
         var UIComponentClass:* = undefined;
         var tmpLocation:* = null;
         var tmpTitle:* = null;
         var NativeApplicationClass:* = undefined;
         var descriptor:* = null;
         var ns:* = null;
         var filename:* = null;
         var FileClass:* = undefined;
         var slash:int = 0;
         var playerType:String = Capabilities.playerType;
         var playerVersion:String = Capabilities.version;
         var isDebugger:Boolean = Capabilities.isDebugger;
         var isFlex:Boolean = false;
         var fileTitle:* = "";
         var fileLocation:* = "";
         try
         {
            UIComponentClass = getDefinitionByName("mx.core::UIComponent");
            if(UIComponentClass != null)
            {
               isFlex = true;
            }
         }
         catch(e1:Error)
         {
         }
         if(_base is flash.display.DisplayObject && _base.hasOwnProperty("loaderInfo"))
         {
            if(flash.display.DisplayObject(_base).loaderInfo != null)
            {
               fileLocation = unescape(flash.display.DisplayObject(_base).loaderInfo.url);
            }
         }
         if(_base.hasOwnProperty("stage"))
         {
            if(_base["stage"] != null && _base["stage"] is flash.display.Stage)
            {
               fileLocation = unescape(flash.display.Stage(_base["stage"]).loaderInfo.url);
            }
         }
         if(playerType == "ActiveX" || playerType == "PlugIn")
         {
            if(ExternalInterface.available)
            {
               try
               {
                  tmpLocation = ExternalInterface.call("window.location.href.toString");
                  tmpTitle = ExternalInterface.call("window.document.title.toString");
                  if(tmpLocation != null)
                  {
                     fileLocation = tmpLocation;
                  }
                  if(tmpTitle != null)
                  {
                     fileTitle = tmpTitle;
                  }
               }
               catch(e2:Error)
               {
               }
            }
         }
         if(playerType == "Desktop")
         {
            try
            {
               NativeApplicationClass = getDefinitionByName("flash.desktop::NativeApplication");
               if(NativeApplicationClass != null)
               {
                  descriptor = NativeApplicationClass["nativeApplication"]["applicationDescriptor"];
                  ns = descriptor.namespace();
                  filename = descriptor.ns::filename;
                  FileClass = getDefinitionByName("flash.filesystem::File");
                  if(Capabilities.os.toLowerCase().indexOf("windows") != -1)
                  {
                     filename = filename + ".exe";
                     fileLocation = FileClass["applicationDirectory"]["resolvePath"](filename)["nativePath"];
                  }
                  else if(Capabilities.os.toLowerCase().indexOf("mac") != -1)
                  {
                     filename = filename + ".app";
                     fileLocation = FileClass["applicationDirectory"]["resolvePath"](filename)["nativePath"];
                  }
               }
            }
            catch(e3:Error)
            {
            }
         }
         if(fileTitle == "" && fileLocation != "")
         {
            slash = Math.max(fileLocation.lastIndexOf("\\"),fileLocation.lastIndexOf("/"));
            if(slash != -1)
            {
               fileTitle = fileLocation.substring(slash + 1,fileLocation.lastIndexOf("."));
            }
            else
            {
               fileTitle = fileLocation;
            }
         }
         if(fileTitle == "")
         {
            fileTitle = "Application";
         }
         var data:Object = {
            "command":"INFO",
            "debuggerVersion":3.02,
            "playerType":playerType,
            "playerVersion":playerVersion,
            "isDebugger":isDebugger,
            "isFlex":isFlex,
            "fileLocation":fileLocation,
            "fileTitle":fileTitle
         };
         send(data,true);
         MonsterDebuggerConnection.processQueue();
      }
      
      static function handle(item:MonsterDebuggerData) : void
      {
         if(MonsterDebugger.enabled)
         {
            if(item.id == null || item.id == "")
            {
               return;
            }
            if(item.id == "com.demonsters.debugger.core")
            {
               handleInternal(item);
            }
         }
      }
      
      private static function handleInternal(item:MonsterDebuggerData) : void
      {
         var obj:* = undefined;
         var xml:* = null;
         var method:* = null;
         var displayObject:* = null;
         var bitmapData:* = null;
         var bytes:* = null;
         var _loc12_:* = item.data["command"];
         if("HELLO" !== _loc12_)
         {
            if("BASE" !== _loc12_)
            {
               if("INSPECT" !== _loc12_)
               {
                  if("GET_OBJECT" !== _loc12_)
                  {
                     if("GET_PROPERTIES" !== _loc12_)
                     {
                        if("GET_FUNCTIONS" !== _loc12_)
                        {
                           if("SET_PROPERTY" !== _loc12_)
                           {
                              if("GET_PREVIEW" !== _loc12_)
                              {
                                 if("CALL_METHOD" !== _loc12_)
                                 {
                                    if("PAUSE" !== _loc12_)
                                    {
                                       if("RESUME" !== _loc12_)
                                       {
                                          if("HIGHLIGHT" !== _loc12_)
                                          {
                                             if("START_HIGHLIGHT" !== _loc12_)
                                             {
                                                if("STOP_HIGHLIGHT" === _loc12_)
                                                {
                                                   highlightClear();
                                                   _highlight.removeEventListener("click",highlightClicked);
                                                   _highlight.mouseEnabled = false;
                                                   _highlightTarget = null;
                                                   _starlingHighlightTarget = null;
                                                   _highlightMouse = false;
                                                   _highlightUpdate = false;
                                                   send({"command":"STOP_HIGHLIGHT"});
                                                }
                                             }
                                             else
                                             {
                                                highlightClear();
                                                _highlight.addEventListener("click",highlightClicked,false,0,true);
                                                _highlight.mouseEnabled = true;
                                                _highlightTarget = null;
                                                _starlingHighlightTarget = null;
                                                _highlightMouse = true;
                                                _highlightUpdate = true;
                                                send({"command":"START_HIGHLIGHT"});
                                             }
                                          }
                                          else
                                          {
                                             obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                                             if(obj != null && MonsterDebuggerUtils.isDisplayObject(obj))
                                             {
                                                if(flash.display.DisplayObject(obj).stage != null && flash.display.DisplayObject(obj).stage is flash.display.Stage)
                                                {
                                                   _stage = obj["stage"];
                                                }
                                                if(_stage != null)
                                                {
                                                   highlightClear();
                                                   send({"command":"STOP_HIGHLIGHT"});
                                                   _highlight.removeEventListener("click",highlightClicked);
                                                   _highlight.mouseEnabled = false;
                                                   _highlightTarget = flash.display.DisplayObject(obj);
                                                   _starlingHighlightTarget = null;
                                                   _highlightMouse = false;
                                                   _highlightUpdate = true;
                                                }
                                             }
                                             else if(obj != null && MonsterDebuggerUtils.isStarlingDisplayObject(obj))
                                             {
                                                if(starling.display.DisplayObject(obj).stage != null && starling.display.DisplayObject(obj).stage is starling.display.Stage)
                                                {
                                                   _starlingStage = obj["stage"] as starling.display.Stage;
                                                }
                                                if(_starlingStage != null)
                                                {
                                                   highlightClear();
                                                   send({"command":"STOP_HIGHLIGHT"});
                                                   _highlight.removeEventListener("click",highlightClicked);
                                                   _highlight.mouseEnabled = false;
                                                   _highlightTarget = null;
                                                   _starlingHighlightTarget = starling.display.DisplayObject(obj);
                                                   _highlightMouse = false;
                                                   _highlightUpdate = true;
                                                }
                                             }
                                          }
                                       }
                                       else
                                       {
                                          MonsterDebuggerUtils.resume();
                                          send({"command":"RESUME"});
                                       }
                                    }
                                    else
                                    {
                                       MonsterDebuggerUtils.pause();
                                       send({"command":"PAUSE"});
                                    }
                                 }
                                 else
                                 {
                                    method = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                                    if(method != null && method is Function)
                                    {
                                       if(item.data["returnType"] == "void")
                                       {
                                          method.apply(null,item.data["arguments"]);
                                       }
                                       else
                                       {
                                          try
                                          {
                                             obj = method.apply(null,item.data["arguments"]);
                                             xml = XML(MonsterDebuggerUtils.parse(obj,"",1,5,false));
                                             send({
                                                "command":"CALL_METHOD",
                                                "id":item.data["id"],
                                                "xml":xml
                                             });
                                          }
                                          catch(e2:Error)
                                          {
                                          }
                                       }
                                    }
                                 }
                              }
                              else
                              {
                                 obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                                 if(obj != null && MonsterDebuggerUtils.isDisplayObject(obj))
                                 {
                                    displayObject = obj as flash.display.DisplayObject;
                                    bitmapData = MonsterDebuggerUtils.snapshot(displayObject,new Rectangle(0,0,300,300));
                                    if(bitmapData != null)
                                    {
                                       bytes = bitmapData.getPixels(new Rectangle(0,0,bitmapData.width,bitmapData.height));
                                       send({
                                          "command":"GET_PREVIEW",
                                          "bytes":bytes,
                                          "width":bitmapData.width,
                                          "height":bitmapData.height
                                       });
                                    }
                                 }
                              }
                           }
                           else
                           {
                              obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],1);
                              if(obj != null)
                              {
                                 try
                                 {
                                    obj[item.data["name"]] = item.data["value"];
                                    send({
                                       "command":"SET_PROPERTY",
                                       "target":item.data["target"],
                                       "value":obj[item.data["name"]]
                                    });
                                 }
                                 catch(e1:Error)
                                 {
                                 }
                              }
                           }
                        }
                        else
                        {
                           obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                           if(obj != null)
                           {
                              xml = XML(MonsterDebuggerUtils.parseFunctions(obj,item.data["target"]));
                              send({
                                 "command":"GET_FUNCTIONS",
                                 "xml":xml
                              });
                           }
                        }
                     }
                     else
                     {
                        obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                        if(obj != null)
                        {
                           xml = XML(MonsterDebuggerUtils.parse(obj,item.data["target"],1,1,false));
                           send({
                              "command":"GET_PROPERTIES",
                              "xml":xml
                           });
                        }
                     }
                  }
                  else
                  {
                     obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                     if(obj != null)
                     {
                        xml = XML(MonsterDebuggerUtils.parse(obj,item.data["target"],1,2,true));
                        send({
                           "command":"GET_OBJECT",
                           "xml":xml
                        });
                     }
                  }
               }
               else
               {
                  obj = MonsterDebuggerUtils.getObject(_base,item.data["target"],0);
                  if(obj != null)
                  {
                     _base = obj;
                     xml = XML(MonsterDebuggerUtils.parse(obj,"",1,2,true));
                     send({
                        "command":"BASE",
                        "xml":xml
                     });
                  }
               }
            }
            else
            {
               obj = MonsterDebuggerUtils.getObject(_base,"",0);
               if(obj != null)
               {
                  xml = XML(MonsterDebuggerUtils.parse(obj,"",1,2,true));
                  send({
                     "command":"BASE",
                     "xml":xml
                  });
               }
            }
         }
         else
         {
            sendInformation();
         }
      }
      
      private static function monitorTimerCallback(event:TimerEvent) : void
      {
         var now:Number = NaN;
         var delta:Number = NaN;
         var fps:* = 0;
         var fpsMovie:* = 0;
         var data:* = null;
         if(MonsterDebugger.enabled)
         {
            now = new Date().time;
            delta = now - _monitorTime;
            fps = uint(_monitorFrames / delta * 1000);
            fpsMovie = uint(0);
            if(_stage == null)
            {
               if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is flash.display.Stage)
               {
                  _stage = flash.display.Stage(_base["stage"]);
               }
            }
            if(_starlingStage == null)
            {
               if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is starling.display.Stage)
               {
                  _starlingStage = starling.display.Stage(_base["stage"]);
               }
            }
            if(_stage != null)
            {
               fpsMovie = uint(_stage.frameRate);
            }
            _monitorFrames = 0;
            _monitorTime = now;
            if(MonsterDebuggerConnection.connected)
            {
               data = {
                  "command":"MONITOR",
                  "memory":MonsterDebuggerUtils.getMemory(),
                  "fps":fps,
                  "fpsMovie":fpsMovie,
                  "time":now
               };
               send(data);
            }
         }
      }
      
      private static function frameHandler(event:Event) : void
      {
         if(MonsterDebugger.enabled)
         {
            _monitorFrames = Number(_monitorFrames) + 1;
            if(_highlightUpdate)
            {
               highlightUpdate();
            }
         }
      }
      
      private static function highlightClicked(event:MouseEvent) : void
      {
         var starling:* = null;
         var nativeStage:* = null;
         var viewPort:* = null;
         var contentScaleFactor:Number = NaN;
         var starlingX:Number = NaN;
         var starlingY:Number = NaN;
         event.preventDefault();
         event.stopImmediatePropagation();
         highlightClear();
         if(_stage != null)
         {
            _highlightTarget = MonsterDebuggerUtils.getObjectUnderPoint(_stage,new Point(_stage.mouseX,_stage.mouseY));
            if(_starlingStage != null && _highlightTarget is flash.display.Stage)
            {
               _highlightTarget = null;
            }
         }
         if(_highlightTarget == null && _starlingStage != null)
         {
            starling = getStarlingForStage(_starlingStage);
            nativeStage = starling.nativeStage;
            viewPort = starling.viewPort;
            contentScaleFactor = starling.contentScaleFactor;
            starlingX = (nativeStage.mouseX - viewPort.x) / contentScaleFactor;
            starlingY = (nativeStage.mouseY - viewPort.y) / contentScaleFactor;
            _starlingHighlightTarget = MonsterDebuggerUtils.getStarlingObjectUnderPoint(_starlingStage,new Point(starlingX,starlingY));
         }
         _highlightMouse = false;
         _highlight.removeEventListener("click",highlightClicked);
         _highlight.mouseEnabled = false;
         if(_highlightTarget != null)
         {
            inspect(_highlightTarget);
            highlightDraw(false);
         }
         else if(_starlingHighlightTarget != null)
         {
            inspect(_starlingHighlightTarget);
            highlightDraw(false);
         }
         send({"command":"STOP_HIGHLIGHT"});
      }
      
      private static function highlightUpdate() : void
      {
         var NativeApplicationClass:* = undefined;
         var starlings:* = undefined;
         var starlingCount:int = 0;
         var i:int = 0;
         var starling:* = null;
         var nativeStage:* = null;
         var viewPort:* = null;
         var contentScaleFactor:Number = NaN;
         var starlingX:Number = NaN;
         var starlingY:Number = NaN;
         highlightClear();
         if(_highlightMouse)
         {
            if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is flash.display.Stage)
            {
               _stage = _base["stage"] as flash.display.Stage;
            }
            if(_base.hasOwnProperty("stage") && _base["stage"] != null && _base["stage"] is starling.display.Stage)
            {
               _starlingStage = _base["stage"] as starling.display.Stage;
            }
            if(Capabilities.playerType == "Desktop")
            {
               NativeApplicationClass = getDefinitionByName("flash.desktop::NativeApplication");
               if(NativeApplicationClass != null && NativeApplicationClass["nativeApplication"]["activeWindow"] != null)
               {
                  _stage = NativeApplicationClass["nativeApplication"]["activeWindow"]["stage"];
                  if(Object(Starling).hasOwnProperty("all"))
                  {
                     starlings = Starling["all"] as Vector.<Starling>;
                     starlingCount = starlings.length;
                     for(i = 0; i < starlingCount; )
                     {
                        starling = starlings[i];
                        if(starling.nativeStage == _stage)
                        {
                           _starlingStage = starling.stage;
                           break;
                        }
                        i++;
                     }
                  }
               }
            }
            if(_stage == null && _starlingStage == null)
            {
               _highlight.removeEventListener("click",highlightClicked);
               _highlight.mouseEnabled = false;
               _highlightTarget = null;
               _starlingHighlightTarget = null;
               _highlightMouse = false;
               _highlightUpdate = false;
               return;
            }
            if(_stage != null)
            {
               _highlightTarget = MonsterDebuggerUtils.getObjectUnderPoint(_stage,new Point(_stage.mouseX,_stage.mouseY));
               if(_starlingStage != null && _highlightTarget is flash.display.Stage)
               {
                  _highlightTarget = null;
               }
               if(_highlightTarget != null)
               {
                  highlightDraw(true);
               }
            }
            if(_highlightTarget == null && _starlingStage != null)
            {
               starling = getStarlingForStage(_starlingStage);
               nativeStage = starling.nativeStage;
               viewPort = starling.viewPort;
               contentScaleFactor = starling.contentScaleFactor;
               starlingX = (nativeStage.mouseX - viewPort.x) / contentScaleFactor;
               starlingY = (nativeStage.mouseY - viewPort.y) / contentScaleFactor;
               _starlingHighlightTarget = MonsterDebuggerUtils.getStarlingObjectUnderPoint(_starlingStage,new Point(starlingX,starlingY));
               if(_starlingHighlightTarget != null)
               {
                  highlightDraw(true);
               }
            }
            return;
         }
         if(_highlightTarget != null)
         {
            if(_highlightTarget.stage == null || _highlightTarget.parent == null)
            {
               _highlight.removeEventListener("click",highlightClicked);
               _highlight.mouseEnabled = false;
               _highlightTarget = null;
               _starlingHighlightTarget = null;
               _highlightMouse = false;
               _highlightUpdate = false;
               return;
            }
            highlightDraw(false);
         }
         else if(_starlingHighlightTarget != null)
         {
            if(_starlingHighlightTarget.stage == null || _starlingHighlightTarget.parent == null)
            {
               _highlight.removeEventListener("click",highlightClicked);
               _highlight.mouseEnabled = false;
               _highlightTarget = null;
               _starlingHighlightTarget = null;
               _highlightMouse = false;
               _highlightUpdate = false;
               return;
            }
            highlightDraw(false);
         }
      }
      
      private static function highlightDraw(fill:Boolean) : void
      {
         var nativeStage:* = null;
         var boundsOuter:* = null;
         var starling:* = null;
         var viewPort:* = null;
         var contentScaleFactor:Number = NaN;
         if(_highlightTarget == null && _starlingHighlightTarget == null)
         {
            return;
         }
         if(_highlightTarget != null)
         {
            if(_highlightTarget == _stage)
            {
               boundsOuter = new Rectangle(0,0,_stage.stageWidth,_stage.stageHeight);
            }
            else
            {
               boundsOuter = _highlightTarget.getBounds(_stage);
            }
            nativeStage = _stage;
         }
         else if(_starlingHighlightTarget != null)
         {
            starling = getStarlingForStage(_starlingStage);
            nativeStage = starling.nativeStage;
            viewPort = starling.viewPort;
            contentScaleFactor = starling.contentScaleFactor;
            if(_starlingHighlightTarget == _starlingStage)
            {
               boundsOuter = new Rectangle(viewPort.x,viewPort.y,_starlingStage.stageWidth * contentScaleFactor,_starlingStage.stageHeight * contentScaleFactor);
            }
            else
            {
               boundsOuter = _starlingHighlightTarget.getBounds(_starlingStage);
               boundsOuter.setTo(boundsOuter.x * contentScaleFactor + viewPort.x,boundsOuter.y * contentScaleFactor + viewPort.y,boundsOuter.width * contentScaleFactor,boundsOuter.height * contentScaleFactor);
            }
         }
         if(_highlightTarget != null && _highlightTarget != _stage || _starlingHighlightTarget != null && _starlingHighlightTarget != _starlingStage)
         {
            boundsOuter.x = int(boundsOuter.x + 0.5);
            boundsOuter.y = int(boundsOuter.y + 0.5);
            boundsOuter.width = int(boundsOuter.width + 0.5);
            boundsOuter.height = int(boundsOuter.height + 0.5);
         }
         var boundsInner:Rectangle = boundsOuter.clone();
         boundsInner.x = boundsInner.x + 2;
         boundsInner.y = boundsInner.y + 2;
         boundsInner.width = boundsInner.width - 4;
         boundsInner.height = boundsInner.height - 4;
         if(boundsInner.width < 0)
         {
            boundsInner.width = 0;
         }
         if(boundsInner.height < 0)
         {
            boundsInner.height = 0;
         }
         _highlight.graphics.clear();
         _highlight.graphics.beginFill(3381759,1);
         _highlight.graphics.drawRect(boundsOuter.x,boundsOuter.y,boundsOuter.width,boundsOuter.height);
         _highlight.graphics.drawRect(boundsInner.x,boundsInner.y,boundsInner.width,boundsInner.height);
         if(fill)
         {
            _highlight.graphics.beginFill(3381759,0.25);
            _highlight.graphics.drawRect(boundsInner.x,boundsInner.y,boundsInner.width,boundsInner.height);
         }
         if(_highlightTarget)
         {
            if(_highlightTarget.name != null)
            {
               _highlightInfo.text = String(_highlightTarget.name) + " - " + String(MonsterDebuggerDescribeType.get(_highlightTarget).@name);
            }
            else
            {
               _highlightInfo.text = String(MonsterDebuggerDescribeType.get(_highlightTarget).@name);
            }
         }
         else if(_starlingHighlightTarget)
         {
            if(_starlingHighlightTarget.name != null)
            {
               _highlightInfo.text = String(_starlingHighlightTarget.name) + " - " + String(MonsterDebuggerDescribeType.get(_starlingHighlightTarget).@name);
            }
            else
            {
               _highlightInfo.text = String(MonsterDebuggerDescribeType.get(_starlingHighlightTarget).@name);
            }
         }
         var boundsText:Rectangle = new Rectangle(boundsOuter.x,boundsOuter.y - (_highlightInfo.textHeight + 3),_highlightInfo.textWidth + 15,_highlightInfo.textHeight + 5);
         if(boundsText.y < 0)
         {
            boundsText.y = boundsOuter.y + boundsOuter.height;
         }
         if(boundsText.y + boundsText.height > nativeStage.stageHeight)
         {
            boundsText.y = nativeStage.stageHeight - boundsText.height;
         }
         if(boundsText.x < 0)
         {
            boundsText.x = 0;
         }
         if(boundsText.x + boundsText.width > nativeStage.stageWidth)
         {
            boundsText.x = nativeStage.stageWidth - boundsText.width;
         }
         _highlight.graphics.beginFill(3381759,1);
         _highlight.graphics.drawRect(boundsText.x,boundsText.y,boundsText.width,boundsText.height);
         _highlight.graphics.endFill();
         _highlightInfo.x = boundsText.x;
         _highlightInfo.y = boundsText.y;
         try
         {
            nativeStage.addChild(_highlight);
            nativeStage.addChild(_highlightInfo);
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private static function highlightClear() : void
      {
         if(_highlight != null && _highlight.parent != null)
         {
            _highlight.parent.removeChild(_highlight);
            _highlight.graphics.clear();
            _highlight.x = 0;
            _highlight.y = 0;
         }
         if(_highlightInfo != null && _highlightInfo.parent != null)
         {
            _highlightInfo.parent.removeChild(_highlightInfo);
            _highlightInfo.x = 0;
            _highlightInfo.y = 0;
         }
      }
      
      private static function send(data:Object, direct:Boolean = false) : void
      {
         if(MonsterDebugger.enabled)
         {
            MonsterDebuggerConnection.send("com.demonsters.debugger.core",data,direct);
         }
      }
      
      private static function getStarlingForStage(stage:starling.display.Stage) : Starling
      {
         var starlings:* = undefined;
         var starlingCount:int = 0;
         var i:int = 0;
         var starling:* = null;
         if(Object(Starling).hasOwnProperty("all"))
         {
            starlings = Starling["all"] as Vector.<Starling>;
            starlingCount = starlings.length;
            for(i = 0; i < starlingCount; )
            {
               starling = starlings[i];
               if(starling.stage == stage)
               {
                  return starling;
               }
               i++;
            }
         }
         return Starling.current;
      }
   }
}
