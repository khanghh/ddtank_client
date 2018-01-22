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
      
      public function AvatarCollectionControl(){super();}
      
      public static function get instance() : AvatarCollectionControl{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:CEvent) : void{}
      
      private function createFrame(param1:CEvent) : void{}
      
      protected function __onResetLeft(param1:CEvent) : void{}
      
      protected function __onSelectAll(param1:CEvent) : void{}
      
      private function __onVisible(param1:CEvent) : void{}
      
      private function __onCloseView(param1:CEvent) : void{}
   }
}
