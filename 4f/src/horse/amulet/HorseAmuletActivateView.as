package horse.amulet
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletActivateView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _haveDustText:FilterFrameText;
      
      private var _havaDustNumText:FilterFrameText;
      
      private var _dustText:FilterFrameText;
      
      private var _needDustText:FilterFrameText;
      
      private var _extendTypeText:FilterFrameText;
      
      private var _newExtendTypeText:FilterFrameText;
      
      private var _propertyText:FilterFrameText;
      
      private var _newPropertyText:FilterFrameText;
      
      private var _helpText:FilterFrameText;
      
      private var _activateBtn:SimpleBitmapButton;
      
      private var _hBox:HBox;
      
      private var _activateText:ScaleFrameImage;
      
      private var _property:Bitmap;
      
      private var _minCount:NumberImage;
      
      private var _about:Bitmap;
      
      private var _maxCount:NumberImage;
      
      private var _activateCell:HorseAmuletActivateCell;
      
      private var _resultIcon:ScaleFrameImage;
      
      private var _currentTime:Number;
      
      public function HorseAmuletActivateView(){super();}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function __onChangeCell(param1:Event = null) : void{}
      
      private function __onUpdateActivate(param1:PkgEvent) : void{}
      
      private function __onReplaceComplete(param1:PkgEvent) : void{}
      
      private function __onSmashComplete(param1:PkgEvent) : void{}
      
      private function __onClickActivate(param1:MouseEvent) : void{}
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void{}
      
      private function __onAlertFrame(param1:FrameEvent) : void{}
      
      private function __onClickReplace(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
