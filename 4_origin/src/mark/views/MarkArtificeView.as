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
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,48,48);
         _loc1_.graphics.endFill();
         _itemLeft = new BaseCell(_loc1_);
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
         var _loc1_:* = null;
         if(listProps.array && listProps.selectedIndex > -1)
         {
            _loc1_ = listProps.array[listProps.selectedIndex] as MarkProData;
            MarkMgr.inst.reqTransferChip(_loc1_.type);
         }
      }
      
      private function alertHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _transferAlert.removeEventListener("response",alertHandler);
         switch(int(param1.responseCode))
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
      
      private function submit(param1:Boolean) : void
      {
         MarkMgr.inst.reqTransferSubmit(param1);
      }
      
      private function render(param1:MarkPropItem, param2:int) : void
      {
         var _loc3_:* = null;
         if(param2 < listProps.array.length)
         {
            param1.visible = true;
            _loc3_ = listProps.array[param2];
            param1.label = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + _loc3_.type),_loc3_.value + _loc3_.attachValue);
            param1.markProData = _loc3_;
         }
         else
         {
            param1.visible = false;
         }
      }
      
      private function select(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MarkPropItem = null;
         _loc3_ = 0;
         while(_loc3_ < listProps.array.length)
         {
            _loc2_ = listProps.getCell(_loc3_) as MarkPropItem;
            if(_loc2_)
            {
               _loc2_.enable = param1 == _loc3_;
            }
            _loc3_++;
         }
         btnTransfer.disabled = false;
      }
      
      private function transferSelect(param1:int) : void
      {
         index = param1;
         var item:MarkArtificeItem = null;
         if(index == -1 && listTransfer.array)
         {
            listTransfer.array.forEach(function(param1:*, param2:int, param3:Array):void
            {
               item = listTransfer.getCell(param2) as MarkArtificeItem;
               item.data = null;
            });
         }
         else if(index < listTransfer.array.length)
         {
            item = listTransfer.getCell(index) as MarkArtificeItem;
            item.data = MarkMgr.inst.model.transferPro;
         }
      }
      
      private function transferRender(param1:MarkArtificeItem, param2:int) : void
      {
         if(param2 < listTransfer.array.length)
         {
            param1.data = listTransfer.array[param2];
         }
         else
         {
            param1.visible = false;
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
      
      private function submitResult(param1:MarkEvent) : void
      {
         var _loc3_:int = 0;
         listTransfer.selectedIndex = -1;
         var _loc2_:MarkPropItem = null;
         _loc3_ = 0;
         while(_loc3_ < listProps.array.length)
         {
            _loc2_ = listProps.getCell(_loc3_) as MarkPropItem;
            if(_loc2_)
            {
               _loc2_.disabled = false;
            }
            _loc3_++;
         }
         updateInfo();
      }
      
      private function transferResultHandler(param1:MarkEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:MarkProData = MarkMgr.inst.model.transferPro;
         var _loc2_:* = -1;
         var _loc3_:MarkPropItem = null;
         _loc5_ = 0;
         while(_loc5_ < listProps.array.length)
         {
            _loc3_ = listProps.getCell(_loc5_) as MarkPropItem;
            if(listProps.array[_loc5_].type == _loc4_.type)
            {
               _loc2_ = _loc5_;
            }
            else if(_loc3_)
            {
               _loc3_.disabled = true;
            }
            _loc5_++;
         }
         listTransfer.selectedIndex = _loc2_;
         updateInfo();
      }
      
      private function updateMarkMoney(param1:MarkEvent) : void
      {
         lblMarkMoneyTotal.text = MarkMgr.inst.model.markMoney.toString();
      }
      
      private function updateInfo(param1:MarkEvent = null) : void
      {
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         var _loc11_:int = MarkMgr.inst.model.cfgChip[_loc2_.templateId].Character;
         var _loc8_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc2_.templateId);
         _itemLeft.info = _loc8_;
         _itemLeft.tipData = _loc2_;
         _qualityTxtLeft.text = LanguageMgr.GetTranslation("mark.qualityName",_loc2_.hLv,_loc8_.Name,QualityType.QUALITY_STRING[_loc11_]);
         _qualityTxtLeft.textColor = QualityType.QUALITY_COLOR[_loc11_];
         var _loc4_:Array = [clipLeftStar1,clipLeftStar2,clipLeftStar3,clipLeftStar4,clipLeftStar5];
         _loc10_ = 0;
         while(_loc10_ < _loc4_.length)
         {
            if(_loc10_ < _loc2_.bornLv + _loc2_.hammerLv)
            {
               _loc4_[_loc10_].visible = true;
               _loc4_[_loc10_].index = _loc10_ < _loc2_.bornLv?0:1;
            }
            else
            {
               _loc4_[_loc10_].visible = false;
            }
            _loc10_++;
         }
         lblLeftAttachPro.text = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + _loc2_.mainPro.type),_loc2_.mainPro.value + _loc2_.mainPro.attachValue);
         var _loc6_:MarkTransferTemplateData = MarkMgr.inst.getTransferData(_loc8_.Quality,_loc2_.bornLv + _loc2_.hammerLv);
         lblMarkCost.text = _loc6_.Expend.toString();
         lblOtherCost.text = _loc6_.NeedMaterial.toString();
         var _loc3_:Array = [];
         var _loc7_:Array = [];
         var _loc9_:MarkArtificeItem = null;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.props.length)
         {
            if(_loc2_.props[_loc5_].type > 0)
            {
               _loc3_.push(_loc2_.props[_loc5_]);
               _loc7_.push(_loc5_ == listProps.selectedIndex?MarkMgr.inst.model.transferPro:!!MarkMgr.inst.model.transferPro?_loc2_.props[_loc5_]:null);
            }
            _loc5_++;
         }
         listProps.array = _loc3_;
         listTransfer.array = _loc7_;
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
      
      override public function set visible(param1:Boolean) : void
      {
         .super.visible = param1;
         var _loc2_:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         if(!_loc2_)
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
