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
      
      public function RewardSelectItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _mgr = DemonChiYouManager.instance;
         _buyConfirmAlertData = _mgr.rollConfirmAlertData;
         _model = _mgr.model;
         _itemData = _model.shopInfoArr[_index];
         _bagCell = new BagCell(1);
         _bagCell.BGVisible = false;
         _bagCell.setContentSize(60,60);
         var _loc1_:InventoryItemInfo = _itemData["InventoryItemInfo"];
         _bagCell.info = _loc1_;
         _bagCell.setCount(_loc1_.Count);
         PositionUtils.setPos(_bagCell,"demonChiYou.selectItemGoodPos");
         addChild(_bagCell);
         _selectItemNameTf = UICreatShortcut.creatTextAndAdd("demonChiYou.selectItemNameTf",_loc1_.Name,this);
         _selectItemRollCostTf = UICreatShortcut.creatTextAndAdd("demonChiYou.selectItemRollCostTf",_mgr.getRollCost() + LanguageMgr.GetTranslation("money"),this);
         _diceMC = UICreatShortcut.creatAndAdd("DemonChiYou.DiceMC",this);
         PositionUtils.setPos(_diceMC,"demonChiYou.selectItemDicePos");
         _diceMC.mouseChildren = false;
         _diceMC.stop();
         if(_itemData["MyPoint"] == -1)
         {
            _diceMC.buttonMode = true;
            _diceMC.addEventListener("click",onClickDiceMC);
         }
         else
         {
            _diceMC.mouseEnabled = false;
            _diceMC.gotoAndStop(17);
            _diceMC["rollTf2"].text = _itemData["MyPoint"] + LanguageMgr.GetTranslation("demonChiYou.point");
            _selectItemRollCostTf.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         _mgr.addEventListener("event_buy_roll_back",onRollBack);
      }
      
      private function removeEvent() : void
      {
         _diceMC.removeEventListener("click",onClickDiceMC);
         _diceMC.removeEventListener("enterFrame",onDiceFrame);
         _mgr.removeEventListener("event_buy_roll_back",onRollBack);
      }
      
      private function onRollBack(param1:CEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_.id == _itemData["ID"])
         {
            _resultPoint = _loc2_.roll;
            _diceMC.addEventListener("enterFrame",onDiceFrame);
            _diceMC.play();
            _selectItemRollCostTf.visible = false;
         }
         else
         {
            _selectItemRollCostTf.text = _mgr.getRollCost() + LanguageMgr.GetTranslation("money");
         }
      }
      
      private function onClickDiceMC(param1:MouseEvent) : void
      {
         evt = param1;
         onUsePropConfirm = function(param1:BaseAlerFrame):void
         {
            _buyConfirmAlertData.notShowAlertAgain = param1["isNoPrompt"];
         };
         onUsePropCheckOut = function():void
         {
            SocketManager.Instance.out.buyDemonChiYouRoll(_itemData["ID"]);
            _diceMC.mouseEnabled = false;
         };
         onUsePropCancel = function():void
         {
            _buyConfirmAlertData.notShowAlertAgain = false;
         };
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _buyConfirmAlertData.moneyNeeded = _mgr.getRollCost();
         if(_buyConfirmAlertData.notShowAlertAgain)
         {
            CheckMoneyUtils.instance.checkMoney(_buyConfirmAlertData.isBind,_buyConfirmAlertData.moneyNeeded,onUsePropCheckOut,onUsePropCancel);
         }
         else
         {
            var msg:String = LanguageMgr.GetTranslation("demonChiYou.buyRollMoneyAlertMsg",_buyConfirmAlertData.moneyNeeded);
            _confirmAlertHelper = HelperBuyAlert.getInstance().alert(msg,_buyConfirmAlertData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm,onUsePropCancel,0);
         }
      }
      
      private function onDiceFrame(param1:Event) : void
      {
         if(_diceMC.currentFrame == 13)
         {
            _diceMC.gotoAndStop(13);
            _diceMC["rollTf1"].text = _resultPoint + LanguageMgr.GetTranslation("demonChiYou.point");
            _diceMC.play();
         }
         else if(_diceMC.currentFrame == 17)
         {
            _diceMC.gotoAndStop(17);
            _diceMC["rollTf2"].text = _resultPoint + LanguageMgr.GetTranslation("demonChiYou.point");
            _diceMC.play();
         }
         else if(_diceMC.currentFrame == _diceMC.totalFrames)
         {
            _diceMC.stop();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _itemData = null;
         _mgr = null;
         _model = null;
         _bagCell = null;
         _selectItemNameTf = null;
         _selectItemRollCostTf = null;
         _diceMC.stop();
         _diceMC = null;
         _buyConfirmAlertData = null;
         _confirmAlertHelper && _confirmAlertHelper.frame.dispose();
         _confirmAlertHelper = null;
      }
   }
}
