package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkProData;
   import mark.data.MarkSetTemplateData;
   import mark.data.MarkSuitTemplateData;
   import mark.event.MarkEvent;
   import mark.items.MarkChipItem;
   import mark.items.MarkEquipItem;
   import mark.items.MarkSuitProItem;
   import mark.mornUI.views.MarkLeftViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkLeftView extends MarkLeftViewUI
   {
       
      
      private var _items:Vector.<MarkChipItem> = null;
      
      private var _item:BaseCell = null;
      
      private var _bgEffect:MovieClip = null;
      
      public function MarkLeftView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         label5.text = LanguageMgr.GetTranslation("mark.mornUI.label5");
         label6.text = LanguageMgr.GetTranslation("mark.mornUI.label6");
         label7.text = LanguageMgr.GetTranslation("mark.mornUI.label7");
         label8.text = LanguageMgr.GetTranslation("mark.mornUI.label8");
         label9.text = LanguageMgr.GetTranslation("mark.mornUI.label9");
         label10.text = LanguageMgr.GetTranslation("mark.mornUI.label10");
         label11.text = LanguageMgr.GetTranslation("mark.mornUI.label11");
         label12.text = LanguageMgr.GetTranslation("mark.mornUI.label12");
         icon14.toolTip = LanguageMgr.GetTranslation("mark.mornUI.label14");
         initEvent();
         listEquip.renderHandler = new Handler(render);
         listEquip.selectHandler = new Handler(select);
         listEquip.array = MarkMgr.inst.getEquipList();
         listEquip.selectedIndex = 0;
         listSuitType.renderHandler = new Handler(suitRender);
         listSuitType.array = MarkMgr.inst.model.getSuitList();
         updateMarkMoney();
      }
      
      private function suitRender(param1:MarkSuitProItem, param2:int) : void
      {
         if(listSuitType.array.length > 0)
         {
            listSuitType.visible = true;
            param1.data = listSuitType.array[param2];
            lblSuit.htmlText = "";
         }
         else
         {
            lblSuit.htmlText = LanguageMgr.GetTranslation("mark.noSuits");
            listSuitType.visible = false;
         }
      }
      
      private function render(param1:MarkEquipItem, param2:int) : void
      {
         param1.data = listEquip.array[param2];
      }
      
      private function chooseEquip(param1:MarkEvent) : void
      {
         clearItems();
         _items = new Vector.<MarkChipItem>();
         var _loc3_:MarkChipItem = null;
         var _loc4_:MarkChipTemplateData = null;
         var _loc7_:int = 0;
         var _loc6_:* = MarkMgr.inst.model.getChipsByEquipType(MarkMgr.inst.model.equip);
         for each(var _loc2_ in MarkMgr.inst.model.getChipsByEquipType(MarkMgr.inst.model.equip))
         {
            _loc4_ = MarkMgr.inst.model.cfgChip[_loc2_.templateId];
            if(_loc4_)
            {
               _loc3_ = new MarkChipItem(_loc2_);
               addChild(_loc3_);
               _loc3_.tipData = _loc2_;
               PositionUtils.setPos(_loc3_,"mark.itemPos" + _loc4_.Place);
               _items.push(_loc3_);
            }
         }
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(16777215,0);
         _loc5_.graphics.drawRect(0,0,56,56);
         _loc5_.graphics.endFill();
         _item = new BaseCell(_loc5_);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,"mark.equipPos");
         addChild(_item);
         _item.info = PlayerManager.Instance.Self.Bag.items[MarkMgr.inst.model.equip];
         _item.tipData = null;
         playSuitEffect();
         updateProps();
         listSuitType.array = MarkMgr.inst.model.getSuitList();
         listSuitType.repeatX = listSuitType.array.length;
      }
      
      private function updateProps() : void
      {
         var _loc2_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:String = "";
         var _loc10_:Array = MarkMgr.inst.sortedProps(MarkMgr.inst.getEquipProps());
         var _loc9_:int = 0;
         var _loc3_:MarkProData = null;
         var _loc7_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc10_.length)
         {
            _loc3_ = _loc10_[_loc2_] as MarkProData;
            if(_loc3_ != null)
            {
               _loc9_ = _loc3_.value + _loc3_.attachValue;
               if(_loc9_ > 0)
               {
                  _loc1_ = _loc1_ + (LanguageMgr.GetTranslation(_loc2_ > 8?"mark.realValue":"mark.realBigValue",LanguageMgr.GetTranslation("mark.pro" + _loc3_.type),_loc3_.value + _loc3_.attachValue) + "  ");
                  _loc7_++;
                  _loc1_ = _loc1_ + (_loc7_ % 4 == 0?"\n":"");
               }
            }
            _loc2_++;
         }
         txtProps.htmlText = _loc1_.length == 0?LanguageMgr.GetTranslation("mark.noProps"):_loc1_;
         txtProps.selectable = false;
         txtProps.editable = false;
         var _loc5_:String = "";
         var _loc6_:Array = MarkMgr.inst.model.getSuitList();
         var _loc4_:MarkSuitTemplateData = null;
         var _loc8_:MarkSetTemplateData = null;
         _loc11_ = 0;
         while(_loc11_ < _loc6_.length)
         {
            _loc4_ = MarkMgr.inst.model.cfgSuit[_loc6_[_loc11_].id];
            _loc8_ = MarkMgr.inst.model.cfgSet[_loc4_.SetId];
            _loc5_ = _loc5_ + (LanguageMgr.GetTranslation("mark.suitPor",_loc8_.Name,_loc4_.Demand) + "   ");
            _loc11_++;
         }
      }
      
      private function select(param1:int) : void
      {
         MarkMgr.inst.chooseEquip(param1);
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("remove_view",disposeView);
         MarkMgr.inst.addEventListener("choose_equip",chooseEquip);
         MarkMgr.inst.addEventListener("updateChips",chooseEquip);
         MarkMgr.inst.addEventListener("putOnChip",putOnChip);
         MarkMgr.inst.addEventListener("putOffChip",putOffChip);
         MarkMgr.inst.addEventListener("markMoney",updateMarkMoney);
         btnJewel.addEventListener("click",__onClickHandler);
      }
      
      private function updateMarkMoney(param1:MarkEvent = null) : void
      {
         lblDemandCnt.text = MarkMgr.inst.model.markMoney.toString();
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         MarkMgr.inst.isFarmMark = true;
         MarkMgr.inst.showTreasureRoomView();
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("remove_view",disposeView);
         MarkMgr.inst.removeEventListener("choose_equip",chooseEquip);
         MarkMgr.inst.removeEventListener("updateChips",chooseEquip);
         MarkMgr.inst.removeEventListener("putOnChip",putOnChip);
         MarkMgr.inst.removeEventListener("putOffChip",putOffChip);
         MarkMgr.inst.removeEventListener("markMoney",updateMarkMoney);
         btnJewel.removeEventListener("click",__onClickHandler);
      }
      
      private function putOnChip(param1:MarkEvent) : void
      {
         var _loc3_:int = param1.data;
         var _loc2_:MarkChipData = MarkMgr.inst.model.getChipById(_loc3_);
         var _loc4_:MarkChipItem = new MarkChipItem(_loc2_);
         _loc4_.tipData = _loc2_;
         var _loc5_:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[_loc2_.templateId];
         addChild(_loc4_);
         PositionUtils.setPos(_loc4_,"mark.itemPos" + _loc5_.Place);
         if(!_items)
         {
            _items = new Vector.<MarkChipItem>();
         }
         _items.push(_loc4_);
         playSuitEffect(1,_loc3_);
         updateProps();
      }
      
      private function playSuitEffect(param1:int = 0, param2:int = 0) : void
      {
         if(_items == null || _items.length == 0)
         {
            return;
         }
         clearEffect();
         var _loc6_:Dictionary = new Dictionary();
         var _loc4_:MarkChipTemplateData = null;
         var _loc13_:int = 0;
         var _loc12_:* = _items;
         for each(var _loc5_ in _items)
         {
            _loc4_ = MarkMgr.inst.model.cfgChip[(MarkMgr.inst.model.getChipById(_loc5_.id) as MarkChipData).templateId];
            var _loc11_:* = _loc4_.SetID;
            _loc6_[_loc11_] = _loc6_[_loc11_] || [];
            _loc6_[_loc4_.SetID].push(_loc5_);
         }
         var _loc9_:MarkChipData = MarkMgr.inst.model.getChipById(param2);
         var _loc8_:MarkChipTemplateData = _loc9_ == null?null:MarkMgr.inst.model.cfgChip[_loc9_.templateId];
         var _loc19_:int = 0;
         var _loc18_:* = _loc6_;
         for(var _loc10_ in _loc6_)
         {
            var _loc17_:int = 0;
            var _loc16_:* = MarkMgr.inst.model.cfgSuit;
            for each(var _loc7_ in MarkMgr.inst.model.cfgSuit)
            {
               var _loc15_:int = 0;
               var _loc14_:* = _loc6_[_loc10_];
               for each(var _loc3_ in _loc6_[_loc10_])
               {
                  _loc3_.playSuitEffect();
               }
               if(_loc7_.SetId == int(_loc10_))
               {
                  if(_loc7_.Demand <= _loc6_[_loc10_].length)
                  {
                     if(param1 == 1 && _loc7_.Demand == _loc6_[_loc10_].length && _loc8_.SetID == _loc10_)
                     {
                        if(!_bgEffect)
                        {
                           _bgEffect = ComponentFactory.Instance.creat("asset.markBgEffect");
                           _loc11_ = false;
                           _bgEffect.mouseEnabled = _loc11_;
                           _bgEffect.mouseChildren = _loc11_;
                           PositionUtils.setPos(_bgEffect,{
                              "x":182,
                              "y":0
                           });
                           addChild(_bgEffect);
                        }
                        if(_bgEffect)
                        {
                           _bgEffect.play();
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function clearEffect() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc1_.stopSuitEffect();
         }
      }
      
      private function putOffChip(param1:MarkEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            if(_items[_loc4_].id == param1.data)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc2_ > -1)
         {
            _loc3_ = _items.splice(_loc2_,1);
            ObjectUtils.disposeObject(_loc3_[0]);
            updateProps();
         }
         playSuitEffect(2);
      }
      
      private function disposeView(param1:MarkEvent) : void
      {
         dispose();
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
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         clearItems();
         if(_bgEffect)
         {
            ObjectUtils.disposeObject(_bgEffect);
         }
         _bgEffect = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
