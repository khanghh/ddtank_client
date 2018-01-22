package newTitle.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.EffortManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import newTitle.NewTitleControl;
   import newTitle.NewTitleManager;
   import newTitle.event.NewTitleEvent;
   
   public class NewTitleListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      public function NewTitleListView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __onListItemClick(param1:ListItemEvent) : void{}
      
      public function updateOwnTitleList() : void{}
      
      public function updateAllTitleList() : void{}
      
      public function dispose() : void{}
   }
}
