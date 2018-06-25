package flowerGiving.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flowerGiving.FlowerGivingManager;   import wonderfulActivity.data.GmActivityInfo;      public class FlowerMainView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _bottomBg:ScaleBitmapImage;            private var _desc:FilterFrameText;            private var _givingBtn:SimpleBitmapButton;            private var _frame:Frame;            public function FlowerMainView() { super(); }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __clickHandler(event:MouseEvent) : void { }
            public function setActDate() : void { }
            private function dateTrim(dateStr:String, flag:Boolean = false) : String { return null; }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}