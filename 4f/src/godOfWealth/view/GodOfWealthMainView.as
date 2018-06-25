package godOfWealth.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.Helpers;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Rectangle;   import godOfWealth.GodOfWealthManager;   import homeTemple.view.N_BitmapDataNumber;   import org.aswing.KeyboardManager;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class GodOfWealthMainView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _closeBtn:SimpleBitmapButton;            private var _btnPay:Scale9CornerImage;            private var _detailTxt:FilterFrameText;            private var _endTimeTxt:FilterFrameText;            private var _endTime:Number;            private var _timer:TimerJuggler;            private var _numRes:N_BitmapDataNumber;            private var _numTxtBitmap:Bitmap;            private var _numTitleBitmap:Bitmap;            public var id:int;            public function GodOfWealthMainView() { super(); }
            protected function init() : void { }
            protected function onEndTimeTimer(e:Event) : void { }
            protected function onDown(e:MouseEvent) : void { }
            protected function onOver(e:MouseEvent) : void { }
            protected function onOut(e:MouseEvent) : void { }
            protected function onPayClick(e:MouseEvent) : void { }
            protected function onResponse(e:FrameEvent) : void { }
            private function onCanceled() : void { }
            private function onChecked() : void { }
            protected function onKeyDown(e:KeyboardEvent) : void { }
            protected function onCloseClick(e:MouseEvent) : void { }
            public function update() : void { }
            public function dispose() : void { }
   }}