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
      
      private function clickthis(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_isContinueGoods == false)
         {
            _isContinueGoods = true;
            _loc2_ = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.continueIconAsset");
            DragManager.startDrag(this,this,_loc2_,param1.stageX,param1.stageY,"move",false);
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
      
      public function dragStop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(_isContinueGoods && param1.target is BagCell)
         {
            _loc2_ = param1.target as BagCell;
            _loc2_.locked = false;
            _isContinueGoods = false;
            if(ShopManager.Instance.canAddPrice(_loc2_.itemInfo.TemplateID) && _loc2_.itemInfo.getRemainDate() != 2147483647 && !EquipType.isProp(_loc2_.itemInfo))
            {
               AddPricePanel.Instance.setInfo(_loc2_.itemInfo,false);
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
