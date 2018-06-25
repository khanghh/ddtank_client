package entertainmentMode.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.PropInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.view.PropItemView;   import flash.display.Bitmap;   import flash.events.MouseEvent;      public class EntertainmentInfoFrame extends BaseAlerFrame   {            public static const SUM_NUMBER:int = 20;                   private var _list:SimpleTileList;            private var _items:Vector.<PropItemView>;            private var _page:int = 1;            private var propList:Array;            public function EntertainmentInfoFrame() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _response(e:FrameEvent) : void { }
            public function hide() : void { }
            private function _nextClick(e:MouseEvent) : void { }
            private function _prevClick(e:MouseEvent) : void { }
            public function pageSum() : int { return 0; }
            override public function dispose() : void { }
   }}