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
   import flash.ui.Keyboard;
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
         this._msgs = [];
         this._filters = [];
         super();
         this._box = new Sprite();
         this._box.addChild(ObjectUtils.createBitmap(400,300,3355443,0.9));
         this._box.visible = false;
         addChild(this._box);
         this._filter = new TextField();
         this._filter.width = 270;
         this._filter.height = 20;
         this._filter.type = "input";
         this._filter.textColor = 16777215;
         this._filter.border = true;
         this._filter.borderColor = 12566463;
         this._filter.defaultTextFormat = new TextFormat("Arial",12);
         this._filter.addEventListener(KeyboardEvent.KEY_DOWN,this.onFilterKeyDown);
         this._filter.addEventListener(FocusEvent.FOCUS_OUT,this.onFilterFocusOut);
         this._box.addChild(this._filter);
         var _loc1_:TextField = this.createLinkButton("Clear");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onClearClick);
         _loc1_.x = 280;
         this._box.addChild(_loc1_);
         this._scroll = this.createLinkButton("Pause");
         this._scroll.addEventListener(MouseEvent.CLICK,this.onScrollClick);
         this._scroll.x = 315;
         this._box.addChild(this._scroll);
         var _loc2_:TextField = this.createLinkButton("Copy");
         _loc2_.addEventListener(MouseEvent.CLICK,this.onCopyClick);
         _loc2_.x = 350;
         this._box.addChild(_loc2_);
         this._textField = new TextField();
         this._textField.width = 400;
         this._textField.height = 280;
         this._textField.y = 20;
         this._textField.multiline = true;
         this._textField.wordWrap = true;
         this._textField.defaultTextFormat = new TextFormat("微软雅黑,Arial");
         this._box.addChild(this._textField);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown);
      }
      
      private function createLinkButton(param1:String) : TextField
      {
         var _loc2_:TextField = null;
         _loc2_ = new TextField();
         _loc2_.selectable = false;
         _loc2_.autoSize = "left";
         _loc2_.textColor = 32960;
         _loc2_.filters = [new GlowFilter(16777215,0.8,2,2,10)];
         _loc2_.text = param1;
         return _loc2_;
      }
      
      private function onCopyClick(param1:MouseEvent) : void
      {
         System.setClipboard(this._textField.text);
      }
      
      private function onScrollClick(param1:MouseEvent) : void
      {
         this._canScroll = !this._canScroll;
         this._scroll.text = !!this._canScroll?"Pause":"Start";
         if(this._canScroll)
         {
            this.refresh(null);
         }
      }
      
      private function onClearClick(param1:MouseEvent) : void
      {
         this.clear();
      }
      
      private function onFilterKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            App.stage.focus = this._box;
         }
      }
      
      private function onFilterFocusOut(param1:FocusEvent) : void
      {
         this._filters = !!Boolean(this._filter.text)?this._filter.text.split(","):[];
         this.refresh(null);
      }
      
      private function onStageKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.ctrlKey && param1.keyCode == Keyboard.L)
         {
            this.toggle();
         }
      }
      
      public function clear() : void
      {
         this._msgs.length = 0;
         this._textField.htmlText = "";
      }
      
      public function info(... rest) : void
      {
         this.print("info",rest,4111860);
      }
      
      public function echo(... rest) : void
      {
         this.print("echo",rest,50176);
      }
      
      public function debug(... rest) : void
      {
         this.print("debug",rest,14540032);
      }
      
      public function error(... rest) : void
      {
         this.print("error",rest,16729670);
      }
      
      public function warn(... rest) : void
      {
         this.print("warn",rest,16777088);
      }
      
      public function print(param1:String, param2:Array, param3:uint) : void
      {
         var _loc4_:String = "<p><font color=\'#" + param3.toString(16) + "\'><b>[" + param1 + "]</b></font> <font color=\'#EEEEEE\'>" + param2.join(" ") + "</font></p>";
         trace("[" + param1 + "]",param2.join(" "));
         if(this._msgs.length > 500)
         {
            this._msgs.length = 0;
         }
         this._msgs.push(_loc4_);
         if(this._box.visible)
         {
            this.refresh(_loc4_);
         }
      }
      
      public function toggle() : void
      {
         this._box.visible = !this._box.visible;
         if(this._box.visible)
         {
            this.refresh(null);
         }
      }
      
      private function refresh(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         if(param1 != null)
         {
            if(this.isFilter(param1))
            {
               _loc2_ = (this._textField.htmlText || "") + param1;
               this._textField.htmlText = _loc2_;
            }
         }
         else
         {
            for each(_loc3_ in this._msgs)
            {
               if(this.isFilter(_loc3_))
               {
                  _loc2_ = _loc2_ + _loc3_;
               }
            }
            this._textField.htmlText = _loc2_;
         }
         if(this._canScroll)
         {
            this._textField.scrollV = this._textField.maxScrollV;
         }
      }
      
      private function isFilter(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(this._filters.length < 1)
         {
            return true;
         }
         for each(_loc2_ in this._filters)
         {
            if(param1.indexOf(_loc2_) > -1)
            {
               return true;
            }
         }
         return false;
      }
   }
}
