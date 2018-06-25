package store.view.fusion{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.utils.ObjectUtils;   import ddt.bagStore.BagStore;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.MouseEvent;   import store.data.PreviewInfoII;      public class PreviewFrameII extends Frame   {                   private var _list:VBox;            private var _okBtn:TextButton;            public function PreviewFrameII() { super(); }
            private function initII() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _okClick(e:MouseEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            public function set items($list:Array) : void { }
            public function clearList() : void { }
            public function show() : void { }
            public function hide() : void { }
            override public function dispose() : void { }
            private function removeFromStageHandler(event:Event) : void { }
   }}