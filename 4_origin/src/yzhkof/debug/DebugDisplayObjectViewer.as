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
      
      public function DebugDisplayObjectViewer(_stage:Stage)
      {
         this.container = new TileContainer();
         this.btn_container = new TileContainer();
         this._fileReference = new FileReference();
         this.reference_arr = [];
         this._locateGraph = new GraphicArea();
         super();
         this._stage = _stage;
         this.currentLeaf = _stage;
         this.init();
         this.initEvent();
      }
      
      private function set currentLeaf(value:*) : void
      {
         this._currentLeaf = new WeakMap();
         this._currentLeaf.add(0,value);
      }
      
      private function get currentLeaf() : *
      {
         return this._currentLeaf.getValue(0);
      }
      
      private function set latestLeaf(value:*) : void
      {
         this._latestLeaf = new WeakMap();
         this._latestLeaf.add(0,value);
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
      
      private function setMaskBackGround(dobj:Sprite) : void
      {
         if(this.mask_background)
         {
            removeChild(this.mask_background);
         }
         this.mask_background = dobj;
         this.mask_background.alpha = 0.5;
         this.mask_background.visible = false;
         addChildAt(this.mask_background,this.viewer.parent == this?int(getChildIndex(this.viewer)):int(numChildren));
         this.mask_background.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            viewer.clearView();
            mask_background.visible = false;
         });
      }
      
      private function initEvent() : void
      {
         this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.__onStageClick,true,int.MAX_VALUE,true);
         this._stage.addEventListener(Event.RESIZE,function(e:Event):void
         {
            commitChage();
         });
         this.fold_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            visible = false;
         });
         this.mode_btn_a.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            mode_btn_b.visible = true;
            mode_btn_a.visible = false;
            currentRefreshType = DETAIL;
            refresh(currentRefreshType);
         });
         this.mode_btn_b.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            mode_btn_b.visible = false;
            mode_btn_a.visible = true;
            currentRefreshType = SIMPLE;
            refresh(currentRefreshType);
         });
         this.back_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            if(latestLeaf)
            {
               goto(latestLeaf);
            }
         });
         this.stage_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            goto(_stage);
         });
         this.text_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            TextTrace.visible = !TextTrace.visible;
         });
         this.focus_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            FocusViewer.visible = !FocusViewer.visible;
         });
         this.script_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            DebugSystem.scriptViewer.visible = !DebugSystem.scriptViewer.visible;
         });
         this.viewer.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            viewer.clearView();
            mask_background.visible = false;
         });
         this.refresh_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            refresh();
         });
         this.gc_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            System.gc();
            MyGC.gc();
            checkGC();
            dictionary_viewer.checkGC();
            DebugSystem.weakLogViewer.checkGC();
         });
         this.log_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            DebugSystem.logViewer.visible = !DebugSystem.logViewer.visible;
         });
         this.weak_log_btn.addEventListener(MouseEvent.CLICK,function():void
         {
            DebugSystem.weakLogViewer.visible = !DebugSystem.weakLogViewer.visible;
         });
         this.watcher_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            DebugSystem.watchViewer.visible = !DebugSystem.watchViewer.visible;
         });
         this.focus_txt.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            var t:DisplayObjectContainer = null;
            if(_stage.focus)
            {
               if(e.shiftKey)
               {
                  debugObjectTrace(_stage.focus);
               }
               else if(e.ctrlKey)
               {
                  view(_stage.focus);
               }
               else
               {
                  if(_stage.focus is DisplayObjectContainer)
                  {
                     t = _stage.focus as DisplayObjectContainer;
                  }
                  else
                  {
                     t = _stage.focus.parent;
                  }
                  goto(t);
               }
            }
         });
         this.x_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            DebugSystem._mainContainer.visible = !DebugSystem._mainContainer.visible;
         });
         addEventListener(Event.ENTER_FRAME,function(e:Event):void
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
      
      private function __onStageClick(e:MouseEvent) : void
      {
         var dobj:DisplayObject = null;
         var dobj_arr:Array = null;
         var str:String = null;
         var go_dobj:DisplayObjectContainer = null;
         var parent_arr:Array = null;
         var t:String = null;
         var i:DisplayObject = null;
         if(e.altKey)
         {
            dobj = DisplayObject(e.target);
            dobj_arr = this._stage.getObjectsUnderPoint(new Point(e.stageX,e.stageY));
            str = "";
            do
            {
               t = getQualifiedClassName(dobj);
               switch(t)
               {
                  case "flash.display::Stage":
                  case "flash.display::MovieClip":
                  case "flash.text::TextField":
                  case "flash.display::Sprite":
                     break;
                  default:
                     str = str + (t + " || ");
                     if(dobj is DisplayObjectContainer && go_dobj == null)
                     {
                        go_dobj = DisplayObjectContainer(dobj);
                        break;
                     }
               }
            }
            while(dobj = dobj.parent);
            
            parent_arr = [];
            if(dobj_arr)
            {
               for each(i in dobj_arr)
               {
                  if(!(i is DisplayObjectContainer))
                  {
                     parent_arr.push(i.parent);
                  }
               }
               this.goto(parent_arr.concat(dobj_arr),true);
            }
            trace(str);
         }
      }
      
      public function goto(obj:*, select:Boolean = false) : void
      {
         if(obj != null)
         {
            this.latestLeaf = this.currentLeaf;
            this.currentLeaf = obj;
            if(select)
            {
               this.dictionary_viewer.select(obj);
            }
            else
            {
               this.dictionary_viewer.goto(obj);
            }
            this.refresh(this.currentRefreshType);
            commitChage();
         }
         else
         {
            this.goto(this._stage);
         }
      }
      
      public function view(dobj:DisplayObject) : void
      {
         this.viewer.view(dobj);
         this.viewer.visible = true;
         this.mask_background.visible = true;
      }
      
      public function savePNG(dobj:DisplayObject) : void
      {
         var bitmapdata:BitmapData = ToolBitmapData.getInstance().drawDisplayObject(dobj);
         var pngBytes:ByteArray = new PNGEncoder().encode(bitmapdata);
         this._fileReference.save(pngBytes,dobj.name + ".png");
      }
      
      private function getTextPanel(obj:*) : TextPanel
      {
         var t_text:TextPanel = null;
         if(obj is DisplayObject)
         {
            if(obj.visible == false)
            {
               t_text = new TextPanel(16711680);
            }
            else if(obj.getBounds(obj).width == 0 || obj.getBounds(obj).height == 0)
            {
               t_text = new TextPanel(255);
            }
            else if(obj is DisplayObjectContainer)
            {
               t_text = new TextPanel(16776960);
            }
            else
            {
               t_text = new TextPanel();
            }
         }
         else if(obj is Function)
         {
            t_text = new TextPanel(8947967);
         }
         else if(obj == null)
         {
            t_text = new TextPanel(8947848);
         }
         else
         {
            t_text = new TextPanel(16746632);
         }
         return t_text;
      }
      
      private function refresh(type:String = "") : void
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
            for(i = 0; i < length; i++)
            {
               t_dobj = t_currentLeaf.getChildAt(i);
               t_text = this.getDebugTextButton(t_dobj,!!/instance/.test(t_dobj.name)?getQualifiedClassName(t_dobj):t_dobj.name);
               this.container.appendItem(t_text);
               this.child_map.add(t_text,t_dobj);
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
         var i:TextPanel = null;
         var text_arr:Array = this._child_map.keySet;
         for each(i in text_arr)
         {
            if(!this._child_map.getValue(i))
            {
               i.color = 65280;
            }
         }
      }
      
      public function getDebugTextButton(obj:*, text:String) : TextPanel
      {
         var text_panel:TextPanel = this.getTextPanel(obj);
         text_panel.text = text || "";
         text_panel.addEventListener(MouseEvent.CLICK,this.__onItemClick);
         if(obj is DisplayObject)
         {
            text_panel.addEventListener(MouseEvent.ROLL_OVER,this.__onItemOver);
            text_panel.addEventListener(MouseEvent.ROLL_OUT,this.__onItemOut);
         }
         this.addTextButtonRightMenu(text_panel,obj);
         return text_panel;
      }
      
      private function addTextButtonRightMenu(text_panel:TextPanel, obj:*) : void
      {
         var item:ContextMenuItem = null;
         RightMenuUtil.hideDefaultMenus(text_panel);
         item = RightMenuUtil.addRightMenu(text_panel,"定位至脚本");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         if(obj is DisplayObject)
         {
            item = RightMenuUtil.addRightMenu(text_panel,"快照");
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
            item = RightMenuUtil.addRightMenu(text_panel,"快照另存为...");
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
            item = RightMenuUtil.addRightMenu(text_panel,"移动");
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         }
         item = RightMenuUtil.addRightMenu(text_panel,"察看属性值");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         if(obj is EventDispatcher)
         {
            item = RightMenuUtil.addRightMenu(text_panel,"察看监听器");
            item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         }
         item = RightMenuUtil.addRightMenu(text_panel,"log");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"放入回收查看器");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"放入回收查看器(所有子显示节点)");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"复制名字");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"复制样式名");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"继承结构");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"click");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
         item = RightMenuUtil.addRightMenu(text_panel,"remove");
         item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__rightMenuClick);
      }
      
      private function __rightMenuClick(event:ContextMenuEvent) : void
      {
         this.doTextButtonAction(TextPanel(event.contextMenuOwner),ContextMenuItem(event.currentTarget).caption);
      }
      
      private function __onItemOver(e:MouseEvent) : void
      {
         var gotoObj:DisplayObject = this._child_map.getValue(e.currentTarget);
         if(gotoObj == null)
         {
            gotoObj = this.dictionary_viewer._dobj_map.getValue(e.currentTarget);
         }
         if(gotoObj == null)
         {
            gotoObj = DebugSystem.logViewer.logMap[e.currentTarget];
         }
         if(gotoObj == null)
         {
            gotoObj = DebugSystem.weakLogViewer.weakMap.getValue(e.currentTarget);
         }
         if(gotoObj && gotoObj.stage)
         {
            addChild(this._locateGraph);
            this._locateGraph.draw(gotoObj);
         }
      }
      
      private function __onItemOut(event:MouseEvent) : void
      {
         this._locateGraph.clear();
      }
      
      private function __onItemClick(e:MouseEvent) : void
      {
         this.doTextButtonAction(TextPanel(e.currentTarget));
      }
      
      private function doTextButtonAction(target:TextPanel, rightMenuName:String = "") : void
      {
         var name_arr:Array = null;
         var str:String = null;
         var current:* = undefined;
         var classDef:Object = null;
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
