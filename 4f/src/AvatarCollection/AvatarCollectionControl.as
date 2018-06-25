package AvatarCollection{   import AvatarCollection.view.AvatarCollectionMainView;   import AvatarCollection.view.AvatarCollectionUnitListCell;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CEvent;   import ddt.loader.LoaderCreate;   import ddt.utils.HelperDataModuleLoad;   import flash.display.Sprite;      public class AvatarCollectionControl   {            private static var _instance:AvatarCollectionControl;                   private var _view:AvatarCollectionMainView;            public function AvatarCollectionControl() { super(); }
            public static function get instance() : AvatarCollectionControl { return null; }
            public function setup() : void { }
            private function __onOpenView(e:CEvent) : void { }
            private function createFrame(e:CEvent) : void { }
            protected function __onResetLeft(e:CEvent) : void { }
            protected function __onSelectAll(e:CEvent) : void { }
            private function __onVisible(e:CEvent) : void { }
            private function __onCloseView(e:CEvent) : void { }
   }}