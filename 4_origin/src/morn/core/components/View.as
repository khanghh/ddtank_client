package morn.core.components
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import morn.core.ex.ButtonEx;
   import morn.core.ex.LevelIconEx;
   import morn.core.ex.NameTextEx;
   import morn.core.ex.NumberImageEx;
   import morn.core.ex.NumericStepper;
   import morn.core.ex.PageNavigaterEx;
   import morn.core.ex.ScaleLeftRightImageEx;
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
         "TabButtonEx":TabButtonEx,
         "ScaleLeftRightImageEx":ScaleLeftRightImageEx
      };
      
      protected static var viewClassMap:Object = {};
       
      
      private var _enableEscKey:Boolean = false;
      
      private var _escKeyHandler:Handler;
      
      private var _enterKeyHandler:Handler;
      
      public function View()
      {
         super();
      }
      
      public static function createComp(uiView:Object, comp:Component = null, view:View = null) : Component
      {
         if(uiView is XML)
         {
            return createCompByXML(uiView as XML,comp,view);
         }
         return createCompByJSON(uiView,comp,view);
      }
      
      protected static function createCompByJSON(json:Object, comp:Component = null, view:View = null) : Component
      {
         var value:* = null;
         comp = comp || getCompInstanceByJSON(json);
         comp.comJSON = json;
         var child:Array = json.child;
         if(child)
         {
            var _loc10_:int = 0;
            var _loc9_:* = child;
            for each(var note in child)
            {
               if(comp is IRender && note.props.name == "render")
               {
                  IRender(comp).itemRender = note;
               }
               else
               {
                  comp.addChild(createCompByJSON(note,null,view));
               }
            }
         }
         var props:Object = json.props;
         var _loc12_:int = 0;
         var _loc11_:* = props;
         for(var prop in props)
         {
            value = props[prop];
            setCompValue(comp,prop,value,view);
         }
         if(comp is IItem)
         {
            IItem(comp).initItems();
         }
         return comp;
      }
      
      protected static function createCompByXML(xml:XML, comp:Component = null, view:View = null) : Component
      {
         var i:int = 0;
         var m:int = 0;
         var node:* = null;
         var prop:* = null;
         var value:* = null;
         comp = comp || getCompInstanceByXML(xml);
         if(!comp)
         {
            return null;
         }
         comp.comXml = xml;
         var list:XMLList = xml.children();
         for(i = 0,m = list.length(); i < m; )
         {
            node = list[i];
            if(comp is IRender && node.@name == "render")
            {
               IRender(comp).itemRender = node;
            }
            else
            {
               comp.addChild(createComp(node,null,view));
            }
            i++;
         }
         var list2:XMLList = xml.attributes();
         var _loc13_:int = 0;
         var _loc12_:* = list2;
         for each(var attrs in list2)
         {
            prop = attrs.name().toString();
            value = attrs.toString();
            setCompValue(comp,prop,value,view);
         }
         if(comp is IItem)
         {
            IItem(comp).initItems();
         }
         return comp;
      }
      
      private static function setCompValue(comp:Component, prop:String, value:String, view:View = null) : void
      {
         if(comp.hasOwnProperty(prop))
         {
            comp[prop] = value == "true"?true:value == "false"?false:value;
         }
         else if(prop == "var" && view && view.hasOwnProperty(value))
         {
            view[value] = comp;
            comp.stylename = value;
         }
      }
      
      protected static function getCompInstanceByJSON(json:Object) : Component
      {
         var runtime:String = !!json.props?json.props.runtime:"";
         var compClass:Class = !!runtime?viewClassMap[runtime]:uiClassMap[json.type];
         return !!compClass?new compClass():null;
      }
      
      protected static function getCompInstanceByXML(xml:XML) : Component
      {
         var runtime:String = xml.@runtime;
         var compClass:Class = !!runtime?viewClassMap[runtime]:uiClassMap[xml.name()];
         return !!compClass?new compClass():null;
      }
      
      public static function registerComponent(key:String, compClass:Class) : void
      {
         uiClassMap[key] = compClass;
      }
      
      public static function registerViewRuntime(key:String, compClass:Class) : void
      {
         viewClassMap[key] = compClass;
      }
      
      protected function createView(uiView:Object) : void
      {
         createComp(uiView,this,this);
      }
      
      protected function loadUI(path:String) : void
      {
         var uiView:Object = uiMap[path];
         if(uiView)
         {
            createView(uiView);
         }
      }
      
      public function reCreate(comp:Component = null) : void
      {
         comp = comp || this;
         var dataSource:Object = comp.dataSource;
         if(comp is Box)
         {
            Box(comp).removeAllChild();
         }
         createComp(comp.comJSON || comp.comXml,comp,this);
         comp.dataSource = dataSource;
      }
      
      public function get enableEscKey() : Boolean
      {
         return _enableEscKey;
      }
      
      public function set enableEscKey(value:Boolean) : void
      {
         _enableEscKey = value;
         if(value)
         {
            addKeyEvent();
         }
      }
      
      public function get escKeyHandler() : Handler
      {
         return _escKeyHandler;
      }
      
      public function set escKeyHandler(value:Handler) : void
      {
         _escKeyHandler = value;
         if(value)
         {
            addKeyEvent();
         }
      }
      
      public function get enterKeyHandler() : Handler
      {
         return _enterKeyHandler;
      }
      
      public function set enterKeyHandler(value:Handler) : void
      {
         _enterKeyHandler = value;
         if(value)
         {
            addKeyEvent();
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         var len:int = numChildren;
         for(i = 0; i < len; )
         {
            ObjectUtils.disposeObject(getChildAt(0));
            i++;
         }
         this.removeEventListener("keyUp",keyHandler);
         StageReferance.stage.removeEventListener("keyUp",keyHandler);
         this.removeEventListener("mouseDown",onClick);
      }
      
      private function addKeyEvent() : void
      {
         if(this.hasEventListener("keyUp"))
         {
            return;
         }
         this.addEventListener("keyUp",keyHandler);
         StageReferance.stage.addEventListener("keyUp",keyHandler);
         this.addEventListener("mouseDown",onClick);
      }
      
      private function onClick(e:MouseEvent) : void
      {
         if(e.target is TextField)
         {
            return;
         }
         StageReferance.stage.focus = this;
      }
      
      private function keyHandler(e:KeyboardEvent) : void
      {
         if(e.keyCode == 27 && _enableEscKey)
         {
            e.stopImmediatePropagation();
            if(_escKeyHandler)
            {
               _escKeyHandler.execute();
            }
            else
            {
               ObjectUtils.disposeObject(this);
            }
         }
         if(e.keyCode == 13 && _enterKeyHandler)
         {
            e.stopImmediatePropagation();
            _enterKeyHandler.execute();
         }
      }
   }
}
