package explorerManual.view.page{   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.core.Component;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import explorerManual.data.model.ManualPageItemInfo;   import flash.display.Bitmap;      public class ManualPreIconCell extends Component   {                   private var _loaderPic:DisplayLoader;            private var _info:ManualPageItemInfo;            public function ManualPreIconCell() { super(); }
            public function set pageInfo(info:ManualPageItemInfo) : void { }
            private function loadIcon() : void { }
            private function __picComplete(evt:LoaderEvent) : void { }
            private function clearLoader() : void { }
            override public function dispose() : void { }
   }}