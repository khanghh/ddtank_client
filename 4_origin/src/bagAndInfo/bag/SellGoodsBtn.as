package bagAndInfo.bag
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import ddt.data.EquipType;
   import ddt.interfaces.ICell;
   import ddt.interfaces.IDragable;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   
   public class SellGoodsBtn extends TextButton implements IDragable
   {
      
      public static const StopSell:String = "stopsell";
       
      
      public var isActive:Boolean = false;
      
      private var sellFrame:SellGoodsFrame;
      
      private var lightingFilter:ColorMatrixFilter;
      
      private var _dragTarget:BagCell;
      
      public function SellGoodsBtn()
      {
         super();
         init();
      }
      
      override protected function init() : void
      {
         buttonMode = true;
         super.init();
      }
      
      public function dragStart(param1:Number, param2:Number) : void
      {
         isActive = true;
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.sellIconAsset");
         DragManager.startDrag(this,this,_loc3_,param1,param2,"move",false);
      }
      
      public function dragStop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         isActive = false;
         if(PlayerManager.Instance.Self.bagLocked && param1.target is ICell)
         {
            BaglockedManager.Instance.show();
            isActive = true;
            if(param1.target is BagCell)
            {
               (param1.target as BagCell).locked = false;
               (param1.target as BagCell).allowDrag = true;
               dispatchEvent(new Event("stopsell"));
               isActive = false;
            }
            return;
         }
         if(param1.action == "move" && param1.target is ICell)
         {
            _loc2_ = param1.target as BagCell;
            if(_loc2_ && _loc2_.info)
            {
               if(EquipType.isValuableEquip(_loc2_.info))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.CantSellEquip1"));
                  _loc2_.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else if(EquipType.isPetSpeciallFood(_loc2_.info))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
                  _loc2_.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else if(_loc2_.info.CategoryID == 34)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
                  _loc2_.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else
               {
                  _dragTarget = _loc2_;
                  showSellFrame();
               }
            }
            else
            {
               dispatchEvent(new Event("stopsell"));
            }
         }
         else
         {
            dispatchEvent(new Event("stopsell"));
         }
      }
      
      private function showSellFrame() : void
      {
         SoundManager.instance.play("008");
         if(sellFrame == null)
         {
            sellFrame = ComponentFactory.Instance.creatComponentByStylename("sellGoodsFrame");
            sellFrame.itemInfo = _dragTarget.itemInfo;
            sellFrame.addEventListener("cancel",cancelBack);
            sellFrame.addEventListener("ok",confirmBack);
         }
         LayerManager.Instance.addToLayer(sellFrame,2,true,1);
      }
      
      public function getSource() : IDragable
      {
         return this;
      }
      
      public function getDragData() : Object
      {
         return this;
      }
      
      private function confirmBack(param1:Event) : void
      {
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
         __disposeSellFrame();
      }
      
      private function setUpLintingFilter() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([1,0,0,0,25]);
         _loc1_ = _loc1_.concat([0,1,0,0,25]);
         _loc1_ = _loc1_.concat([0,0,1,0,25]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(_loc1_);
      }
      
      override public function dispose() : void
      {
         if(_dragTarget)
         {
            _dragTarget.locked = false;
         }
         PlayerManager.Instance.Self.Bag.unLockAll();
         __disposeSellFrame();
         super.dispose();
      }
      
      private function __disposeSellFrame() : void
      {
         if(sellFrame)
         {
            sellFrame.removeEventListener("cancel",cancelBack);
            sellFrame.removeEventListener("ok",confirmBack);
            sellFrame.dispose();
         }
         sellFrame = null;
      }
      
      private function cancelBack(param1:Event) : void
      {
         if(_dragTarget)
         {
            _dragTarget.locked = false;
         }
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
         __disposeSellFrame();
      }
   }
}
