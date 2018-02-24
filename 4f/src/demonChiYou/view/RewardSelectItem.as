package demonChiYou.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.ConfirmAlertHelper;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RewardSelectItem extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _itemData:Object;
      
      private var _mgr:DemonChiYouManager;
      
      private var _model:DemonChiYouModel;
      
      private var _bagCell:BagCell;
      
      private var _selectItemNameTf:FilterFrameText;
      
      private var _selectItemRollCostTf:FilterFrameText;
      
      private var _diceMC:MovieClip;
      
      private var _buyConfirmAlertData:ConfirmAlertData;
      
      private var _resultPoint:int;
      
      private var _confirmAlertHelper:ConfirmAlertHelper;
      
      public function RewardSelectItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onRollBack(param1:CEvent) : void{}
      
      private function onClickDiceMC(param1:MouseEvent) : void{}
      
      private function onDiceFrame(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
