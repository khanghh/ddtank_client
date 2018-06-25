package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SelectStateButton extends Sprite implements Disposeable
   {
       
      
      private var _bg:DisplayObject;
      
      private var _overBg:DisplayObject;
      
      private var _gray:Boolean;
      
      private var _enable:Boolean;
      
      private var _selected:Boolean;
      
      public function SelectStateButton()
      {
         super();
         initEvents();
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHander);
         addEventListener("click",__clickHander);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHander);
         removeEventListener("click",__clickHander);
      }
      
      private function __outHander(event:MouseEvent) : void
      {
         if(enable)
         {
            _bg.visible = !selected;
            _overBg.visible = selected;
         }
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         if(enable)
         {
            _bg.visible = false;
            _overBg.visible = true;
         }
      }
      
      private function __clickHander(event:MouseEvent) : void
      {
         if(!_enable)
         {
            event.stopImmediatePropagation();
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         _selected = value;
         _bg.visible = !_selected;
         _overBg.visible = _selected;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(value:Boolean) : void
      {
         _enable = value;
      }
      
      public function get gray() : Boolean
      {
         return _gray;
      }
      
      public function set gray(value:Boolean) : void
      {
         _gray = value;
         if(_gray)
         {
            filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            filters = null;
         }
      }
      
      public function set backGround(value:DisplayObject) : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _bg = value;
         if(_bg)
         {
            addChild(_bg);
         }
      }
      
      public function set overBackGround(value:DisplayObject) : void
      {
         if(_overBg)
         {
            ObjectUtils.disposeObject(_overBg);
            _overBg = null;
         }
         _overBg = value;
         if(_overBg)
         {
            addChild(_overBg);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
