package collectionTask.view{   import collectionTask.model.CollectionTaskModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CollectionTaskMenuView extends Sprite implements Disposeable   {                   private var _menuShowName:ScaleFrameImage;            private var _menuShowPao:ScaleFrameImage;            private var _menuShowPlayer:ScaleFrameImage;            private var _model:CollectionTaskModel;            public function CollectionTaskMenuView(model:CollectionTaskModel) { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function onMenuClick(evt:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}