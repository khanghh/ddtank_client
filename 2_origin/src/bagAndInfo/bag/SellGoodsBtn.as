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
      
      public function dragStart(stageX:Number, stageY:Number) : void
      {
         isActive = true;
         var dragAsset:Bitmap = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.sellIconAsset");
         DragManager.startDrag(this,this,dragAsset,stageX,stageY,"move",false);
      }
      
      public function dragStop(effect:DragEffect) : void
      {
         var cell:* = null;
         isActive = false;
         if(PlayerManager.Instance.Self.bagLocked && effect.target is ICell)
         {
            BaglockedManager.Instance.show();
            isActive = true;
            if(effect.target is BagCell)
            {
               (effect.target as BagCell).locked = false;
               (effect.target as BagCell).allowDrag = true;
               dispatchEvent(new Event("stopsell"));
               isActive = false;
            }
            return;
         }
         if(effect.action == "move" && effect.target is ICell)
         {
            cell = effect.target as BagCell;
            if(cell && cell.info)
            {
               if(EquipType.isValuableEquip(cell.info))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.SellGoodsBtn.CantSellEquip1"));
                  cell.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else if(EquipType.isPetSpeciallFood(cell.info))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
                  cell.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else if(cell.info.CategoryID == 34)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.bagAndInfo.sell.CanNotSell"));
                  cell.locked = false;
                  dispatchEvent(new Event("stopsell"));
               }
               else
               {
                  _dragTarget = cell;
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
      
      private function confirmBack(event:Event) : void
      {
         if(stage)
         {
            dragStart(stage.mouseX,stage.mouseY);
         }
         __disposeSellFrame();
      }
      
      private function setUpLintingFilter() : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([1,0,0,0,25]);
         matrix = matrix.concat([0,1,0,0,25]);
         matrix = matrix.concat([0,0,1,0,25]);
         matrix = matrix.concat([0,0,0,1,0]);
         lightingFilter = new ColorMatrixFilter(matrix);
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
      
      private function cancelBack(event:Event) : void
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
