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
      
      protected function __onListItemClick(event:ListItemEvent) : void
      {
         NewTitleControl.instance.dispatchEvent(new NewTitleEvent("titleItemClick",[event.index]));
      }
      
      public function updateOwnTitleList() : void
      {
         var i:int = 0;
         var j:int = 0;
         var titleArray:Array = EffortManager.Instance.getHonorArray();
         _list.vectorListModel.clear();
         for(i = 0; i < titleArray.length; )
         {
            _list.vectorListModel.append(titleArray[i].Name,i);
            i++;
         }
         _list.list.updateListView();
         for(j = 0; j < titleArray.length; )
         {
            if(PlayerManager.Instance.Self.honor == titleArray[j].Name)
            {
               _list.setViewPosition(j);
               _list.list.currentSelectedIndex = j;
               break;
            }
            j++;
         }
      }
      
      public function updateAllTitleList() : void
      {
         var i:int = 0;
         _list.vectorListModel.clear();
         var titleArray:Array = NewTitleManager.instance.titleArray;
         for(i = 0; i < titleArray.length; )
         {
            _list.vectorListModel.append(titleArray[i].Name,i);
            i++;
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
