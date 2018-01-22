package yzhkof.debug
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.FileReference;
   import flash.sampler.getMemberNames;
   import flash.system.System;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import mx.graphics.codec.PNGEncoder;
   import yzhkof.KeyMy;
   import yzhkof.MyGC;
   import yzhkof.MyGraphy;
   import yzhkof.ToolBitmapData;
   import yzhkof.guxi.FocusViewer;
   import yzhkof.guxi.GraphicArea;
   import yzhkof.ui.ComponentBase;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.util.DebugUtil;
   import yzhkof.util.RightMenuUtil;
   import yzhkof.util.WeakMap;
   
   public class DebugDisplayObjectViewer extends ComponentBase
   {
      
      public static var SIMPLE:String = "simple";
      
      public static var DETAIL:String = "detail";
       
      
      private var container:TileContainer;
      
      private var btn_container:TileContainer;
      
      private var _currentLeaf:WeakMap;
      
      private var _latestLeaf:WeakMap;
      
      private var dictionary_viewer:DebugDisplayObjectDctionary;
      
      private var currentRefreshType:String = "simple";
      
      private var _drager:DebugDrag;
      
      private var _stage:Stage;
      
      private var _child_map:WeakMap;
      
      private var fold_btn:TextPanel;
      
      private var back_btn:TextPanel;
      
      private var stage_btn:TextPanel;
      
      private var mode_btn_a:TextPanel;
      
      private var mode_btn_b:TextPanel;
      
      private var text_btn:TextPanel;
      
      private var script_btn:TextPanel;
      
      private var refresh_btn:TextPanel;
      
      private var focus_btn:TextPanel;
      
      private var gc_btn:TextPanel;
      
      private var log_btn:TextPanel;
      
      private var weak_log_btn:TextPanel;
      
      private var focus_txt:TextPanel;
      
      private var x_btn:TextPanel;
      
      private var mode_container:Sprite;
      
      private var mask_background:Sprite;
      
      private var viewer:SnapshotDisplayViewer;
      
      private var watcher_btn:TextPanel;
      
      private var _fileReference:FileReference;
      
      private var reference_arr:Array;
      
      private var _locateGraph:GraphicArea;
      
      public function DebugDisplayObjectViewer(param1:Stage)
      {
         this.container = new TileContainer();
         this.btn_container = new TileContainer();
         this._fileReference = new FileReference();
         this.reference_arr = [];
         this._locateGraph = new GraphicArea();
         super();
         this._stage = param1;
         this.currentLeaf = param1;
         this.init();
         this.initEvent();
      }
      
      private function set currentLeaf(param1:*) : void
      {
         this._currentLeaf = new WeakMap();
         this._currentLeaf.add(0,param1);
      }
      
      private function get currentLeaf() : *
      {
         return this._currentLeaf.getValue(0);
      }
      
      private function set latestLeaf(param1:*) : void
      {
         this._latestLeaf = new WeakMap();
         this._latestLeaf.add(0,param1);
      }
      
      private function get latestLeaf() : *
      {
         return this._latestLeaf.getValue(0);
      }
      
      private function init() : void
      {
         this._drager = new DebugDrag();
         this.viewer = new SnapshotDisplayViewer();
         this.dictionary_viewer = new DebugDisplayObjectDctionary();
         this.mode_container = new Sprite();
         this.fold_btn = new TextPanel();
         this.back_btn = new TextPanel();
         this.stage_btn = new TextPanel();
         this.text_btn = new TextPanel();
         this.script_btn = new TextPanel();
         this.refresh_btn = new TextPanel();
         this.focus_btn = new TextPanel();
         this.gc_btn = new TextPanel();
         this.log_btn = new TextPanel();
         this.weak_log_btn = new TextPanel();
         this.watcher_btn = new TextPanel();
         this.focus_txt = new TextPanel();
         this.x_btn = new TextPanel();
         this.mode_btn_a = new TextPanel();
         this.mode_btn_b = new TextPanel();
         this.dictionary_viewer.setup(this);
         this.dictionary_viewer.y = 25;
         this.btn_container.width = 1000;
         this.btn_container.height = 200;
         this.container.width = this._stage.stageWidth;
         this.refresh_btn.text = "刷新";
         this.back_btn.text = "后退";
         this.fold_btn.text = "收起";
         this.stage_btn.text = "舞台";
         this.script_btn.text = "脚本";
         this.text_btn.text = "文本";
         this.focus_btn.text = "焦点";
         this.mode_btn_a.text = "简易";
         this.mode_btn_b.text = "详细";
         this.x_btn.text = "隐藏";
         this.gc_btn.text = "GC";
         this.log_btn.text = "log";
         this.weak_log_btn.text = "回收监视";
         this.watcher_btn.text = "查看";
         addChild(this.btn_container);
         addChild(this.dictionary_viewer);
         addChild(this.container);
         this.mode_container.addChild(this.mode_btn_a);
         this.mode_container.addChild(this.mode_btn_b);
         this.mode_btn_b.visible = false;
         this.setMaskBackGround(MyGraphy.drawRectangle(this._stage.stageWidth,this._stage.stageHeight));
         addChild(this.viewer);
         this.btn_container.appendItem(this.fold_btn);
         this.btn_container.appendItem(this.back_btn);
         this.btn_container.appendItem(this.stage_btn);
         this.btn_container.appendItem(this.text_btn);
         this.btn_container.appendItem(this.script_btn);
         this.btn_container.appendItem(this.refresh_btn);
         this.btn_container.appendItem(this.gc_btn);
         this.btn_container.appendItem(this.log_btn);
         this.btn_container.appendItem(this.weak_log_btn);
         this.btn_container.appendItem(this.watcher_btn);
         this.btn_container.appendItem(this.mode_container);
         this.btn_container.appendItem(this.x_btn);
         this.btn_container.appendItem(this.focus_btn);
         this.btn_container.appendItem(this.focus_txt);
         this.container.width = this._stage.stageWidth;
         this.viewer.visible = false;
         this.mask_background.visible = false;
      }
      
      private function setMaskBackGround(param1:Sprite) : void
      {
         var dobj:Sprite = param1;
         if(this.mask_background)
         {
            removeChild(this.mask_background);
         }
         this.mask_background = dobj;
         this.mask_background.alpha = 0.5;
         this.mask_background.visible = false;
         addChildAt(this.mask_background,this.viewer.parent == this?int(getChildIndex(this.viewer)):int(numChildren));
         this.mask_background.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            viewer.clearView();
            mask_background.visible = false;
         });
      }
      
      private function initEvent() : void
      {
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.__onStageClick,true,int.MAX_VALUE,true);
         this._stage.addEventListener(Event.RESIZE,function(param1:Event):void
         {
            commitChage();
         });
         this.fold_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            visible = false;
         });
         this.mode_btn_a.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            mode_btn_b.visible = true;
            mode_btn_a.visible = false;
            currentRefreshType = DETAIL;
            refresh(currentRefreshType);
         });
         this.mode_btn_b.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            mode_btn_b.visible = false;
            mode_btn_a.visible = true;
            currentRefreshType = SIMPLE;
            refresh(currentRefreshType);
         });
         this.back_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            if(latestLeaf)
            {
               goto(latestLeaf);
            }
         });
         this.stage_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            goto(_stage);
         });
         this.text_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            TextTrace.visible = !TextTrace.visible;
         });
         this.focus_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            FocusViewer.visible = !FocusViewer.visible;
         });
         this.script_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            DebugSystem.scriptViewer.visible = !DebugSystem.scriptViewer.visible;
         });
         this.viewer.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            viewer.clearView();
            mask_background.visible = false;
         });
         this.refresh_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            refresh();
         });
         this.gc_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            System.gc();
            MyGC.gc();
            checkGC();
            dictionary_viewer.checkGC();
            DebugSystem.weakLogViewer.checkGC();
         });
         this.log_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            DebugSystem.logViewer.visible = !DebugSystem.logViewer.visible;
         });
         this.weak_log_btn.addEventListener(MouseEvent.CLICK,function():void
         {
            DebugSystem.weakLogViewer.visible = !DebugSystem.weakLogViewer.visible;
         });
         this.watcher_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            DebugSystem.watchViewer.visible = !DebugSystem.watchViewer.visible;
         });
         this.focus_txt.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            var _loc2_:DisplayObjectContainer = null;
            if(_stage.focus)
            {
               if(param1.shiftKey)
               {
                  debugObjectTrace(_stage.focus);
               }
               else if(param1.ctrlKey)
               {
                  view(_stage.focus);
               }
               else
               {
                  if(_stage.focus is DisplayObjectContainer)
                  {
                     _loc2_ = _stage.focus as DisplayObjectContainer;
                  }
                  else
                  {
                     _loc2_ = _stage.focus.parent;
                  }
                  goto(_loc2_);
               }
            }
         });
         this.x_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            DebugSystem._mainContainer.visible = !DebugSystem._mainContainer.visible;
         });
         addEventListener(Event.ENTER_FRAME,function(param1:Event):void
         {
            focus_txt.text = "stage.focus = \"" + getQualifiedClassName(_stage.focus) + "\"";
         });
      }
      
      override protected function onDraw() : void
      {
         this.setMaskBackGround(MyGraphy.drawRectangle(this._stage.stageWidth,this._stage.stageHeight));
         this.container.width = this._stage.stageWidth;
         this.container.y = this.dictionary_viewer.y + this.dictionary_viewer.contentHeight + 25;
      }
      
      private function __onStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:DisplayObject = null;
         if(param1.altKey)
         {
            _loc2_ = DisplayObject(param1.target);
            _loc3_ = this._stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
            _loc4_ = "";
            do
            {
               _loc7_ = getQualifiedClassName(_loc2_);
               switch(_loc7_)
               {
                  case "flash.display::Stage":
                  case "flash.display::MovieClip":
                  case "flash.text::TextField":
                  case "flash.display::Sprite":
                     break;
                  default:
                     _loc4_ = _loc4_ + (_loc7_ + " || ");
                     if(_loc2_ is DisplayObjectContainer && _loc5_ == null)
                     {
                        _loc5_ = DisplayObjectContainer(_loc2_);
                        break;
                     }
               }
            }
            while(_loc2_ = _loc2_.parent);
            
            _loc6_ = [];
            if(_loc3_)
            {
               for each(_loc8_ in _loc3_)
               {
                  if(!(_loc8_ is DisplayObjectContainer))
                  {
                     _loc6_.push(_loc8_.parent);
                  }
               }
               this.goto(_loc6_.concat(_loc3_),true);
            }
            trace(_loc4_);
         }
      }
      
      public function goto(param1:*, param2:Boolean = false) : void
      {
         if(param1 != null)
         {
            this.latestLeaf = this.currentLeaf;
            this.currentLeaf = param1;
            if(param2)
            {
               this.dictionary_viewer.select(param1);
            }
            else
            {
               this.dictionary_viewer.goto(param1);
            }
            this.refresh(this.currentRefreshType);
            commitChage();
         }
         else
         {
            this.goto(this._stage);
         }
      }
      
      public function view(param1:DisplayObject) : void
      {
         this.viewer.view(param1);
         this.viewer.visible = true;
         this.mask_background.visible = true;
      }
      
      public function savePNG(param1:DisplayObject) : void
      {
         var _loc2_:BitmapData = ToolBitmapData.getInstance().drawDisplayObject(param1);
         var _loc3_:ByteArray = new PNGEncoder().encode(_loc2_);
         this._fileReference.save(_loc3_,param1.name + ".png");
      }
      
      private function getTextPanel(param1:*) : TextPanel
      {
         var _loc2_:TextPanel = null;
         if(param1 is DisplayObject)
         {
            if(param1.visible == false)
            {
               _loc2_ = new TextPanel(16711680);
            }
            else if(param1.getBounds(param1).width == 0 || param1.getBounds(param1).height == 0)
            {
               _loc2_ = new TextPanel(255);
            }
            else if(param1 is DisplayObjectContainer)
            {
               _loc2_ = new TextPanel(16776960);
            }
            else
            {
               _loc2_ = new TextPanel();
            }
         }
         else if(param1 is Function)
         {
            _loc2_ = new TextPanel(8947967);
         }
         else if(param1 == null)
         {
            _loc2_ = new TextPanel(8947848);
         }
         else
         {
            _loc2_ = new TextPanel(16746632);
         }
         return _loc2_;
      }
      
      private function refresh(param1:String = "") : void
      {
         var t_text:TextPanel = null;
         var i:int = 0;
         var length:uint = 0;
         var t_dobj:DisplayObject = null;
         var menber:Object = null;
         var text_buttons:Array = null;
         var q:QName = null;
         var element:TextPanel = null;
         var t_v:* = undefined;
         var type:String = param1;
         var t_currentLeaf:* = this.currentLeaf;
         var t_type:String = type == ""?this.currentRefreshType:type;
         if(t_currentLeaf == null)
         {
            this.goto(this._stage);
         }
         this.container.removeAllChildren();
         this._child_map = new WeakMap();
         this.reference_arr = new Array();
         if(t_currentLeaf is DisplayObjectContainer)
         {
            length = t_currentLeaf.numChildren;
            i = 0;
            while(i < length)
            {
               t_dobj = t_currentLeaf.getChildAt(i);
               t_text = this.getDebugTextButton(t_dobj,!!/instance/.test(t_dobj.name)?getQualifiedClassName(t_dobj):t_dobj.name);
               this.container.appendItem(t_text);
               this.child_map.add(t_text,t_dobj);
               i++;
            }
         }
         if(t_type == DETAIL)
         {
            menber = getMemberNames(t_currentLeaf);
            text_buttons = new Array();
            for each(q in menber)
            {
               try
               {
                  t_v = t_currentLeaf[q];
                  t_text = this.getDebugTextButton(t_v,q.localName);
                  text_buttons.push(t_text);
                  this.reference_arr.push(t_v);
                  this._child_map.add(t_text,t_v);
               }
               catch(e:Error)
               {
                  continue;
               }
            }
            text_buttons.sortOn("text");
            for each(element in text_buttons)
            {
               this.container.appendItem(element);
            }
         }
         this.container.draw();
      }
      
      public function checkGC() : void
      {
         var _loc2_:TextPanel = null;
         var _loc1_:Array = this._child_map.keySet;
         for each(_loc2_ in _loc1_)
         {
            if(!this._child_map.getValue(_loc2_))
            {
               _loc2_.color = 65280;
            }
         }
      }
      
      public function getDebugTextButton(param1:*, param2:String) : TextPanel
      {
         var _loc3_:TextPanel = this.getTextPanel(param1);
         _loc3_.text = param2 || "";
         _loc3_.addEventListener(MouseEvent.CLICK,this.__onItemClick);
         if(param1 is DisplayObject)
         {
            _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.__onItemOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.__onItemOut);
         }
         this.addTextButtonRightMenu(_loc3_,param1);
         return _loc3_;
      }
      
      private function addTextButtonRightMenu(param1:TextPanel, param2:*) : void
      {
         var _loc3_:ContextMenuItem = null;
         RightMenuUtil.hideDefaultMenus(param1);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"定位至脚本");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         if(param2 is DisplayObject)
         {
            _loc3_ = RightMenuUtil.addRightMenu(param1,"快照");
            _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
            _loc3_ = RightMenuUtil.addRightMenu(param1,"快照另存为...");
            _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
            _loc3_ = RightMenuUtil.addRightMenu(param1,"移动");
            _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         }
         _loc3_ = RightMenuUtil.addRightMenu(param1,"察看属性值");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         if(param2 is EventDispatcher)
         {
            _loc3_ = RightMenuUtil.addRightMenu(param1,"察看监听器");
            _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         }
         _loc3_ = RightMenuUtil.addRightMenu(param1,"log");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"放入回收查看器");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"放入回收查看器(所有子显示节点)");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"复制名字");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"复制样式名");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"继承结构");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"click");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         _loc3_ = RightMenuUtil.addRightMenu(param1,"remove");
         _loc3_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
      }
      
      private function __rightMenuClick(param1:ContextMenuEvent) : void
      {
         this.doTextButtonAction(TextPanel(param1.contextMenuOwner),ContextMenuItem(param1.currentTarget).caption);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = this._child_map.getValue(param1.currentTarget);
         if(_loc2_ == null)
         {
            _loc2_ = this.dictionary_viewer._dobj_map.getValue(param1.currentTarget);
         }
         if(_loc2_ == null)
         {
            _loc2_ = DebugSystem.logViewer.logMap[param1.currentTarget];
         }
         if(_loc2_ == null)
         {
            _loc2_ = DebugSystem.weakLogViewer.weakMap.getValue(param1.currentTarget);
         }
         if(_loc2_ && _loc2_.stage)
         {
            addChild(this._locateGraph);
            this._locateGraph.draw(_loc2_);
         }
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         this._locateGraph.clear();
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         this.doTextButtonAction(TextPanel(param1.currentTarget));
      }
      
      private function doTextButtonAction(param1:TextPanel, param2:String = "") : void
      {
         var name_arr:Array = null;
         var str:String = null;
         var current:* = undefined;
         var classDef:Object = null;
         var target:TextPanel = param1;
         var rightMenuName:String = param2;
         var gotoObj:* = this._child_map.getValue(target);
         if(gotoObj == null)
         {
            gotoObj = this.dictionary_viewer._dobj_map.getValue(target);
         }
         if(gotoObj == null)
         {
            gotoObj = DebugSystem.logViewer.logMap[target];
         }
         if(gotoObj == null)
         {
            gotoObj = DebugSystem.weakLogViewer.weakMap.getValue(target);
         }
         if(KeyMy.isDown(83) || rightMenuName == "察看监听器")
         {
            debugTrace(DebugUtil.analyseInstance(gotoObj));
         }
         else if(KeyMy.isDown(84) || rightMenuName == "定位至脚本")
         {
            DebugSystem.scriptViewer.setTarget(gotoObj);
         }
         else if(KeyMy.isDown(87) || rightMenuName == "log")
         {
            DebugSystem.logViewer.addLogDirectly(gotoObj,"<watch>");
         }
         else if(rightMenuName == "放入回收查看器")
         {
            DebugSystem.weakLogViewer.addLogDirectly(gotoObj);
         }
         else if(rightMenuName == "放入回收查看器(所有子显示节点)")
         {
            logGC(gotoObj,"",true);
         }
         else if(KeyMy.isDown(17) || rightMenuName == "快照")
         {
            if(gotoObj is DisplayObject)
            {
               this.view(gotoObj);
            }
         }
         else if(rightMenuName == "快照另存为...")
         {
            if(gotoObj is DisplayObject)
            {
               this.savePNG(gotoObj);
            }
         }
         else if(KeyMy.isDown(16) || rightMenuName == "察看属性值")
         {
            debugObjectTrace(gotoObj);
         }
         else if(KeyMy.isDown(89) || rightMenuName == "移动")
         {
            if(gotoObj != null && gotoObj is DisplayObject)
            {
               this._drager.target = gotoObj;
            }
         }
         else if(KeyMy.isDown(67) || rightMenuName == "复制样式名")
         {
            if(gotoObj.hasOwnProperty("stylename"))
            {
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,gotoObj["stylename"]);
            }
         }
         else if(rightMenuName == "复制名字")
         {
            name_arr = target.text.split("::");
            System.setClipboard(name_arr.length > 1?name_arr[1]:name_arr[0]);
         }
         else if(rightMenuName == "继承结构")
         {
            if(gotoObj == null)
            {
               return;
            }
            str = "";
            current = gotoObj;
            while(1)
            {
               try
               {
                  current = getDefinitionByName(getQualifiedSuperclassName(current));
                  str = "->" + current + "\n" + str;
               }
               catch(e:Error)
               {
                  break;
               }
            }
            debugObjectTrace(str);
         }
         else if(rightMenuName == "click")
         {
            if(gotoObj is EventDispatcher)
            {
               EventDispatcher(gotoObj).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
         }
         else if(rightMenuName == "remove")
         {
            if(gotoObj is DisplayObject)
            {
               if(gotoObj.hasOwnProperty("dispose") && gotoObj["dispose"] is Function)
               {
                  gotoObj.dispose();
               }
               else if(DisplayObject(gotoObj).parent)
               {
                  DisplayObject(gotoObj).parent.removeChild(DisplayObject(gotoObj));
               }
            }
         }
         else if(gotoObj == null)
         {
            debugObjectTrace(gotoObj);
         }
         else if(gotoObj is Function)
         {
            DebugSystem.scriptViewer.setTarget(gotoObj);
         }
         else
         {
            try
            {
               classDef = getDefinitionByName(getQualifiedClassName(gotoObj));
            }
            catch(e:Error)
            {
               classDef = null;
            }
            switch(classDef)
            {
               case int:
               case Number:
               case String:
                  debugObjectTrace(gotoObj);
                  break;
               default:
                  this.goto(gotoObj);
            }
         }
      }
      
      public function get child_map() : WeakMap
      {
         return this._child_map;
      }
   }
}
