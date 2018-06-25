package explorerManual.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import explorerManual.ExplorerManualManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ManualRightMenu extends Sprite implements Disposeable
   {
      
      public static const ITEM_CLICK:String = "itemClick";
       
      
      private var _selectBtn:ManualMenuItem;
      
      private var _vbox:VBox;
      
      private var _items:Array;
      
      private var _btnGroups:SelectedButtonGroup;
      
      public function ManualRightMenu()
      {
         _items = [0,1001,1002,1003,1004,1005];
         super();
         _btnGroups = new SelectedButtonGroup();
         initView();
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualRightMenu.vBox");
         addChild(_vbox);
         initMenu();
      }
      
      private function __itemClickHandler(evt:MouseEvent) : void
      {
         var item:* = null;
         if(evt.target is ManualMenuItem)
         {
            item = evt.target as ManualMenuItem;
            this.dispatchEvent(new CEvent("itemClick",item.chapter));
            item.isHaveNewDebris = false;
            ExplorerManualManager.instance.removeNewDebris(item.chapter);
         }
      }
      
      private function initMenu() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualRightMenu.selBtn" + i);
            _selectBtn.chapter = _items[i];
            _selectBtn.isHaveNewDebris = ExplorerManualManager.instance.isHaveNewDebris(_items[i]);
            _selectBtn.addEventListener("click",__itemClickHandler);
            _vbox.addChild(_selectBtn);
            _btnGroups.addSelectItem(_selectBtn);
            i++;
         }
      }
      
      public function set selectItem(value:int) : void
      {
         _btnGroups.selectIndex = _items.indexOf(value);
      }
      
      public function dispose() : void
      {
         var item:* = null;
         var i:int = 0;
         if(_vbox)
         {
            for(i = 0; i < _vbox.numChildren; )
            {
               if(_vbox.getChildAt(i) is ManualMenuItem)
               {
                  item = _vbox.getChildAt(i) as ManualMenuItem;
                  item.removeEventListener("click",__itemClickHandler);
                  ObjectUtils.disposeObject(item);
               }
               i++;
            }
         }
         ObjectUtils.removeChildAllChildren(_vbox);
         _vbox = null;
         if(_btnGroups)
         {
            _btnGroups.dispose();
         }
         _btnGroups = null;
         _selectBtn = null;
      }
   }
}
