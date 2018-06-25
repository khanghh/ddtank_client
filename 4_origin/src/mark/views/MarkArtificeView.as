package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkProData;
   import mark.data.MarkTransferTemplateData;
   import mark.event.MarkEvent;
   import mark.items.MarkArtificeItem;
   import mark.items.MarkPropItem;
   import mark.mornUI.views.MarkArtificeViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkArtificeView extends MarkArtificeViewUI
   {
       
      
      private var _itemLeft:BaseCell = null;
      
      private var _qualityTxtLeft:FilterFrameText = null;
      
      private var _transferAlert:BaseAlerFrame = null;
      
      public function MarkArtificeView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         icon14.toolTip = LanguageMgr.GetTranslation("mark.mornUI.label14");
         icon15.toolTip = LanguageMgr.GetTranslation("mark.mornUI.label15");
         var cellBG:Shape = new Shape();
         cellBG.graphics.beginFill(16777215,0);
         cellBG.graphics.drawRect(0,0,48,48);
         cellBG.graphics.endFill();
         _itemLeft = new BaseCell(cellBG);
         _itemLeft.setContentSize(48,48);
         PositionUtils.setPos(_itemLeft,"mark.itemPos");
         conItemLeft.addChild(_itemLeft);
         _qualityTxtLeft = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipQualityTxt");
         PositionUtils.setPos(_qualityTxtLeft,"mark.transferQualityTxtPos");
         conItemLeft.addChild(_qualityTxtLeft);
         initEvent();
         listProps.renderHandler = new Handler(render);
         listProps.selectHandler = new Handler(select);
         listTransfer.renderHandler = new Handler(transferRender);
         listTransfer.selectHandler = new Handler(transferSelect);
         var _loc2_:Boolean = false;
         listTransfer.mouseEnabled = _loc2_;
         listTransfer.mouseChildren = _loc2_;
         btnTransfer.clickHandler = new Handler(transfer);
         btnSubmit.label = "Đồng ý";
         btnCancel.label = "Hủy bỏ";
         btnSubmit.clickHandler = new Handler(submit,[true]);
         btnCancel.clickHandler = new Handler(submit,[false]);
         label1.text = LanguageMgr.GetTranslation("mark.mornUI.label1");
         updateInfo();
         select(0);
         listProps.selectedIndex = 0;
      }
      
      private function transfer() : void
      {
         var pro:* = null;
         if(listProps.array && listProps.selectedIndex > -1)
         {
            pro = listProps.array[listProps.selectedIndex] as MarkProData;
            MarkMgr.inst.reqTransferChip(pro.type);
         }
      }
      
      private function alertHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _transferAlert.removeEventListener("response",alertHandler);
         switch(int(evt.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               MarkMgr.inst.reqTransferChip(listProps.array[listProps.selectedIndex].type);
            default:
               MarkMgr.inst.reqTransferChip(listProps.array[listProps.selectedIndex].type);
         }
         _transferAlert.dispose();
         _transferAlert = null;
      }
      
      private function submit(ok:Boolean) : void
      {
         MarkMgr.inst.reqTransferSubmit(ok);
      }
      
      private function render(item:MarkPropItem, index:int) : void
      {
         var pro:* = null;
         if(index < listProps.array.length)
         {
            item.visible = true;
            pro = listProps.array[index];
            item.label = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + pro.type),pro.value + pro.attachValue);
            item.markProData = pro;
         }
         else
         {
            item.visible = false;
         }
      }
      
      private function select(index:int) : void
      {
         var i:int = 0;
         var item:MarkPropItem = null;
         for(i = 0; i < listProps.array.length; )
         {
            item = listProps.getCell(i) as MarkPropItem;
            if(item)
            {
               item.enable = index == i;
            }
            i++;
         }
         btnTransfer.disabled = false;
      }
      
      private function transferSelect(index:int) : void
      {
         index = index;
         var item:MarkArtificeItem = null;
         if(index == -1 && listTransfer.array)
         {
            listTransfer.array.forEach(function(it:*, idx:int, arr:Array):void
            {
               item = listTransfer.getCell(idx) as MarkArtificeItem;
               item.data = null;
            });
         }
         else if(index < listTransfer.array.length)
         {
            item = listTransfer.getCell(index) as MarkArtificeItem;
            item.data = MarkMgr.inst.model.transferPro;
         }
      }
      
      private function transferRender(item:MarkArtificeItem, index:int) : void
      {
         if(index < listTransfer.array.length)
         {
            item.data = listTransfer.array[index];
         }
         else
         {
            item.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("transferResult",transferResultHandler);
         MarkMgr.inst.addEventListener("markMoney",updateMarkMoney);
         MarkMgr.inst.addEventListener("submitResult",submitResult);
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("transferResult",transferResultHandler);
         MarkMgr.inst.removeEventListener("markMoney",updateMarkMoney);
         MarkMgr.inst.removeEventListener("submitResult",submitResult);
      }
      
      private function submitResult(evt:MarkEvent) : void
      {
         var i:int = 0;
         listTransfer.selectedIndex = -1;
         var item:MarkPropItem = null;
         for(i = 0; i < listProps.array.length; )
         {
            item = listProps.getCell(i) as MarkPropItem;
            if(item)
            {
               item.disabled = false;
            }
            i++;
         }
         updateInfo();
      }
      
      private function transferResultHandler(evt:MarkEvent) : void
      {
         var i:int = 0;
         var pro:MarkProData = MarkMgr.inst.model.transferPro;
         var index:* = -1;
         var item:MarkPropItem = null;
         for(i = 0; i < listProps.array.length; )
         {
            item = listProps.getCell(i) as MarkPropItem;
            if(listProps.array[i].type == pro.type)
            {
               index = i;
            }
            else if(item)
            {
               item.disabled = true;
            }
            i++;
         }
         listTransfer.selectedIndex = index;
         updateInfo();
      }
      
      private function updateMarkMoney(evt:MarkEvent) : void
      {
         lblMarkMoneyTotal.text = MarkMgr.inst.model.markMoney.toString();
      }
      
      private function updateInfo(evt:MarkEvent = null) : void
      {
         var i:int = 0;
         var p:int = 0;
         var chip:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         var character:int = MarkMgr.inst.model.cfgChip[chip.templateId].Character;
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(chip.templateId);
         _itemLeft.info = itemInfo;
         _itemLeft.tipData = chip;
         _qualityTxtLeft.text = LanguageMgr.GetTranslation("mark.qualityName",chip.hLv,itemInfo.Name,QualityType.QUALITY_STRING[character]);
         _qualityTxtLeft.textColor = QualityType.QUALITY_COLOR[character];
         var starsLeft:Array = [clipLeftStar1,clipLeftStar2,clipLeftStar3,clipLeftStar4,clipLeftStar5];
         for(i = 0; i < starsLeft.length; )
         {
            if(i < chip.bornLv + chip.hammerLv)
            {
               starsLeft[i].visible = true;
               starsLeft[i].index = i < chip.bornLv?0:1;
            }
            else
            {
               starsLeft[i].visible = false;
            }
            i++;
         }
         lblLeftAttachPro.text = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + chip.mainPro.type),chip.mainPro.value + chip.mainPro.attachValue);
         var transferData:MarkTransferTemplateData = MarkMgr.inst.getTransferData(itemInfo.Quality,chip.bornLv + chip.hammerLv);
         lblMarkCost.text = transferData.Expend.toString();
         lblOtherCost.text = transferData.NeedMaterial.toString();
         var arr:Array = [];
         var tmp:Array = [];
         var transferItem:MarkArtificeItem = null;
         for(p = 0; p < chip.props.length; )
         {
            if(chip.props[p].type > 0)
            {
               arr.push(chip.props[p]);
               tmp.push(p == listProps.selectedIndex?MarkMgr.inst.model.transferPro:!!MarkMgr.inst.model.transferPro?chip.props[p]:null);
            }
            p++;
         }
         listProps.array = arr;
         listTransfer.array = tmp;
         listTransfer.selectedIndex = !!MarkMgr.inst.model.transferPro?listProps.selectedIndex:-1;
         var _loc12_:* = MarkMgr.inst.model.transferPro != null;
         btnCancel.visible = _loc12_;
         btnSubmit.visible = _loc12_;
         btnTransfer.visible = MarkMgr.inst.model.transferPro == null;
         conLight.visible = MarkMgr.inst.model.transferPro != null;
         updateDemand();
      }
      
      private function updateDemand() : void
      {
         lblMarkMoneyTotal.text = MarkMgr.inst.model.markMoney.toString();
         lblStoneTotal.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12200,false).toString();
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
         var chip:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         if(!chip)
         {
            _itemLeft.info = null;
            return;
         }
         updateInfo();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeObject(_itemLeft);
         _itemLeft = null;
         ObjectUtils.disposeObject(_qualityTxtLeft);
         _qualityTxtLeft = null;
      }
   }
}
