package magpieBridge.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;   import magpieBridge.MagpieBridgeManager;   import magpieBridge.event.MagpieBridgeEvent;      public class MagpieView extends Sprite implements Disposeable   {                   private var _magpieVec:Vector.<Bitmap>;            private var _showMagpie:MovieClip;            private var _togetherMovie:MovieClip;            private var _playMeetFlag:Boolean;            private var _packs:ScaleFrameImage;            public function MagpieView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onPlayMeet(event:PkgEvent) : void { }
            public function showMagpie() : void { }
            private function setMagpieNum() : void { }
            private function hideTogetherMovie() : void { }
            private function resetMagpieState() : void { }
            public function getCurrentMagpiePos(transFlag:Boolean = false) : Point { return null; }
            public function dispose() : void { }
            private function removeEvent() : void { }
   }}