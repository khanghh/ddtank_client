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
      
      private function __onOpenView(param1:CEvent) : void
      {
         new HelperDataModuleLoad().loadDataModule([LoaderCreate.Instance.createAvatarCollectionUnitDataLoader(),LoaderCreate.Instance.createHorsePicCherishDataLoader()],createFrame,[param1]);
      }
      
      private function createFrame(param1:CEvent) : void
      {
         var _loc2_:* = null;
         if(!_view)
         {
            _loc2_ = param1.data.parent as Sprite;
            _view = new AvatarCollectionMainView();
            _loc2_.addChild(_view);
            AvatarCollectionManager.instance.addEventListener("closeView",__onCloseView);
            AvatarCollectionManager.instance.addEventListener("visible",__onVisible);
            AvatarCollectionManager.instance.addEventListener("avatar_collection_select_all",__onSelectAll);
            AvatarCollectionManager.instance.addEventListener("reset_left",__onResetLeft);
         }
      }
      
      protected function __onResetLeft(param1:CEvent) : void
      {
         _view.reset();
      }
      
      protected function __onSelectAll(param1:CEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:int = _view.unitList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _view.unitList[_loc5_].list.list.cell;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc2_ in _loc4_)
            {
               _loc2_.select = param1.data;
            }
            _loc5_++;
         }
      }
      
      private function __onVisible(param1:CEvent) : void
      {
         if(_view)
         {
            _view.visible = param1.data.visible;
         }
      }
      
      private function __onCloseView(param1:CEvent) : void
      {
         AvatarCollectionManager.instance.removeEventListener("closeView",__onCloseView);
         AvatarCollectionManager.instance.removeEventListener("visible",__onVisible);
         ObjectUtils.disposeObject(_view);
         _view = null;
      }
   }
}
