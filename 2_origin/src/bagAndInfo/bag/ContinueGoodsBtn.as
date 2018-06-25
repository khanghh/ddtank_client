package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.data.EquipType;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.view.goods.AddPricePanel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ContinueGoodsBtn extends TextButton implements IDragable
   {
       
      
      public var _isContinueGoods:Boolean;
      
      public function ContinueGoodsBtn()
      {
         super();
         _isContinueGoods = false;
         addEvt();
      }
      
      private function addEvt() : void
      {
         this.addEventListener("click",clickthis);
      }
      
      private function removeEvt() : void
      {
         this.removeEventListener("click",clickthis);
      }
      
      private function clickthis(e:MouseEvent) : void
      {
         var dragAsset:* = null;
         SoundManager.instance.play("008");
         if(_isContinueGoods == false)
         {
            _isContinueGoods = true;
            dragAsset = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.continueIconAsset");
            DragManager.startDrag(this,this,dragAsset,e.stageX,e.stageY,"move",false);
         }
         else
         {
            _isContinueGoods = false;
         }
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         var cell:* = null;
         if(_isContinueGoods && effect.target is BagCell)
         {
            cell = effect.target as BagCell;
            cell.locked = false;
            _isContinueGoods = false;
            if(ShopManager.Instance.canAddPrice(cell.itemInfo.TemplateID) && cell.itemInfo.getRemainDate() != 2147483647 && !EquipType.isProp(cell.itemInfo))
            {
               AddPricePanel.Instance.setInfo(cell.itemInfo,false);
               AddPricePanel.Instance.show();
               return;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.cantAddPrice"));
            return;
         }
         _isContinueGoods = false;
      }
      
      public function get isContinueGoods() : Boolean
      {
         return _isContinueGoods;
      }
   }
}
