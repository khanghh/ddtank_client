package AvatarCollection
{
   import AvatarCollection.view.AvatarCollectionMainView;
   import AvatarCollection.view.AvatarCollectionUnitListCell;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.loader.LoaderCreate;
   import ddt.utils.HelperDataModuleLoad;
   import flash.display.Sprite;
   
   public class AvatarCollectionControl
   {
      
      private static var _instance:AvatarCollectionControl;
       
      
      private var _view:AvatarCollectionMainView;
      
      public function AvatarCollectionControl()
      {
         super();
      }
      
      public static function get instance() : AvatarCollectionControl
      {
         if(!_instance)
         {
            _instance = new AvatarCollectionControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         AvatarCollectionManager.instance.addEventListener("openview",__onOpenView);
      }
      
      private function __onOpenView(e:CEvent) : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createAvatarCollectionUnitDataLoader(),LoaderCreate.Instance.createHorsePicCherishDataLoader()],createFrame,[e]);
      }
      
      private function createFrame(e:CEvent) : void
      {
         var parent:* = null;
         if(!_view)
         {
            parent = e.data.parent as Sprite;
            _view = new AvatarCollectionMainView();
            parent.addChild(_view);
            AvatarCollectionManager.instance.addEventListener("closeView",__onCloseView);
            AvatarCollectionManager.instance.addEventListener("visible",__onVisible);
            AvatarCollectionManager.instance.addEventListener("avatar_collection_select_all",__onSelectAll);
            AvatarCollectionManager.instance.addEventListener("reset_left",__onResetLeft);
         }
      }
      
      protected function __onResetLeft(e:CEvent) : void
      {
         _view.reset();
      }
      
      protected function __onSelectAll(e:CEvent) : void
      {
         var i:int = 0;
         var cellList:* = undefined;
         var len:int = _view.unitList.length;
         for(i = 0; i < len; )
         {
            cellList = _view.unitList[i].list.list.cell;
            var _loc7_:int = 0;
            var _loc6_:* = cellList;
            for each(var value in cellList)
            {
               value.select = e.data;
            }
            i++;
         }
      }
      
      private function __onVisible(e:CEvent) : void
      {
         if(_view)
         {
            _view.visible = e.data.visible;
         }
      }
      
      private function __onCloseView(e:CEvent) : void
      {
         AvatarCollectionManager.instance.removeEventListener("closeView",__onCloseView);
         AvatarCollectionManager.instance.removeEventListener("visible",__onVisible);
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}
