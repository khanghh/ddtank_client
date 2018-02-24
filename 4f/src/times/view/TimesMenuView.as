package times.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesMenuView extends Sprite implements Disposeable
   {
       
      
      protected var _vBox:VBox;
      
      protected var _btnGroup:SelectedButtonGroup;
      
      protected var _menus:Vector.<SelectedButton>;
      
      protected var _infos:Vector.<TimesPicInfo>;
      
      public function TimesMenuView(){super();}
      
      protected function init() : void{}
      
      public function set selected(param1:int) : void{}
      
      private function __btnChangeHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
