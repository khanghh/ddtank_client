package wantstrong.view
{
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import wantstrong.WantStrongControl;
   import wantstrong.WantStrongManager;
   import wantstrong.model.WantStrongModel;
   
   public class WantStrongMenu extends Sprite implements Disposeable
   {
       
      
      private var _menuArr:Array;
      
      private var _titleArr:Array;
      
      private var _selectItem:WantStrongCell;
      
      private var _cellArr:Array;
      
      private var _model:WantStrongModel;
      
      public function WantStrongMenu(param1:WantStrongModel){super();}
      
      private function cellChangeHandler(param1:Event) : void{}
      
      private function createUI() : void{}
      
      protected function _cellClickedHandle(param1:MouseEvent) : void{}
      
      private function setSelectItem(param1:WantStrongCell) : void{}
      
      public function dispose() : void{}
   }
}
