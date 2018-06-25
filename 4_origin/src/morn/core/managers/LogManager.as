package morn.core.managers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import morn.core.utils.ObjectUtils;
   
   public class LogManager extends Sprite
   {
       
      
      private var _msgs:Array;
      
      private var _box:Sprite;
      
      private var _textField:TextField;
      
      private var _filter:TextField;
      
      private var _filters:Array;
      
      private var _canScroll:Boolean = true;
      
      private var _scroll:TextField;
      
      public function LogManager()
      {
         _msgs = [];
         _filters = [];
         super();
         _box = new Sprite();
         _box.addChild(ObjectUtils.createBitmap(400,300,3355443,0.9));
         _box.visible = false;
         addChild(_box);
         _filter = new TextField();
         _filter.width = 270;
         _filter.height = 20;
         _filter.type = "input";
         _filter.textColor = 16777215;
         _filter.border = true;
         _filter.borderColor = 12566463;
         _filter.defaultTextFormat = new TextFormat("Arial",12);
         _filter.addEventListener("keyDown",onFilterKeyDown);
         _filter.addEventListener("focusOut",onFilterFocusOut);
         _box.addChild(_filter);
         var clear:TextField = createLinkButton("Clear");
         clear.addEventListener("click",onClearClick);
         clear.x = 280;
         _box.addChild(clear);
         _scroll = createLinkButton("Pause");
         _scroll.addEventListener("click",onScrollClick);
         _scroll.x = 315;
         _box.addChild(_scroll);
         var copy:TextField = createLinkButton("Copy");
         copy.addEventListener("click",onCopyClick);
         copy.x = 350;
         _box.addChild(copy);
         _textField = new TextField();
         _textField.width = 400;
         _textField.height = 280;
         _textField.y = 20;
         _textField.multiline = true;
         _textField.wordWrap = true;
         _textField.defaultTextFormat = new TextFormat("微软雅黑,Arial");
         _box.addChild(_textField);
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(e:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         stage.addEventListener("keyDown",onStageKeyDown);
      }
      
      private function createLinkButton(text:String) : TextField
      {
         var tf:TextField = new TextField();
         tf.selectable = false;
         tf.autoSize = "left";
         tf.textColor = 32960;
         tf.filters = [new GlowFilter(16777215,0.8,2,2,10)];
         tf.text = text;
         return tf;
      }
      
      private function onCopyClick(e:MouseEvent) : void
      {
         System.setClipboard(_textField.text);
      }
      
      private function onScrollClick(e:MouseEvent) : void
      {
         _canScroll = !_canScroll;
         _scroll.text = !!_canScroll?"Pause":"Start";
         if(_canScroll)
         {
            refresh(null);
         }
      }
      
      private function onClearClick(e:MouseEvent) : void
      {
         clear();
      }
      
      private function onFilterKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == 13)
         {
            App.stage.focus = _box;
         }
      }
      
      private function onFilterFocusOut(e:FocusEvent) : void
      {
         _filters = !!_filter.text?_filter.text.split(","):[];
         refresh(null);
      }
      
      private function onStageKeyDown(e:KeyboardEvent) : void
      {
         if(e.ctrlKey && e.keyCode == 76)
         {
            toggle();
         }
      }
      
      public function clear() : void
      {
         _msgs.length = 0;
         _textField.htmlText = "";
      }
      
      public function info(... args) : void
      {
         print("info",args,4111860);
      }
      
      public function echo(... args) : void
      {
         print("echo",args,50176);
      }
      
      public function debug(... args) : void
      {
         print("debug",args,14540032);
      }
      
      public function error(... args) : void
      {
         print("error",args,16729670);
      }
      
      public function warn(... args) : void
      {
         print("warn",args,16777088);
      }
      
      public function print(type:String, args:Array, color:uint) : void
      {
         var msg:String = "<p><font color=\'#" + color.toString(16) + "\'><b>[" + type + "]</b></font> <font color=\'#EEEEEE\'>" + args.join(" ") + "</font></p>";
         trace("[" + type + "]",args.join(" "));
         if(_msgs.length > 500)
         {
            _msgs.length = 0;
         }
         _msgs.push(msg);
         if(_box.visible)
         {
            refresh(msg);
         }
      }
      
      public function toggle() : void
      {
         _box.visible = !_box.visible;
         if(_box.visible)
         {
            refresh(null);
         }
      }
      
      private function refresh(newMsg:String) : void
      {
         var msg:String = "";
         if(newMsg != null)
         {
            if(isFilter(newMsg))
            {
               msg = (_textField.htmlText || "") + newMsg;
               _textField.htmlText = msg;
            }
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = _msgs;
            for each(var item in _msgs)
            {
               if(isFilter(item))
               {
                  msg = msg + item;
               }
            }
            _textField.htmlText = msg;
         }
         if(_canScroll)
         {
            _textField.scrollV = _textField.maxScrollV;
         }
      }
      
      private function isFilter(msg:String) : Boolean
      {
         if(_filters.length < 1)
         {
            return true;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _filters;
         for each(var item in _filters)
         {
            if(msg.indexOf(item) > -1)
            {
               return true;
            }
         }
         return false;
      }
   }
}
