package equipretrieve{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import equipretrieve.view.RetrieveBagFrame;   import equipretrieve.view.RetrieveBagView;   import equipretrieve.view.RetrieveBgView;   import flash.events.Event;   import flash.utils.Dictionary;      public class RetrieveFrame extends Frame   {                   private var _retrieveBgView:RetrieveBgView;            private var _retrieveBagView:RetrieveBagFrame;            private var _alertInfo:AlertInfo;            private var _BG:ScaleBitmapImage;            public function RetrieveFrame() { super(); }
            private function start() : void { }
            public function show() : void { }
            public function updateBag(dic:Dictionary) : void { }
            private function _updateStoreBag(e:BagEvent) : void { }
            public function cellDoubleClick(cell:BagCell) : void { }
            public function set bagType(i:int) : void { }
            public function set shine(boo:Boolean) : void { }
            override public function set visible(value:Boolean) : void { }
            public function clearItemCell() : void { }
            private function _response(e:FrameEvent) : void { }
            private function __onDoubleClick(e:Event) : void { }
            private function __onRetrieveType(e:Event) : void { }
            private function __onShine(e:Event) : void { }
            private function __onMouseEnable(e:Event) : void { }
            override public function dispose() : void { }
   }}