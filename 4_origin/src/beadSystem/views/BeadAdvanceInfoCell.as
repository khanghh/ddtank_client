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
      
      public function BeadAdvanceInfoCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,info,showLoading,mouseOverEffBoolean,!!bg?bg:ComponentFactory.Instance.creatBitmap("asset.beadSystem.advanceBead.beadCellImg"));
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
      
      public function set actionState(value:Boolean) : void
      {
         _actionState = value;
      }
      
      public function get actionState() : Boolean
      {
         return _actionState;
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         if(effect.action == "none")
         {
            locked = false;
         }
         if(effect.action == "none" && effect.target != null && effect.target is BeadAdvanceCell)
         {
            this.itemInfo = null;
            this.info = null;
         }
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var sourceInfo:* = null;
         var paramInfo:* = null;
         if(effect.source is BeadAdvanceInfoCell)
         {
            return;
         }
         sourceInfo = effect.data as InventoryItemInfo;
         if(sourceInfo && sourceInfo.IsUsed)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeFail.lockMsg"));
            return;
         }
         if(sourceInfo && effect.action != "split")
         {
            paramInfo = (this.parent as BeadAdvancedRightView).info;
            if(paramInfo && sourceInfo)
            {
               if(!paramInfo.verificationMaterials(sourceInfo.TemplateID,_place))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("beadSystem.beadAdvance.exchangeFailMsg"));
                  return;
               }
               _actionState = true;
               effect.action = "none";
               this.itemInfo = sourceInfo;
               this.info = sourceInfo;
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
