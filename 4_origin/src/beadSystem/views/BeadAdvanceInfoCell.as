package beadSystem.views
{
   import bagAndInfo.cell.DragEffect;
   import beadSystem.controls.BeadAdvanceCell;
   import beadSystem.controls.BeadCell;
   import beadSystem.model.AdvanceBeadInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   
   public class BeadAdvanceInfoCell extends BeadCell
   {
       
      
      protected var _actionState:Boolean;
      
      private var _typeDesc:FilterFrameText;
      
      public function BeadAdvanceInfoCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,param2,param3,param5,!!param4?param4:ComponentFactory.Instance.creatBitmap("asset.beadSystem.advanceBead.beadCellImg"));
         setContentSize(68,68);
         _typeDesc = ComponentFactory.Instance.creatComponentByStylename("beadSystem.advanceBeadCell.descTxt");
         _typeDesc.text = LanguageMgr.GetTranslation("beadSystem.beadAdvance.fullLevBead");
         addChild(_typeDesc);
      }
      
      override public function dragStart() : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            if(DragManager.startDrag(this,_info,createDragImg(),stage.mouseX,stage.mouseY,"move"))
            {
               SoundManager.instance.play("008");
            }
         }
      }
      
      public function set actionState(param1:Boolean) : void
      {
         _actionState = param1;
      }
      
      public function get actionState() : Boolean
      {
         return _actionState;
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         if(param1.action == "none")
         {
            locked = false;
         }
         if(param1.action == "none" && param1.target != null && param1.target is BeadAdvanceCell)
         {
            this.itemInfo = null;
            this.info = null;
         }
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.source is BeadAdvanceInfoCell)
         {
            return;
         }
         _loc3_ = param1.data as InventoryItemInfo;
         if(_loc3_ && _loc3_.IsUsed)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeFail.lockMsg"));
            return;
         }
         if(_loc3_ && param1.action != "split")
         {
            _loc2_ = (this.parent as BeadAdvancedRightView).info;
            if(_loc2_ && _loc3_)
            {
               if(!_loc2_.verificationMaterials(_loc3_.TemplateID,_place))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeFailMsg"));
                  return;
               }
               _actionState = true;
               param1.action = "none";
               this.itemInfo = _loc3_;
               this.info = _loc3_;
               DragManager.acceptDrag(this);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeFail.noPlaceMsg"));
         }
      }
      
      override public function dispose() : void
      {
         if(_typeDesc)
         {
            ObjectUtils.disposeObject(_typeDesc);
         }
         _typeDesc = null;
         super.dispose();
      }
   }
}
