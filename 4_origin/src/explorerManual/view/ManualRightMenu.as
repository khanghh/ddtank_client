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
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(param1.target is ManualMenuItem)
         {
            _loc2_ = param1.target as ManualMenuItem;
            this.dispatchEvent(new CEvent("itemClick",_loc2_.chapter));
            _loc2_.isHaveNewDebris = false;
            ExplorerManualManager.instance.removeNewDebris(_loc2_.chapter);
         }
      }
      
      private function initMenu() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualRightMenu.selBtn" + _loc1_);
            _selectBtn.chapter = _items[_loc1_];
            _selectBtn.isHaveNewDebris = ExplorerManualManager.instance.isHaveNewDebris(_items[_loc1_]);
            _selectBtn.addEventListener("click",__itemClickHandler);
            _vbox.addChild(_selectBtn);
            _btnGroups.addSelectItem(_selectBtn);
            _loc1_++;
         }
      }
      
      public function set selectItem(param1:int) : void
      {
         _btnGroups.selectIndex = _items.indexOf(param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_vbox)
         {
            _loc2_ = 0;
            while(_loc2_ < _vbox.numChildren)
            {
               if(_vbox.getChildAt(_loc2_) is ManualMenuItem)
               {
                  _loc1_ = _vbox.getChildAt(_loc2_) as ManualMenuItem;
                  _loc1_.removeEventListener("click",__itemClickHandler);
                  ObjectUtils.disposeObject(_loc1_);
               }
               _loc2_++;
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
