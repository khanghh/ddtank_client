package guardCore.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Experience;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   import guardCore.data.GuardCoreLevelInfo;
   
   public class GuardCoreView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _guardImg:Bitmap;
      
      private var _guardContainer:Sprite;
      
      private var _needGold:FilterFrameText;
      
      private var _needExp:FilterFrameText;
      
      private var _needGuard:FilterFrameText;
      
      private var _gold:FilterFrameText;
      
      private var _exp:FilterFrameText;
      
      private var _guard:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _itemList:Vector.<GuardCoreItem>;
      
      private var _itemContainer:Sprite;
      
      private var _btnHelp:BaseButton;
      
      private var _clickTime:int;
      
      public function GuardCoreView(){super();}
      
      override protected function init() : void{}
      
      private function initItem() : void{}
      
      private function updateView() : void{}
      
      private function countToString(param1:int) : String{return null;}
      
      private function updateGuardIcon() : void{}
      
      private function checkEquipGuardCore() : void{}
      
      private function updateItemTipsData() : void{}
      
      override protected function addChildren() : void{}
      
      private function __onClickUpgrade(param1:MouseEvent) : void{}
      
      private function isUpgrade() : Boolean{return false;}
      
      private function __onGuardChange(param1:PlayerPropertyEvent) : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      public function show() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
