package ddt.view.caddyII.offerPack
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class OfferComboBox extends ComboBox
   {
      
      public static const P_LISTITEM:String = "listItem";
       
      
      protected var _offerItemStyle:String;
      
      protected var _offerItem:OfferItem;
      
      public function OfferComboBox()
      {
         super();
      }
      
      public function set offerItemStyle(value:String) : void
      {
         if(_offerItemStyle == value)
         {
            return;
         }
         _offerItemStyle = value;
         _offerItem = ComponentFactory.Instance.creat(_offerItemStyle);
      }
      
      public function set offerItem(value:OfferItem) : void
      {
         if(_offerItem == value)
         {
            return;
         }
         _offerItem = value;
         onPropertiesChanged("textField");
      }
      
      public function get offerItem() : OfferItem
      {
         return _offerItem;
      }
      
      override protected function __onItemChanged(event:ListItemEvent) : void
      {
         _currentSelectedItem = event.cell;
         _currentSelectedCellValue = event.cellValue;
         _currentSelectedIndex = event.index;
         if(_selctedPropName != null)
         {
            _offerItem.info = event.cell[_selctedPropName];
         }
         dispatchEvent(new InteractiveEvent("stateChange"));
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_offerItem)
         {
            addChild(_offerItem);
         }
      }
      
      override public function dispose() : void
      {
         if(_offerItem)
         {
            ObjectUtils.disposeObject(_offerItem);
         }
         _offerItem = null;
         super.dispose();
      }
      
      override protected function __onStageClick(event:MouseEvent) : void
      {
         var target:DisplayObject = event.target as DisplayObject;
         if(!DisplayUtils.isTargetOrContain(target,this) && !DisplayUtils.isTargetOrContain(target,_listPanel))
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(target,_button) || DisplayUtils.isTargetOrContain(target,_listPanel.list) || DisplayUtils.isTargetOrContain(target,_offerItem))
         {
            if(_state == ComboBox.HIDE)
            {
               SoundManager.instance.play("008");
               doShow();
            }
            else
            {
               SoundManager.instance.play("008");
               doHide();
            }
         }
      }
   }
}
