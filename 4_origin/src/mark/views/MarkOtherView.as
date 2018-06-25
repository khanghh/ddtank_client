package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkModel;
   import mark.event.MarkEvent;
   import mark.items.MarkChipItem;
   import mark.items.MarkEquipItem;
   import mark.mornUI.views.MarkOtherViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkOtherView extends MarkOtherViewUI
   {
       
      
      private var _items:Vector.<MarkChipItem> = null;
      
      private var _item:BaseCell = null;
      
      private var _info:PlayerInfo = null;
      
      public function MarkOtherView(info:PlayerInfo)
      {
         _info = info;
         super();
         MarkMgr.inst.isOther = true;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         label7.text = LanguageMgr.GetTranslation("mark.mornUI.label7");
         label8.text = LanguageMgr.GetTranslation("mark.mornUI.label8");
         label9.text = LanguageMgr.GetTranslation("mark.mornUI.label9");
         label10.text = LanguageMgr.GetTranslation("mark.mornUI.label10");
         label11.text = LanguageMgr.GetTranslation("mark.mornUI.label11");
         label12.text = LanguageMgr.GetTranslation("mark.mornUI.label12");
         MarkMgr.inst.addEventListener("remove_view",disposeView);
         listEquip.selectHandler = new Handler(select);
         listEquip.selectedIndex = 0;
         listEquip.renderHandler = new Handler(render);
         listEquip.array = equipList;
      }
      
      private function get equipList() : Array
      {
         var i:int = 0;
         var list:Array = [];
         for(i = 0; i < MarkModel.EQUIP_LIST.length; )
         {
            list.push(_info.Bag.items[MarkModel.EQUIP_LIST[i]]);
            i++;
         }
         return list;
      }
      
      private function render(item:MarkEquipItem, index:int) : void
      {
         item.data = listEquip.array[index];
      }
      
      private function select(index:int) : void
      {
         clearItems();
         _items = new Vector.<MarkChipItem>();
         var item:MarkChipItem = null;
         var chipTemplate:MarkChipTemplateData = null;
         var chips:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var _loc9_:int = 0;
         var _loc8_:* = _info.Markbag.chips;
         for each(var chip1 in _info.Markbag.chips)
         {
            if(chip1.equipType == MarkModel.EQUIP_LIST[index])
            {
               chips.push(chip1);
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = chips;
         for each(var chip in chips)
         {
            chipTemplate = MarkMgr.inst.model.cfgChip[chip.templateId];
            if(chipTemplate)
            {
               item = new MarkChipItem(chip);
               item.tipData = chip;
               item.interactive = false;
               addChild(item);
               PositionUtils.setPos(item,"mark.itemOtherPos" + chipTemplate.Place);
               _items.push(item);
            }
         }
         var cellBG:Shape = new Shape();
         cellBG.graphics.beginFill(16777215,0);
         cellBG.graphics.drawRect(0,0,56,56);
         cellBG.graphics.endFill();
         _item = new BaseCell(cellBG,null,true,false);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,"mark.equipOtherPos");
         addChild(_item);
         _item.info = _info.Bag.items[MarkModel.EQUIP_LIST[index]];
      }
      
      private function getSelfChips(index:int) : Array
      {
         var arr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = MarkMgr.inst.model.getChipsByEquipType(index);
         for each(var chip in MarkMgr.inst.model.getChipsByEquipType(index))
         {
            if(chip.position == index)
            {
               arr.push(chip);
            }
         }
         return arr;
      }
      
      private function clearItems() : void
      {
         var item:* = null;
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
         }
         _item = null;
         if(_items)
         {
            item = null;
            while(_items.length > 0)
            {
               item = _items.pop();
               ObjectUtils.disposeObject(item);
            }
            _items = null;
         }
      }
      
      private function disposeView(evt:MarkEvent) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         MarkMgr.inst.isOther = false;
         super.dispose();
         clearItems();
         MarkMgr.inst.removeEventListener("remove_view",disposeView);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
