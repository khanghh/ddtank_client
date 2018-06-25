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
         var i:int = 0;
         var j:int = 0;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("times.MenuContainer");
         _menus = new Vector.<SelectedButton>(4);
         _infos = new Vector.<TimesPicInfo>(4);
         for(i = 0; i < _menus.length; )
         {
            _menus[i] = ComponentFactory.Instance.creatComponentByStylename("times.MenuButton_" + (String(i + 1)));
            _vBox.addChild(_menus[i]);
            _infos[i] = new TimesPicInfo();
            _infos[i].type = "category" + String(i);
            _infos[i].targetCategory = i;
            _infos[i].targetPage = 0;
            i++;
         }
         _btnGroup = new SelectedButtonGroup();
         for(j = 0; j < 4; )
         {
            _btnGroup.addSelectItem(_menus[j]);
            j++;
         }
         _btnGroup.selectIndex = 0;
         _btnGroup.addEventListener("change",__btnChangeHandler);
         addChild(_vBox);
      }
      
      public function set selected(index:int) : void
      {
         _btnGroup.selectIndex = index;
      }
      
      private function __btnChangeHandler(event:Event) : void
      {
         TimesController.Instance.dispatchEvent(new TimesEvent("playSound"));
         TimesController.Instance.dispatchEvent(new TimesEvent("gotoContent",_infos[_btnGroup.selectIndex]));
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         _btnGroup.removeEventListener("change",__btnChangeHandler);
         for(i = 0; i < _menus.length; )
         {
            _infos[i] = null;
            i++;
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
