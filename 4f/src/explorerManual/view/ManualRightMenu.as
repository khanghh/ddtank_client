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
      
      public function ManualRightMenu(){super();}
      
      private function initView() : void{}
      
      private function __itemClickHandler(param1:MouseEvent) : void{}
      
      private function initMenu() : void{}
      
      public function set selectItem(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
