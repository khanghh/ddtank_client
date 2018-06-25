package changeColor.view{   import baglocked.BaglockedManager;   import com.pickgliss.effect.EffectManager;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.ChangeColorModel;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Rectangle;      public class ChangeColorRightView extends Sprite implements Disposeable   {                   private var _bag:ColorChangeBagListView;            private var _bg:ScaleBitmapImage;            private var _bg1:MutipleImage;            private var _btnBg:ScaleBitmapImage;            private var _text1Img:FilterFrameText;            private var _textImg:FilterFrameText;            private var _shineEffect:IEffect;            private var _changeColorBtn:BaseButton;            private var _model:ChangeColorModel;            public function ChangeColorRightView() { super(); }
            public function dispose() : void { }
            public function set model(value:ChangeColorModel) : void { }
            private function __alertChangeColor(event:FrameEvent) : void { }
            private function __changeColor(evt:MouseEvent) : void { }
            private function __updateBtn(evt:Event) : void { }
            private function dataUpdate() : void { }
            private function hasColorCard() : int { return 0; }
            private function init() : void { }
            private function __addToStage(event:Event) : void { }
            private function sendChangeColor() : void { }
            public function get bag() : ColorChangeBagListView { return null; }
   }}