package ddt.view.bossbox
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BoxAwardsCell extends BaseCell implements IListCell
   {
       
      
      protected var _itemName:FilterFrameText;
      
      protected var count_txt:FilterFrameText;
      
      private var di:ScaleBitmapImage;
      
      public function BoxAwardsCell()
      {
         super(ComponentFactory.Instance.creat("asset.awardSystem.roulette.SelectCellBGAsset"));
         initII();
         addEvent();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         _picPos = new Point(5,5);
      }
      
      protected function initII() : void
      {
         di = ComponentFactory.Instance.creat("Vip.GetAwardsItemBG");
         var di2:* = ComponentFactory.Instance.creat("Vip.GetAwardsItemCellBG");
         addChild(di);
         addChild(di2);
         _itemName = ComponentFactory.Instance.creat("roulette.GoodsCellName");
         _itemName.mouseEnabled = false;
         _itemName.multiline = true;
         _itemName.wordWrap = true;
         addChild(_itemName);
         count_txt = ComponentFactory.Instance.creat("bossbox.boxCellCount");
         addChild(count_txt);
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
      }
      
      public function setCellValue(value:*) : void
      {
      }
      
      private function addEvent() : void
      {
         addEventListener("change",__setItemName);
      }
      
      public function set count(n:int) : void
      {
         count_txt.parent.removeChild(count_txt);
         addChild(count_txt);
         if(n <= 1)
         {
            count_txt.text = "";
            return;
         }
         count_txt.text = String(n);
      }
      
      public function __setItemName(e:Event) : void
      {
         itemName = _info.Name;
      }
      
      public function set itemName(name:String) : void
      {
         _itemName.text = name;
         _itemName.y = (44 - _itemName.textHeight) / 2 + 5;
      }
      
      override public function get height() : Number
      {
         return di.height;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("change",__setItemName);
         if(_itemName)
         {
            ObjectUtils.disposeObject(_itemName);
         }
         if(di)
         {
            ObjectUtils.disposeObject(di);
         }
         di = null;
         _itemName = null;
         if(count_txt)
         {
            ObjectUtils.disposeObject(count_txt);
         }
         count_txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
