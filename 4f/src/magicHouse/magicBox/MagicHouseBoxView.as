package magicHouse.magicBox{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;      public class MagicHouseBoxView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _extractionBtn:SelectedTextButton;            private var _fusionBtn:SelectedTextButton;            private var _btnGroup:SelectedButtonGroup;            private var _extractionView:MagicHouseExtraction;            private var _fusionView:MagicHouseFusionView;            public function MagicHouseBoxView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __changeHandler(e:Event) : void { }
            private function _createExtractionView() : void { }
            public function dispose() : void { }
   }}