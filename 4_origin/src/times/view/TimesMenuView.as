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
      
      public function TimesMenuView()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("times.MenuContainer");
         _menus = new Vector.<SelectedButton>(4);
         _infos = new Vector.<TimesPicInfo>(4);
         _loc2_ = 0;
         while(_loc2_ < _menus.length)
         {
            _menus[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("times.MenuButton_" + (String(_loc2_ + 1)));
            _vBox.addChild(_menus[_loc2_]);
            _infos[_loc2_] = new TimesPicInfo();
            _infos[_loc2_].type = "category" + String(_loc2_);
            _infos[_loc2_].targetCategory = _loc2_;
            _infos[_loc2_].targetPage = 0;
            _loc2_++;
         }
         _btnGroup = new SelectedButtonGroup();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _btnGroup.addSelectItem(_menus[_loc1_]);
            _loc1_++;
         }
         _btnGroup.selectIndex = 0;
         _btnGroup.addEventListener("change",__btnChangeHandler);
         addChild(_vBox);
      }
      
      public function set selected(param1:int) : void
      {
         _btnGroup.selectIndex = param1;
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         TimesController.Instance.dispatchEvent(new TimesEvent("playSound"));
         TimesController.Instance.dispatchEvent(new TimesEvent("gotoContent",_infos[_btnGroup.selectIndex]));
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _btnGroup.removeEventListener("change",__btnChangeHandler);
         _loc1_ = 0;
         while(_loc1_ < _menus.length)
         {
            _infos[_loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _menus = null;
         _infos = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
