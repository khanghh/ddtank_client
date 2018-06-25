package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkProData;
   import mark.data.MarkSchemeModel;
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
      
      private static const MAX_SCHEME_COUNT:int = 5;
      
      private static const FREE_SCHEME_COUNT:int = 2;
       
      
      private var _items:Vector.<MarkChipItem> = null;
      
      private var _item:BaseCell = null;
      
      private var _bgEffect:MovieClip = null;
      
      private var _selectedBox:ComboBox;
      
      private var _comboBoxArr:Array;
      
      private var _schemeMode:MarkSchemeModel;
      
      private var _schemePrice:int = 2000;
      
      private var _isSwitchScheme:Boolean = false;
      
      private var _clickNum:Number = 0;
      
      public function MarkLeftView()
      {
         _comboBoxArr = [];
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
         initComBoxSuitWay();
         initEvent();
         listEquip.renderHandler = new Handler(render);
         listEquip.selectHandler = new Handler(select);
         listEquip.array = MarkMgr.inst.getEquipList();
         listEquip.selectedIndex = 0;
         listSuitType.renderHandler = new Handler(suitRender);
         listSuitType.array = MarkMgr.inst.model.getSuitList();
         updateMarkMoney();
      }
      
      private function initComBoxSuitWay() : void
      {
         var i:int = 0;
         _isSwitchScheme = false;
         _schemeMode = MarkMgr.inst.schemeModel;
         _selectedBox = ComponentFactory.Instance.creatComponentByStylename("mark.suitWay.selectCombo");
         addChild(_selectedBox);
         var schemCount:int = Math.max(2,_schemeMode.schemCount);
         for(i = 0; i < schemCount; )
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("mark.equipScheme.txt" + i));
            i++;
         }
         if(schemCount < 5)
         {
            _comboBoxArr.push(LanguageMgr.GetTranslation("mark.equipScheme.add"));
         }
         _selectedBox.textField.text = _comboBoxArr[_schemeMode.curScheme];
         _selectedBox.listPanel.vectorListModel.appendAll(_comboBoxArr);
      }
      
      private function suitRender(item:MarkSuitProItem, index:int) : void
      {
         if(listSuitType.array.length > 0)
         {
            listSuitType.visible = true;
            item.data = listSuitType.array[index];
            lblSuit.htmlText = "";
         }
         else
         {
            lblSuit.htmlText = LanguageMgr.GetTranslation("mark.noSuits");
            listSuitType.visible = false;
         }
      }
      
      private function render(item:MarkEquipItem, index:int) : void
      {
         item.data = listEquip.array[index];
      }
      
      private function chooseEquip(evt:MarkEvent) : void
      {
         clearItems();
         _items = new Vector.<MarkChipItem>();
         var item:MarkChipItem = null;
         var chipTemplate:MarkChipTemplateData = null;
         var _loc7_:int = 0;
         var _loc6_:* = MarkMgr.inst.model.getChipsByEquipType(MarkMgr.inst.model.equip);
         for each(var chip in MarkMgr.inst.model.getChipsByEquipType(MarkMgr.inst.model.equip))
         {
            chipTemplate = MarkMgr.inst.model.cfgChip[chip.templateId];
            if(chipTemplate)
            {
               item = new MarkChipItem(chip);
               addChild(item);
               item.tipData = chip;
               PositionUtils.setPos(item,"mark.itemPos" + chipTemplate.Place);
               _items.push(item);
            }
         }
         var cellBG:Shape = new Shape();
         cellBG.graphics.beginFill(16777215,0);
         cellBG.graphics.drawRect(0,0,56,56);
         cellBG.graphics.endFill();
         _item = new BaseCell(cellBG);
         _item.setContentSize(56,56);
         PositionUtils.setPos(_item,"mark.equipPos");
         addChild(_item);
         _item.info = PlayerManager.Instance.Self.Bag.items[MarkMgr.inst.model.equip];
         _item.tipData = null;
         playSuitEffect();
         updateProps();
         listSuitType.array = MarkMgr.inst.model.getSuitList();
         listSuitType.repeatX = listSuitType.array.length;
         if(!_isSwitchScheme)
         {
            updateSaveSchemeBtnState();
         }
      }
      
      private function updateProps() : void
      {
         var idx:int = 0;
         var i:int = 0;
         var proStr:String = "";
         var props:Array = MarkMgr.inst.sortedProps(MarkMgr.inst.getEquipProps());
         var proValue:int = 0;
         var it:MarkProData = null;
         var line:int = 0;
         for(idx = 0; idx < props.length; )
         {
            it = props[idx] as MarkProData;
            if(it != null)
            {
               proValue = it.value + it.attachValue;
               if(proValue > 0)
               {
                  proStr = proStr + (LanguageMgr.GetTranslation(idx > 8?"mark.realValue":"mark.realBigValue",LanguageMgr.GetTranslation("mark.pro" + it.type),it.value + it.attachValue) + "  ");
                  line++;
               }
            }
            idx++;
         }
         txtProps.htmlText = proStr.length == 0?LanguageMgr.GetTranslation("mark.noProps"):proStr;
         txtProps.selectable = false;
         txtProps.editable = false;
         var suitStr:String = "";
         var suits:Array = MarkMgr.inst.model.getSuitList();
         var suit:MarkSuitTemplateData = null;
         var sett:MarkSetTemplateData = null;
         for(i = 0; i < suits.length; )
         {
            suit = MarkMgr.inst.model.cfgSuit[suits[i].id];
            sett = MarkMgr.inst.model.cfgSet[suit.SetId];
            suitStr = suitStr + (LanguageMgr.GetTranslation("mark.suitPor",sett.Name,suit.Demand) + "   ");
            i++;
         }
      }
      
      private function select(index:int) : void
      {
         MarkMgr.inst.chooseEquip(index);
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("remove_view",disposeView);
         MarkMgr.inst.addEventListener("choose_equip",chooseEquip);
         MarkMgr.inst.addEventListener("updateChips",chooseEquip);
         MarkMgr.inst.addEventListener("putOnChip",putOnChip);
         MarkMgr.inst.addEventListener("putOffChip",putOffChip);
         MarkMgr.inst.addEventListener("curSchemeChange",__updateCurScheme);
         MarkMgr.inst.addEventListener("curSchemeChangeDEF",__updateCurSchemeDe);
         MarkMgr.inst.addEventListener("markMoney",updateMarkMoney);
         btnJewel.addEventListener("click",__onClickHandler);
         btn_save.addEventListener("click",__onSaveSuitWayHandler);
         MarkMgr.inst.addEventListener("addScheme",__onAddSchemeHandler);
         MarkMgr.inst.addEventListener("saveScheme",__onSaveSchemeHandler);
         if(_selectedBox)
         {
            _selectedBox.listPanel.list.addEventListener("listItemClick",__itemClickHander);
         }
      }
      
      private function __updateCurScheme(evt:MarkEvent) : void
      {
         _selectedBox.textField.text = _comboBoxArr[_schemeMode.curScheme];
         _isSwitchScheme = false;
         updateSaveSchemeBtnState();
      }
      
      private function __updateCurSchemeDe(evt:MarkEvent) : void
      {
         _isSwitchScheme = false;
      }
      
      private function updateSaveSchemeBtnState() : void
      {
         var curCheckScheme:String = MarkMgr.inst.model.getChipsJoinById();
         var needSave:* = _schemeMode.getSchemeInfo(_schemeMode.curScheme).schemeData == curCheckScheme;
         btn_save.disabled = needSave;
         MarkMgr.inst.needSave = !needSave;
      }
      
      private function __itemClickHander(evt:ListItemEvent) : void
      {
         var alertAsk:* = null;
         var state:Boolean = false;
         SoundManager.instance.playButtonSound();
         var _curSeIndex:int = _comboBoxArr.indexOf(evt.cellValue);
         _selectedBox.textField.text = _comboBoxArr[_schemeMode.curScheme];
         if(!canClick)
         {
            evt.stopImmediatePropagation();
            return;
         }
         if(evt.cellValue == LanguageMgr.GetTranslation("mark.equipScheme.add"))
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _schemePrice = ServerConfigManager.instance.MarkEquipSchemePrice;
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",_schemePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
            alertAsk.addEventListener("response",__alertAllBack);
            return;
         }
         state = btn_save.disabled;
         if(state)
         {
            sendSwitchScheme(_curSeIndex);
         }
         else
         {
            alertSavePrompt(_curSeIndex);
         }
         evt.stopImmediatePropagation();
      }
      
      private function alertSavePrompt(newIndex:*) : void
      {
         newIndex = newIndex;
         MarkMgr.inst.promptSchemeSave(function():*
         {
            var /*UnknownSlot*/:* = function(result:Boolean):void
            {
               if(result)
               {
                  sendSwitchScheme(newIndex);
                  return;
               }
            };
            return function(result:Boolean):void
            {
               if(result)
               {
                  sendSwitchScheme(newIndex);
                  return;
               }
            };
         }());
      }
      
      private function sendSwitchScheme(newIndex:int) : void
      {
         _isSwitchScheme = true;
         MarkMgr.inst.reqSwitchEquipScheme(newIndex);
      }
      
      private function __alertAllBack(event:FrameEvent) : void
      {
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_schemePrice,MarkMgr.inst.reqAddEquipScheme);
         }
         frame.dispose();
      }
      
      private function __onSaveSuitWayHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var schemeID:int = _schemeMode.curScheme;
         MarkMgr.inst.reqSaveMarkScheme(schemeID);
      }
      
      private function __onAddSchemeHandler(evt:MarkEvent) : void
      {
         _selectedBox.textField.text = _comboBoxArr[_schemeMode.curScheme];
         var haveScheme:int = _schemeMode.schemCount;
         if(haveScheme <= 2)
         {
            return;
         }
         _comboBoxArr.splice(haveScheme - 1,haveScheme == 5?1:0,LanguageMgr.GetTranslation("mark.equipScheme.txt" + (haveScheme - 1)));
         if(haveScheme < 5)
         {
            _selectedBox.listPanel.vectorListModel.append(_comboBoxArr[haveScheme - 1],haveScheme - 1);
         }
         else
         {
            _selectedBox.listPanel.vectorListModel.remove(LanguageMgr.GetTranslation("mark.equipScheme.add"));
            _selectedBox.listPanel.vectorListModel.append(_comboBoxArr[haveScheme - 1],4);
         }
      }
      
      private function __onSaveSchemeHandler(e:MarkEvent) : void
      {
         updateSaveSchemeBtnState();
      }
      
      private function updateMarkMoney(evt:MarkEvent = null) : void
      {
         lblDemandCnt.text = MarkMgr.inst.model.markMoney.toString();
      }
      
      protected function __onClickHandler(event:MouseEvent) : void
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
         MarkMgr.inst.removeEventListener("curSchemeChange",__updateCurScheme);
         MarkMgr.inst.removeEventListener("curSchemeChangeDEF",__updateCurSchemeDe);
         MarkMgr.inst.removeEventListener("markMoney",updateMarkMoney);
         btnJewel.removeEventListener("click",__onClickHandler);
         btn_save.removeEventListener("click",__onSaveSuitWayHandler);
         MarkMgr.inst.removeEventListener("addScheme",__onAddSchemeHandler);
         MarkMgr.inst.removeEventListener("saveScheme",__onSaveSchemeHandler);
         if(_selectedBox)
         {
            _selectedBox.removeEventListener("listItemClick",__itemClickHander);
         }
      }
      
      private function putOnChip(evt:MarkEvent) : void
      {
         var id:int = evt.data;
         var chip:MarkChipData = MarkMgr.inst.model.getChipById(id);
         var item:MarkChipItem = new MarkChipItem(chip);
         item.tipData = chip;
         var chipTemplate:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[chip.templateId];
         addChild(item);
         PositionUtils.setPos(item,"mark.itemPos" + chipTemplate.Place);
         if(!_items)
         {
            _items = new Vector.<MarkChipItem>();
         }
         _items.push(item);
         playSuitEffect(1,id);
         updateProps();
      }
      
      private function playSuitEffect(type:int = 0, chipId:int = 0) : void
      {
         if(_items == null || _items.length == 0)
         {
            return;
         }
         clearEffect();
         var suitDic:Dictionary = new Dictionary();
         var chipData:MarkChipTemplateData = null;
         var _loc13_:int = 0;
         var _loc12_:* = _items;
         for each(var item in _items)
         {
            chipData = MarkMgr.inst.model.cfgChip[(MarkMgr.inst.model.getChipById(item.id) as MarkChipData).templateId];
            var _loc11_:* = chipData.SetID;
            suitDic[_loc11_] = suitDic[_loc11_] || [];
            suitDic[chipData.SetID].push(item);
         }
         var operChip:MarkChipData = MarkMgr.inst.model.getChipById(chipId);
         var putOnChip:MarkChipTemplateData = operChip == null?null:MarkMgr.inst.model.cfgChip[operChip.templateId];
         var _loc19_:int = 0;
         var _loc18_:* = suitDic;
         for(var key in suitDic)
         {
            var _loc17_:int = 0;
            var _loc16_:* = MarkMgr.inst.model.cfgSuit;
            for each(var suit in MarkMgr.inst.model.cfgSuit)
            {
               var _loc15_:int = 0;
               var _loc14_:* = suitDic[key];
               for each(var it in suitDic[key])
               {
                  it.playSuitEffect();
               }
               if(suit.SetId == int(key))
               {
                  if(suit.Demand <= suitDic[key].length)
                  {
                     if(type == 1 && suit.Demand == suitDic[key].length && putOnChip.SetID == key)
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
         for each(var item in _items)
         {
            item.stopSuitEffect();
         }
      }
      
      private function putOffChip(evt:MarkEvent) : void
      {
         var i:int = 0;
         var items:* = undefined;
         var index:* = -1;
         for(i = 0; i < _items.length; )
         {
            if(_items[i].id == evt.data)
            {
               index = i;
               break;
            }
            i++;
         }
         if(index > -1)
         {
            items = _items.splice(index,1);
            ObjectUtils.disposeObject(items[0]);
            updateProps();
         }
         playSuitEffect(2);
      }
      
      private function disposeView(evt:MarkEvent) : void
      {
         dispose();
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
      
      private function get canClick() : Boolean
      {
         var nowTime:Number = new Date().time;
         if(nowTime - _clickNum < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return false;
         }
         _clickNum = nowTime;
         return true;
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
