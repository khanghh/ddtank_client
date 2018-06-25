package explorerManual.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import explorerManual.ExplorerManualManager;   import explorerManual.data.ExplorerManualInfo;   import flash.display.Sprite;   import flash.events.Event;      public class ManualLeftMenu extends Sprite implements Disposeable   {                   private var _activeIcon:ScaleFrameImage;            private var _activeProgess:FilterFrameText;            private var _unActiveIcon:ScaleFrameImage;            private var _unActiveProgress:FilterFrameText;            private var _model:ExplorerManualInfo;            public function ManualLeftMenu(model:ExplorerManualInfo) { super(); }
            private function initView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __modelUpdateHandler(evt:Event) : void { }
            public function dispose() : void { }
   }}