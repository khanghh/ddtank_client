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
      
      public function BeadAdvanceInfoCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null,null);}
      
      override public function dragStart() : void{}
      
      public function set actionState(param1:Boolean) : void{}
      
      public function get actionState() : Boolean{return false;}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dispose() : void{}
   }
}
