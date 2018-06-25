package store.fineStore.view.pageBringUp
{
   import bagAndInfo.cell.LockableBagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpCell extends LockableBagCell
   {
       
      
      private var _observer:IObserver;
      
      private var _text:FilterFrameText;
      
      private var _latentEnergyItemId:int;
      
      private var _lastLevel:int;
      
      public function FineBringUpCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         var shap:Shape = new Shape();
         shap.graphics.beginFill(0,0);
         shap.graphics.drawRect(0,0,65,65);
         shap.graphics.endFill();
         var bmp:Bitmap = new Bitmap(new BitmapData(65,65));
         bmp.bitmapData.draw(shap);
         bg = bmp;
         bg.alpha = 0;
         super(index,info,showLoading,bg,mouseOverEffBoolean);
         _text = ComponentFactory.Instance.creatComponentByStylename("ddtbagAndInfo.reworkname.Text1");
         _text.x = 13;
         _text.y = 21;
         _text.text = LanguageMgr.GetTranslation("FineBringUpCell.textCell");
         addChild(_text);
         lockDisplayObject = ComponentFactory.Instance.creatBitmap("asset.store.bringup.lock");
         PositionUtils.setPos(lockDisplayObject,"storeBringUp.leftCellLockPos");
         mouseOverEffBoolean = false;
      }
      
      public function get lastLevel() : int
      {
         return _lastLevel;
      }
      
      public function set latentEnergyItemId(value:int) : void
      {
         _latentEnergyItemId = value;
         if(_tipData && _tipData is GoodTipInfo)
         {
            (_tipData as GoodTipInfo).latentEnergyItemId = _latentEnergyItemId;
         }
      }
      
      override public function get tipStyle() : String
      {
         FineBringUpUpgradeTip;
         return "store.fineStore.view.pageBringUp.FineBringUpUpgradeTip";
      }
      
      public function register(ob:IObserver) : void
      {
         _observer = ob;
      }
      
      override protected function addEnchantMc() : void
      {
         super.addEnchantMc();
         var _loc1_:* = 1.48;
         _enchantMc.scaleY = _loc1_;
         _enchantMc.scaleX = _loc1_;
         _enchantMc.x = -1;
         _enchantMc.y = -1;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         value && int(value.Property1);
         if(_tipData && _tipData is GoodTipInfo)
         {
            (_tipData as GoodTipInfo).latentEnergyItemId = _latentEnergyItemId;
         }
         if(value != null)
         {
            FineBringUpController.getInstance().showNewHandTip();
         }
         else
         {
            FineBringUpController.getInstance().hideNewHandTip();
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move",equipMoveHandler);
         FineBringUpController.getInstance().addEventListener("latentEnergy_equip_move2",equipMoveHandler2);
      }
      
      private function equipMoveHandler(event:LatentEnergyEvent) : void
      {
         var event2:* = null;
         if(info == event.info)
         {
            return;
         }
         if(info)
         {
            event2 = new LatentEnergyEvent("latentEnergy_equip_move2");
            event2.info = info as InventoryItemInfo;
            event2.moveType = 3;
            FineBringUpController.getInstance().dispatchEvent(event2);
         }
         info = event.info;
      }
      
      private function equipMoveHandler2(event:LatentEnergyEvent) : void
      {
         if(info != event.info || event.moveType != 2)
         {
            return;
         }
         SocketManager.Instance.out.sendMoveGoods(12,0,0,0);
         info = null;
      }
      
      protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!info)
         {
            return;
         }
         SoundManager.instance.play("008");
         var event:LatentEnergyEvent = new LatentEnergyEvent("latentEnergy_equip_move2");
         event.info = info as InventoryItemInfo;
         event.moveType = 2;
         FineBringUpController.getInstance().dispatchEvent(event);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         FineBringUpController.getInstance().removeEventListener("latentEnergy_equip_move",equipMoveHandler);
         FineBringUpController.getInstance().removeEventListener("latentEnergy_equip_move2",equipMoveHandler2);
      }
      
      protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if(FineBringUpView.isEatStatus)
         {
            FineBringUpView.isEatStatus = false;
         }
         else
         {
            SoundManager.instance.play("008");
            dragStart();
         }
      }
      
      public function clearInfo() : void
      {
         var event:* = null;
         if(info)
         {
            event = new LatentEnergyEvent("latentEnergy_equip_move2");
            event.info = info as InventoryItemInfo;
            event.moveType = 2;
            FineBringUpController.getInstance().dispatchEvent(event);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _observer = null;
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_text != null)
         {
            ObjectUtils.disposeObject(_text);
            _text = null;
         }
      }
   }
}
