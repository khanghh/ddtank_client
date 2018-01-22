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
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Arial";
         _loc1_.color = 16777215;
         _loc1_.size = 11;
         _loc1_.leftMargin = 5;
         _loc1_.rightMargin = 5;
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
         _highlightInfo.defaultTextFormat = _loc1_;
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
      
      static function set base(param1:*) : void
      {
         _base = param1;
      }
      
      static function trace(param1:*, param2:*, param3:String = "", param4:String = "", param5:uint = 0, param6:int = 5) : void
      {
         var _loc8_:* = null;
         var _loc7_:* = null;
         if(MonsterDebugger.enabled)
         {
            _loc8_ = XML(MonsterDebuggerUtils.parse(param2,"",1,param6,false));
            _loc7_ = {
               "command":"TRACE",
               "memory":MonsterDebuggerUtils.getMemory(),
               "date":new Date(),
               "target":String(param1),
               "reference":MonsterDebuggerUtils.getReferenceID(param1),
               "xml":_loc8_,
               "person":param3,
               "label":param4,
               "color":param5
            };
            send(_loc7_);
         }
      }
      
      static function snapshot(param1:*, param2:flash.display.DisplayObject, param3:String = "", param4:String = "") : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         if(MonsterDebugger.enabled)
         {
            _loc6_ = MonsterDebuggerUtils.snapshot(param2);
            if(_loc6_ != null)
            {
               _loc5_ = _loc6_.getPixels(new Rectangle(0,0,_loc6_.width,_loc6_.height));
               _loc7_ = {
                  "command":"SNAPSHOT",
                  "memory":MonsterDebuggerUtils.getMemory(),
                  "date":new Date(),
                  "target":String(param1),
                  "reference":MonsterDebuggerUtils.getReferenceID(param1),
                  "bytes":_loc5_,
                  "width":_loc6_.width,
                  "height":_loc6_.height,
                  "person":param3,
                  "label":param4
               };
               send(_loc7_);
            }
         }
      }
      
      static function breakpoint(param1:*, param2:String = "breakpoint") : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(MonsterDebugger.enabled && MonsterDebuggerConnection.connected)
         {
            _loc4_ = MonsterDebuggerUtils.stackTrace();
            _loc3_ = {
               "command":"PAUSE",
               "memory":MonsterDebuggerUtils.getMemory(),
               "date":new Date(),
               "target":String(param1),
               "reference":MonsterDebuggerUtils.getReferenceID(param1),
               "stack":_loc4_,
               "id":param2
            };
            send(_loc3_);
            MonsterDebuggerUtils.pause();
         }
      }
      
      static function inspect(param1:*) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         if(MonsterDebugger.enabled)
         {
            _base = param1;
            _loc3_ = MonsterDebuggerUtils.getObject(_base,"",0);
            if(_loc3_ != null)
            {
               _loc2_ = XML(MonsterDebuggerUtils.parse(_loc3_,"",1,2,true));
               send({
                  "command":"BASE",
                  "xml":_loc2_
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
         var _loc10_:* = undefined;
         var _loc15_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc16_:* = null;
         var _loc14_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:String = Capabilities.playerType;
         var _loc11_:String = Capabilities.version;
         var _loc12_:Boolean = Capabilities.isDebugger;
         var _loc13_:Boolean = false;
         var _loc1_:* = "";
         var _loc4_:* = "";
         try
         {
            _loc10_ = getDefinitionByName("mx.core::UIComponent");
            if(_loc10_ != null)
            {
               _loc13_ = true;
            }
         }
         catch(e1:Error)
         {
         }
         if(_base is flash.display.DisplayObject && _base.hasOwnProperty("loaderInfo"))
         {
            if(flash.display.DisplayObject(_base).loaderInfo != null)
            {
               _loc4_ = unescape(flash.display.DisplayObject(_base).loaderInfo.url);
            }
         }
         if(_base.hasOwnProperty("stage"))
         {
            if(_base["stage"] != null && _base["stage"] is flash.display.Stage)
            {
               _loc4_ = unescape(flash.display.Stage(_base["stage"]).loaderInfo.url);
            }
         }
         if(_loc7_ == "ActiveX" || _loc7_ == "PlugIn")
         {
            if(ExternalInterface.available)
            {
               try
               {
                  _loc15_ = ExternalInterface.call("window.location.href.toString");
                  _loc2_ = ExternalInterface.call("window.document.title.toString");
                  if(_loc15_ != null)
                  {
                     _loc4_ = _loc15_;
                  }
                  if(_loc2_ != null)
                  {
                     _loc1_ = _loc2_;
                  }
               }
               catch(e2:Error)
               {
               }
            }
         }
         if(_loc7_ == "Desktop")
         {
            try
            {
               _loc3_ = getDefinitionByName("flash.desktop::NativeApplication");
               if(_loc3_ != null)
               {
                  _loc8_ = _loc3_["nativeApplication"]["applicationDescriptor"];
                  _loc5_ = _loc8_.namespace();
                  _loc16_ = _loc8_._loc5_::filename;
                  _loc14_ = getDefinitionByName("flash.filesystem::File");
                  if(Capabilities.os.toLowerCase().indexOf("windows") != -1)
                  {
                     _loc16_ = _loc16_ + ".exe";
                     _loc4_ = _loc14_["applicationDirectory"]["resolvePath"](_loc16_)["nativePath"];
                  }
                  else if(Capabilities.os.toLowerCase().indexOf("mac") != -1)
                  {
                     _loc16_ = _loc16_ + ".app";
                     _loc4_ = _loc14_["applicationDirectory"]["resolvePath"](_loc16_)["nativePath"];
                  }
               }
            }
            catch(e3:Error)
            {
            }
         }
         if(_loc1_ == "" && _loc4_ != "")
         {
            _loc6_ = Math.max(_loc4_.lastIndexOf("\\"),_loc4_.lastIndexOf("/"));
            if(_loc6_ != -1)
            {
               _loc1_ = _loc4_.substring(_loc6_ + 1,_loc4_.lastIndexOf("."));
            }
            else
            {
               _loc1_ = _loc4_;
            }
         }
         if(_loc1_ == "")
         {
            _loc1_ = "Application";
         }
         var _loc9_:Object = {
            "command":"INFO",
            "debuggerVersion":3.02,
            "playerType":_loc7_,
            "playerVersion":_loc11_,
            "isDebugger":_loc12_,
            "isFlex":_loc13_,
            "fileLocation":_loc4_,
            "fileTitle":_loc1_
         };
         send(_loc9_,true);
         MonsterDebuggerConnection.processQueue();
      }
      
      static function handle(param1:MonsterDebuggerData) : void
      {
         if(MonsterDebugger.enabled)
         {
            if(param1.id == null || param1.id == "")
            {
               return;
            }
            if(param1.id == "com.demonsters.debugger.core")
            {
               handleInternal(param1);
            }
         }
      }
      
      private static function handleInternal(param1:MonsterDebuggerData) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc12_:* = param1.data["command"];
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
                                             _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                                             if(_loc6_ != null && MonsterDebuggerUtils.isDisplayObject(_loc6_))
                                             {
                                                if(flash.display.DisplayObject(_loc6_).stage != null && flash.display.DisplayObject(_loc6_).stage is flash.display.Stage)
                                                {
                                                   _stage = _loc6_["stage"];
                                                }
                                                if(_stage != null)
                                                {
                                                   highlightClear();
                                                   send({"command":"STOP_HIGHLIGHT"});
                                                   _highlight.removeEventListener("click",highlightClicked);
                                                   _highlight.mouseEnabled = false;
                                                   _highlightTarget = flash.display.DisplayObject(_loc6_);
                                                   _starlingHighlightTarget = null;
                                                   _highlightMouse = false;
                                                   _highlightUpdate = true;
                                                }
                                             }
                                             else if(_loc6_ != null && MonsterDebuggerUtils.isStarlingDisplayObject(_loc6_))
                                             {
                                                if(starling.display.DisplayObject(_loc6_).stage != null && starling.display.DisplayObject(_loc6_).stage is starling.display.Stage)
                                                {
                                                   _starlingStage = _loc6_["stage"] as starling.display.Stage;
                                                }
                                                if(_starlingStage != null)
                                                {
                                                   highlightClear();
                                                   send({"command":"STOP_HIGHLIGHT"});
                                                   _highlight.removeEventListener("click",highlightClicked);
                                                   _highlight.mouseEnabled = false;
                                                   _highlightTarget = null;
                                                   _starlingHighlightTarget = starling.display.DisplayObject(_loc6_);
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
                                    _loc4_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                                    if(_loc4_ != null && _loc4_ is Function)
                                    {
                                       if(param1.data["returnType"] == "void")
                                       {
                                          _loc4_.apply(null,param1.data["arguments"]);
                                       }
                                       else
                                       {
                                          try
                                          {
                                             _loc6_ = _loc4_.apply(null,param1.data["arguments"]);
                                             _loc5_ = XML(MonsterDebuggerUtils.parse(_loc6_,"",1,5,false));
                                             send({
                                                "command":"CALL_METHOD",
                                                "id":param1.data["id"],
                                                "xml":_loc5_
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
                                 _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                                 if(_loc6_ != null && MonsterDebuggerUtils.isDisplayObject(_loc6_))
                                 {
                                    _loc7_ = _loc6_ as flash.display.DisplayObject;
                                    _loc3_ = MonsterDebuggerUtils.snapshot(_loc7_,new Rectangle(0,0,300,300));
                                    if(_loc3_ != null)
                                    {
                                       _loc2_ = _loc3_.getPixels(new Rectangle(0,0,_loc3_.width,_loc3_.height));
                                       send({
                                          "command":"GET_PREVIEW",
                                          "bytes":_loc2_,
                                          "width":_loc3_.width,
                                          "height":_loc3_.height
                                       });
                                    }
                                 }
                              }
                           }
                           else
                           {
                              _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],1);
                              if(_loc6_ != null)
                              {
                                 try
                                 {
                                    _loc6_[param1.data["name"]] = param1.data["value"];
                                    send({
                                       "command":"SET_PROPERTY",
                                       "target":param1.data["target"],
                                       "value":_loc6_[param1.data["name"]]
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
                           _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                           if(_loc6_ != null)
                           {
                              _loc5_ = XML(MonsterDebuggerUtils.parseFunctions(_loc6_,param1.data["target"]));
                              send({
                                 "command":"GET_FUNCTIONS",
                                 "xml":_loc5_
                              });
                           }
                        }
                     }
                     else
                     {
                        _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                        if(_loc6_ != null)
                        {
                           _loc5_ = XML(MonsterDebuggerUtils.parse(_loc6_,param1.data["target"],1,1,false));
                           send({
                              "command":"GET_PROPERTIES",
                              "xml":_loc5_
                           });
                        }
                     }
                  }
                  else
                  {
                     _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                     if(_loc6_ != null)
                     {
                        _loc5_ = XML(MonsterDebuggerUtils.parse(_loc6_,param1.data["target"],1,2,true));
                        send({
                           "command":"GET_OBJECT",
                           "xml":_loc5_
                        });
                     }
                  }
               }
               else
               {
                  _loc6_ = MonsterDebuggerUtils.getObject(_base,param1.data["target"],0);
                  if(_loc6_ != null)
                  {
                     _base = _loc6_;
                     _loc5_ = XML(MonsterDebuggerUtils.parse(_loc6_,"",1,2,true));
                     send({
                        "command":"BASE",
                        "xml":_loc5_
                     });
                  }
               }
            }
            else
            {
               _loc6_ = MonsterDebuggerUtils.getObject(_base,"",0);
               if(_loc6_ != null)
               {
                  _loc5_ = XML(MonsterDebuggerUtils.parse(_loc6_,"",1,2,true));
                  send({
                     "command":"BASE",
                     "xml":_loc5_
                  });
               }
            }
         }
         else
         {
            sendInformation();
         }
      }
      
      private static function monitorTimerCallback(param1:TimerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc6_:* = null;
         if(MonsterDebugger.enabled)
         {
            _loc2_ = new Date().time;
            _loc5_ = _loc2_ - _monitorTime;
            _loc4_ = uint(_monitorFrames / _loc5_ * 1000);
            _loc3_ = uint(0);
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
               _loc3_ = uint(_stage.frameRate);
            }
            _monitorFrames = 0;
            _monitorTime = _loc2_;
            if(MonsterDebuggerConnection.connected)
            {
               _loc6_ = {
                  "command":"MONITOR",
                  "memory":MonsterDebuggerUtils.getMemory(),
                  "fps":_loc4_,
                  "fpsMovie":_loc3_,
                  "time":_loc2_
               };
               send(_loc6_);
            }
         }
      }
      
      private static function frameHandler(param1:Event) : void
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
      
      private static function highlightClicked(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         param1.preventDefault();
         param1.stopImmediatePropagation();
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
            _loc3_ = getStarlingForStage(_starlingStage);
            _loc5_ = _loc3_.nativeStage;
            _loc2_ = _loc3_.viewPort;
            _loc4_ = _loc3_.contentScaleFactor;
            _loc6_ = (_loc5_.mouseX - _loc2_.x) / _loc4_;
            _loc7_ = (_loc5_.mouseY - _loc2_.y) / _loc4_;
            _starlingHighlightTarget = MonsterDebuggerUtils.getStarlingObjectUnderPoint(_starlingStage,new Point(_loc6_,_loc7_));
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
         var _loc1_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
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
               _loc1_ = getDefinitionByName("flash.desktop::NativeApplication");
               if(_loc1_ != null && _loc1_["nativeApplication"]["activeWindow"] != null)
               {
                  _stage = _loc1_["nativeApplication"]["activeWindow"]["stage"];
                  if(Object(Starling).hasOwnProperty("all"))
                  {
                     _loc4_ = Starling["all"] as Vector.<Starling>;
                     _loc6_ = _loc4_.length;
                     _loc10_ = 0;
                     while(_loc10_ < _loc6_)
                     {
                        _loc3_ = _loc4_[_loc10_];
                        if(_loc3_.nativeStage == _stage)
                        {
                           _starlingStage = _loc3_.stage;
                           break;
                        }
                        _loc10_++;
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
               _loc3_ = getStarlingForStage(_starlingStage);
               _loc7_ = _loc3_.nativeStage;
               _loc2_ = _loc3_.viewPort;
               _loc5_ = _loc3_.contentScaleFactor;
               _loc8_ = (_loc7_.mouseX - _loc2_.x) / _loc5_;
               _loc9_ = (_loc7_.mouseY - _loc2_.y) / _loc5_;
               _starlingHighlightTarget = MonsterDebuggerUtils.getStarlingObjectUnderPoint(_starlingStage,new Point(_loc8_,_loc9_));
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
      
      private static function highlightDraw(param1:Boolean) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:Number = NaN;
         if(_highlightTarget == null && _starlingHighlightTarget == null)
         {
            return;
         }
         if(_highlightTarget != null)
         {
            if(_highlightTarget == _stage)
            {
               _loc8_ = new Rectangle(0,0,_stage.stageWidth,_stage.stageHeight);
            }
            else
            {
               _loc8_ = _highlightTarget.getBounds(_stage);
            }
            _loc7_ = _stage;
         }
         else if(_starlingHighlightTarget != null)
         {
            _loc4_ = getStarlingForStage(_starlingStage);
            _loc7_ = _loc4_.nativeStage;
            _loc3_ = _loc4_.viewPort;
            _loc6_ = _loc4_.contentScaleFactor;
            if(_starlingHighlightTarget == _starlingStage)
            {
               _loc8_ = new Rectangle(_loc3_.x,_loc3_.y,_starlingStage.stageWidth * _loc6_,_starlingStage.stageHeight * _loc6_);
            }
            else
            {
               _loc8_ = _starlingHighlightTarget.getBounds(_starlingStage);
               _loc8_.setTo(_loc8_.x * _loc6_ + _loc3_.x,_loc8_.y * _loc6_ + _loc3_.y,_loc8_.width * _loc6_,_loc8_.height * _loc6_);
            }
         }
         if(_highlightTarget != null && _highlightTarget != _stage || _starlingHighlightTarget != null && _starlingHighlightTarget != _starlingStage)
         {
            _loc8_.x = int(_loc8_.x + 0.5);
            _loc8_.y = int(_loc8_.y + 0.5);
            _loc8_.width = int(_loc8_.width + 0.5);
            _loc8_.height = int(_loc8_.height + 0.5);
         }
         var _loc2_:Rectangle = _loc8_.clone();
         _loc2_.x = _loc2_.x + 2;
         _loc2_.y = _loc2_.y + 2;
         _loc2_.width = _loc2_.width - 4;
         _loc2_.height = _loc2_.height - 4;
         if(_loc2_.width < 0)
         {
            _loc2_.width = 0;
         }
         if(_loc2_.height < 0)
         {
            _loc2_.height = 0;
         }
         _highlight.graphics.clear();
         _highlight.graphics.beginFill(3381759,1);
         _highlight.graphics.drawRect(_loc8_.x,_loc8_.y,_loc8_.width,_loc8_.height);
         _highlight.graphics.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
         if(param1)
         {
            _highlight.graphics.beginFill(3381759,0.25);
            _highlight.graphics.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
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
         var _loc5_:Rectangle = new Rectangle(_loc8_.x,_loc8_.y - (_highlightInfo.textHeight + 3),_highlightInfo.textWidth + 15,_highlightInfo.textHeight + 5);
         if(_loc5_.y < 0)
         {
            _loc5_.y = _loc8_.y + _loc8_.height;
         }
         if(_loc5_.y + _loc5_.height > _loc7_.stageHeight)
         {
            _loc5_.y = _loc7_.stageHeight - _loc5_.height;
         }
         if(_loc5_.x < 0)
         {
            _loc5_.x = 0;
         }
         if(_loc5_.x + _loc5_.width > _loc7_.stageWidth)
         {
            _loc5_.x = _loc7_.stageWidth - _loc5_.width;
         }
         _highlight.graphics.beginFill(3381759,1);
         _highlight.graphics.drawRect(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
         _highlight.graphics.endFill();
         _highlightInfo.x = _loc5_.x;
         _highlightInfo.y = _loc5_.y;
         try
         {
            _loc7_.addChild(_highlight);
            _loc7_.addChild(_highlightInfo);
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
      
      private static function send(param1:Object, param2:Boolean = false) : void
      {
         if(MonsterDebugger.enabled)
         {
            MonsterDebuggerConnection.send("com.demonsters.debugger.core",param1,param2);
         }
      }
      
      private static function getStarlingForStage(param1:starling.display.Stage) : Starling
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(Object(Starling).hasOwnProperty("all"))
         {
            _loc3_ = Starling["all"] as Vector.<Starling>;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = _loc3_[_loc5_];
               if(_loc2_.stage == param1)
               {
                  return _loc2_;
               }
               _loc5_++;
            }
         }
         return Starling.current;
      }
   }
}
