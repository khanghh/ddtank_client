package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import bagAndInfo.amulet.vo.EquipAmuletVo;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class EquipAmuletActivateView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _gradeTips:Component;
      
      private var _phaseTips:Component;
      
      private var _phaseText:FilterFrameText;
      
      private var _phaseTipText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _gradeTipText:FilterFrameText;
      
      private var _powerText:FilterFrameText;
      
      private var _power:int;
      
      private var _powerArrow:ScaleFrameImage;
      
      private var _currentEffect:Vector.<EquipAmuletActivateItem>;
      
      private var _newEffect:Vector.<EquipAmuletActivateItem>;
      
      private var _getStiveBtn:SimpleBitmapButton;
      
      private var _consumeStiveText:FilterFrameText;
      
      private var _consumeMoneyText:FilterFrameText;
      
      private var _activateBtn:SimpleBitmapButton;
      
      private var _replaceBtn:SimpleBitmapButton;
      
      private var _info:InventoryItemInfo;
      
      private var _currentTime:Number;
      
      private var _moneyText:FilterFrameText;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _moneyIcon:Bitmap;
      
      private var _bindMoneyText:FilterFrameText;
      
      private var _bindMoneyBg:ScaleBitmapImage;
      
      private var _bindMoneyIcon:Bitmap;
      
      private var _activateProperty:Array;
      
      public function EquipAmuletActivateView(){super();}
      
      private function init() : void{}
      
      private function __onItemChange(param1:Event) : void{}
      
      private function __onClickGetStive(param1:MouseEvent) : void{}
      
      private function __onClickActivate(param1:MouseEvent) : void{}
      
      private function __onAlertActivate(param1:FrameEvent) : void{}
      
      private function __onAlertNotStiveFrame(param1:FrameEvent) : void{}
      
      private function buyStive() : void{}
      
      private function __onAlertBuyStiveFrame(param1:FrameEvent) : void{}
      
      private function get buyStiveCoin() : int{return 0;}
      
      private function __onReplace(param1:MouseEvent) : void{}
      
      private function __onAlertPowerFrame(param1:FrameEvent) : void{}
      
      private function __onActivateComplete(param1:PkgEvent) : void{}
      
      private function __onReplaceComplete(param1:PkgEvent) : void{}
      
      private function updateProperty() : void{}
      
      public function update() : void{}
      
      public function updateMoney() : void{}
      
      private function __onBuyStiveComplete(param1:PkgEvent) : void{}
      
      private function get lockProperty() : Array{return null;}
      
      public function get isActivate() : Boolean{return false;}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
