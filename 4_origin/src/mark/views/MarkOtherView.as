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
      
      public function MarkOtherView(param1:PlayerInfo)
      {
         _info = param1;
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
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < MarkModel.EQUIP_LIST.length)
         {
            _loc1_.push(_info.Bag.items[MarkModel.EQUIP_LIST[_loc2_]]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function render(param1:MarkEquipItem, param2:int) : void
      {
         param1.data = listEquip.array[param2];
      }
      
      private function select(param1:int) : void
      {
         clearItems();
         _items = new Vector.<MarkChipItem>();
         var _loc4_:MarkChipItem = null;
         var _loc5_:MarkChipTemplateData = null;
         var _loc3_:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var _loc9_:int = 0;
         var _loc8_:* = _info.Markbag.chips;
         for each(var _loc7_ in _info.Markbag.chips)
         {
            if(_loc7_.equipType == MarkModel.EQUIP_LIST[param1])
            {
               _loc3_.push(_loc7_);
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc5_ = MarkMgr.inst.model.cfgChip[_loc2_.templateId];
            if(_loc5_)
            {
               _loc4_ = new MarkChipItem(_loc2_);
               _loc4_.tipData = _loc2_;
               _loc4_.interactive = false;
               addChild(_loc4_);
               PositionUtils.setPos(_loc4_,"mark.itemOtherPos" + _loc5_.Place);
               _items.push(_loc4_);
            }
         }
         var _loc6_:Shape = new Shape();
         _loc6_.graphics.beginFill(16777215,0);
         _loc6_.graphics.drawRect(0,0,56,56);
         _loc6_.graphics.endFill();
         _item = new BaseCell(_loc6_,null,true,false);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,"mark.equipOtherPos");
         addChild(_item);
         _item.info = _info.Bag.items[MarkModel.EQUIP_LIST[param1]];
      }
      
      private function getSelfChips(param1:int) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = MarkMgr.inst.model.getChipsByEquipType(param1);
         for each(var _loc2_ in MarkMgr.inst.model.getChipsByEquipType(param1))
         {
            if(_loc2_.position == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function clearItems() : void
      {
         var _loc1_:* = null;
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
         }
         _item = null;
         if(_items)
         {
            _loc1_ = null;
            while(_items.length > 0)
            {
               _loc1_ = _items.pop();
               ObjectUtils.disposeObject(_loc1_);
            }
            _items = null;
         }
      }
      
      private function disposeView(param1:MarkEvent) : void
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
