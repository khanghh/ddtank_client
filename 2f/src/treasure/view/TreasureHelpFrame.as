package treasure.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleUpDownImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class TreasureHelpFrame extends Sprite implements Disposeable   {                   private var _panel:ScrollPanel;            private var _contents:MovieClip;            private var _bg:ScaleUpDownImage;            private var _box:Sprite;            private var _btn:SelectedTextButton;            private var _mask:Sprite;            private var flag:Boolean;            private var frameHead:Bitmap;            public function TreasureHelpFrame() { super(); }
            private function init() : void { }
            private function initListener() : void { }
            private function _btnClickHandler(e:MouseEvent) : void { }
            private function outhandler() : void { }
            private function removeListener() : void { }
            public function dispose() : void { }
   }}