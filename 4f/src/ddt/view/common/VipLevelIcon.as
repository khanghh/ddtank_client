package ddt.view.common{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.BasePlayer;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import vip.VipController;      public class VipLevelIcon extends Sprite implements ITipedDisplay, Disposeable   {            public static const SIZE_BIG:int = 0;            public static const SIZE_SMALL:int = 1;            private static const LEVEL_ICON_CLASSPATH:String = "asset.vipIcon.vipLevel_";                   private var _seniorIcon:ScaleFrameImage;            private var _level:int = 1;            private var _type:int = 0;            private var _isVip:Boolean = false;            private var _vipExp:int = 0;            private var _tipDirctions:String;            private var _tipGapH:int;            private var _tipGapV:int;            private var _tipStyle:String;            private var _tipData:String;            private var _size:int;            public function VipLevelIcon() { super(); }
            public function setInfo(info:BasePlayer, isShowTip:Boolean = true, forVIPFrame:Boolean = false) : void { }
            private function __showVipFrame(e:MouseEvent) : void { }
            private function updateIcon() : void { }
            public function setSize(size:int) : void { }
            public function get tipStyle() : String { return null; }
            public function get tipData() : Object { return null; }
            public function get tipDirctions() : String { return null; }
            public function get tipGapV() : int { return 0; }
            public function get tipGapH() : int { return 0; }
            public function set tipStyle(value:String) : void { }
            public function set tipData(value:Object) : void { }
            public function set tipDirctions(value:String) : void { }
            public function set tipGapV(value:int) : void { }
            public function set tipGapH(value:int) : void { }
            public function get tipWidth() : int { return 0; }
            public function set tipWidth(w:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}