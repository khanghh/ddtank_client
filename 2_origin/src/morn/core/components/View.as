package morn.core.components
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import morn.core.ex.ButtonEx;
   import morn.core.ex.LevelIconEx;
   import morn.core.ex.NameTextEx;
   import morn.core.ex.NumberImageEx;
   import morn.core.ex.NumericStepper;
   import morn.core.ex.PageNavigaterEx;
   import morn.core.ex.TabButtonEx;
   import morn.core.ex.TabEx;
   import morn.core.ex.TabListEx;
   import morn.core.handlers.Handler;
   import morn.editor.core.IRender;
   
   public class View extends Box
   {
      
      public static var uiMap:Object = {};
      
      protected static var uiClassMap:Object = {
         "Box":Box,
         "Button":Button,
         "CheckBox":CheckBox,
         "Clip":Clip,
         "ComboBox":ComboBox,
         "Component":Component,
         "Container":Container,
         "FrameClip":FrameClip,
         "HScrollBar":HScrollBar,
         "HSlider":HSlider,
         "Image":Image,
         "Label":Label,
         "LinkButton":LinkButton,
         "List":List,
         "Panel":Panel,
         "ProgressBar":ProgressBar,
         "RadioButton":RadioButton,
         "RadioGroup":RadioGroup,
         "ScrollBar":ScrollBar,
         "Slider":Slider,
         "Tab":Tab,
         "TextArea":TextArea,
         "TextInput":TextInput,
         "View":View,
         "ViewStack":ViewStack,
         "VScrollBar":VScrollBar,
         "VSlider":VSlider,
         "HBox":HBox,
         "VBox":VBox,
         "Tree":Tree,
         "ColorPicker":ColorPicker,
         "ProxyItem":ProxyItem,
         "LevelIconEx":LevelIconEx,
         "NumberImageEx":NumberImageEx,
         "NameTextEx":NameTextEx,
         "PageNavigaterEx":PageNavigaterEx,
         "ButtonEx":ButtonEx,
         "TabEx":TabEx,
         "NumericStepper":NumericStepper,
         "TabListEx":TabListEx,
         "TabButtonEx":TabButtonEx
      };
      
      protected static var viewClassMap:Object = {};
       
      
      private var _enableEscKey:Boolean = false;
      
      private var _escKeyHandler:Handler;
      
      private var _enterKeyHandler:Handler;
      
      public function View()
      {
         super();
      }
      
      public static function createComp(param1:Object, param2:Component = null, param3:View = null) : Component
      {
         if(param1 is XML)
         {
            return createCompByXML(param1 as XML,param2,param3);
         }
         return createCompByJSON(param1,param2,param3);
      }
      
      protected static function createCompByJSON(param1:Object, param2:Component = null, param3:View = null) : Component
      {
         var _loc6_:* = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         param2 = param2 || getCompInstanceByJSON(param1);
         param2.comJSON = param1;
         var _loc4_:Array = param1.child;
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               if(param2 is IRender && _loc7_.props.name == "render")
               {
                  IRender(param2).itemRender = _loc7_;
               }
               else
               {
                  param2.addChild(createCompByJSON(_loc7_,null,param3));
               }
            }
         }
         var _loc5_:Object = param1.props;
         for(_loc6_ in _loc5_)
         {
            _loc8_ = _loc5_[_loc6_];
            setCompValue(param2,_loc6_,_loc8_,param3);
         }
         if(param2 is IItem)
         {
            IItem(param2).initItems();
         }
         return param2;
      }
      
      protected static function createCompByXML(param1:XML, param2:Component = null, param3:View = null) : Component
      {
         var _loc8_:XML = null;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         param2 = param2 || getCompInstanceByXML(param1);
         if(!param2)
         {
            return null;
         }
         param2.comXml = param1;
         var _loc4_:XMLList = param1.children();
         var _loc5_:int = 0;
         var _loc6_:int = _loc4_.length();
         while(_loc5_ < _loc6_)
         {
            _loc9_ = _loc4_[_loc5_];
            if(param2 is IRender && _loc9_.@name == "render")
            {
               IRender(param2).itemRender = _loc9_;
            }
            else
            {
               param2.addChild(createComp(_loc9_,null,param3));
            }
            _loc5_++;
         }
         var _loc7_:XMLList = param1.attributes();
         for each(_loc8_ in _loc7_)
         {
            _loc10_ = _loc8_.name().toString();
            _loc11_ = _loc8_.toString();
            setCompValue(param2,_loc10_,_loc11_,param3);
         }
         if(param2 is IItem)
         {
            IItem(param2).initItems();
         }
         return param2;
      }
      
      private static function setCompValue(param1:Component, param2:String, param3:String, param4:View = null) : void
      {
         if(param1.hasOwnProperty(param2))
         {
            param1[param2] = param3 == "true"?true:param3 == "false"?false:param3;
         }
         else if(param2 == "var" && param4 && param4.hasOwnProperty(param3))
         {
            param4[param3] = param1;
         }
      }
      
      protected static function getCompInstanceByJSON(param1:Object) : Component
      {
         var _loc2_:String = !!param1.props?param1.props.runtime:"";
         var _loc3_:Class = !!Boolean(_loc2_)?viewClassMap[_loc2_]:uiClassMap[param1.type];
         return !!_loc3_?new _loc3_():null;
      }
      
      protected static function getCompInstanceByXML(param1:XML) : Component
      {
         var _loc2_:String = param1.@runtime;
         var _loc3_:Class = !!Boolean(_loc2_)?viewClassMap[_loc2_]:uiClassMap[param1.name()];
         return !!_loc3_?new _loc3_():null;
      }
      
      public static function registerComponent(param1:String, param2:Class) : void
      {
         uiClassMap[param1] = param2;
      }
      
      public static function registerViewRuntime(param1:String, param2:Class) : void
      {
         viewClassMap[param1] = param2;
      }
      
      protected function createView(param1:Object) : void
      {
         createComp(param1,this,this);
      }
      
      protected function loadUI(param1:String) : void
      {
         var _loc2_:Object = uiMap[param1];
         if(_loc2_)
         {
            this.createView(_loc2_);
         }
      }
      
      public function reCreate(param1:Component = null) : void
      {
         param1 = param1 || this;
         var _loc2_:Object = param1.dataSource;
         if(param1 is Box)
         {
            Box(param1).removeAllChild();
         }
         createComp(param1.comJSON || param1.comXml,param1,this);
         param1.dataSource = _loc2_;
      }
      
      public function get enableEscKey() : Boolean
      {
         return this._enableEscKey;
      }
      
      public function set enableEscKey(param1:Boolean) : void
      {
         this._enableEscKey = param1;
         if(param1)
         {
            this.addKeyEvent();
         }
      }
      
      public function get escKeyHandler() : Handler
      {
         return this._escKeyHandler;
      }
      
      public function set escKeyHandler(param1:Handler) : void
      {
         this._escKeyHandler = param1;
         if(param1)
         {
            this.addKeyEvent();
         }
      }
      
      public function get enterKeyHandler() : Handler
      {
         return this._enterKeyHandler;
      }
      
      public function set enterKeyHandler(param1:Handler) : void
      {
         this._enterKeyHandler = param1;
         if(param1)
         {
            this.addKeyEvent();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:int = numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            ObjectUtils.disposeObject(getChildAt(0));
            _loc2_++;
         }
         this.removeEventListener(KeyboardEvent.KEY_UP,this.keyHandler);
         StageReferance.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyHandler);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function addKeyEvent() : void
      {
         if(this.hasEventListener(KeyboardEvent.KEY_UP))
         {
            return;
         }
         this.addEventListener(KeyboardEvent.KEY_UP,this.keyHandler);
         StageReferance.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyHandler);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         StageReferance.stage.focus = this;
      }
      
      private function keyHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE && this._enableEscKey)
         {
            param1.stopImmediatePropagation();
            if(this._escKeyHandler)
            {
               this._escKeyHandler.execute();
            }
            else
            {
               ObjectUtils.disposeObject(this);
            }
         }
         if(param1.keyCode == Keyboard.ENTER && this._enterKeyHandler)
         {
            param1.stopImmediatePropagation();
            this._enterKeyHandler.execute();
         }
      }
   }
}
