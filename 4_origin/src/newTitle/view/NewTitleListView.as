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
      
      public function NewTitleListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("newTitle.list");
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _list.list.addEventListener("listItemClick",__onListItemClick);
      }
      
      protected function __onListItemClick(param1:ListItemEvent) : void
      {
         NewTitleControl.instance.dispatchEvent(new NewTitleEvent("titleItemClick",[param1.index]));
      }
      
      public function updateOwnTitleList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = EffortManager.Instance.getHonorArray();
         _list.vectorListModel.clear();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _list.vectorListModel.append(_loc2_[_loc3_].Name,_loc3_);
            _loc3_++;
         }
         _list.list.updateListView();
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(PlayerManager.Instance.Self.honor == _loc2_[_loc1_].Name)
            {
               _list.setViewPosition(_loc1_);
               _list.list.currentSelectedIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
      }
      
      public function updateAllTitleList() : void
      {
         var _loc2_:int = 0;
         _list.vectorListModel.clear();
         var _loc1_:Array = NewTitleManager.instance.titleArray;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _list.vectorListModel.append(_loc1_[_loc2_].Name,_loc2_);
            _loc2_++;
         }
         _list.list.updateListView();
         _list.list.currentSelectedIndex = 0;
      }
      
      public function dispose() : void
      {
         if(_list)
         {
            _list.removeEventListener("listItemClick",__onListItemClick);
            ObjectUtils.disposeObject(_list);
            _list = null;
         }
      }
   }
}
