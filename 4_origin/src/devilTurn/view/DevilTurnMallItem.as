package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnPointShopItem;
   import devilTurn.view.mornui.DevilTurnMallItemUI;
   import morn.core.handlers.Handler;
   
   public class DevilTurnMallItem extends DevilTurnMallItemUI
   {
       
      
      private var _info:DevilTurnPointShopItem;
      
      private var _giftCell:BagCell;
      
      private var _lotteryCount:int;
      
      public function DevilTurnMallItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _lotteryCount = DevilTurnManager.instance.model.lotteryCount;
         _giftCell = new BagCell(0,null,false,ComponentFactory.Instance.creatBitmap("asset.deviturn.mall.itemCellBg"));
         addChild(_giftCell);
         PositionUtils.setPos(_giftCell,"devilTurn.mallitem.cellPos");
         getBtn.clickHandler = new Handler(onClickGetGift);
         DevilTurnManager.instance.addEventListener("updateinfo",__onUpdateInfo);
      }
      
      private function onClickGetGift() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         if(_info == null)
         {
            return;
         }
         if(_lotteryCount < _info.Points)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.notMallGetGift"));
            return;
         }
         SocketManager.Instance.out.sendDevilTurnScoreConversion(_info.ID);
      }
      
      public function set info(value:DevilTurnPointShopItem) : void
      {
         _info = value;
         if(_info)
         {
            updateView();
         }
         else
         {
            countText.text = "";
            _giftCell.info = null;
         }
      }
      
      private function updateView() : void
      {
         var isGetGift:Boolean = false;
         if(_info)
         {
            isGetGift = DevilTurnManager.instance.model.getGiftIsGetByID(_info.ID);
            getBtn.visible = !isGetGift;
            getBtn.disabled = _lotteryCount < _info.Points;
            getImage.visible = isGetGift;
            countText.text = _info.Points.toString();
            _giftCell.info = ItemManager.Instance.getTemplateById(_info.TemplateID);
         }
      }
      
      private function __onUpdateInfo(e:DevilTurnEvent) : void
      {
         _lotteryCount = DevilTurnManager.instance.model.lotteryCount;
         updateView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_giftCell);
         _giftCell = null;
         _info = null;
         DevilTurnManager.instance.removeEventListener("updateinfo",__onUpdateInfo);
         super.dispose();
      }
   }
}
