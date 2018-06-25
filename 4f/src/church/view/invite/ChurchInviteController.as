package church.view.invite{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import consortion.ConsortionModelManager;   import ddt.manager.PlayerManager;   import flash.display.Sprite;      public class ChurchInviteController   {                   private var _view:ChurchInviteView;            private var _model:ChurchInviteModel;            public function ChurchInviteController() { super(); }
            private function init() : void { }
            public function getView() : Sprite { return null; }
            public function refleshList(type:int, count:int = 0) : void { }
            private function isOnline(item:*) : Boolean { return false; }
            private function setList(type:int, data:Array) : void { }
            public function hide() : void { }
            public function showView() : void { }
            public function dispose() : void { }
   }}