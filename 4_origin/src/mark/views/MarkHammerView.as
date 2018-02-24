package mark.views
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import mark.MarkMgr;
   import mark.data.MarkChipData;
   import mark.data.MarkHammerTemplateData;
   import mark.data.MarkProData;
   import mark.event.MarkEvent;
   import mark.mornUI.views.MarkHammerViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkHammerView extends MarkHammerViewUI
   {
       
      
      private var _item:BaseCell = null;
      
      private var _qualityTxt:FilterFrameText = null;
      
      private var _progessMC:MovieClip = null;
      
      private var _wheelMC:MovieClip = null;
      
      private var _flashMC:MovieClip = null;
      
      private var _successMC:MovieClip = null;
      
      private var _failMC:MovieClip = null;
      
      private var _result:Boolean = false;
      
      private var _cnt:int = 0;
      
      public function MarkHammerView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         icon14.toolTip = LanguageMgr.GetTranslation("mark.mornUI.label14");
         icon14_1.toolTip = LanguageMgr.GetTranslation("mark.mornUI.label14");
         initEvent();
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,56,56);
         _loc1_.graphics.endFill();
         _item = new BaseCell(_loc1_);
         _item.setContentSize(68,68);
         PositionUtils.setPos(_item,{
            "x":15,
            "y":28
         });
         addChild(_item);
         conItem.addChild(_item);
         _qualityTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipQualityTxt");
         PositionUtils.setPos(_qualityTxt,"mark.hammerQualityTxtPos");
         addChild(_qualityTxt);
         _wheelMC = ComponentFactory.Instance.creat("asset.mark.hammerMC");
         PositionUtils.setPos(_wheelMC,"mark.wheelPos");
         effectCon.addChild(_wheelMC);
         _progessMC = ComponentFactory.Instance.creat("asset.mark.prgressMC");
         PositionUtils.setPos(_progessMC,"mark.progressPos");
         effectCon.addChild(_progessMC);
         _flashMC = ComponentFactory.Instance.creat("asset.mark.hammerFlash");
         PositionUtils.setPos(_flashMC,"mark.flashPos");
         effectCon.addChild(_flashMC);
         _successMC = ComponentFactory.Instance.creat("asset.mark.hammerSuccessMC");
         addChild(_successMC);
         PositionUtils.setPos(_successMC,"mark.successPos");
         _successMC.visible = false;
         _failMC = ComponentFactory.Instance.creat("asset.mark.hammerFailMC");
         addChild(_failMC);
         PositionUtils.setPos(_failMC,"mark.successPos");
         _failMC.visible = false;
         btnOne.clickHandler = new Handler(hammer,[1]);
         btnTen.clickHandler = new Handler(hammer,[10]);
      }
      
      private function hammer(param1:int) : void
      {
         MarkMgr.inst.reqHammerChip(param1);
      }
      
      private function initEvent() : void
      {
         MarkMgr.inst.addEventListener("hammerResult",hammerResultHandler);
         MarkMgr.inst.addEventListener("markMoney",updateMarkMoney);
      }
      
      private function removeEvent() : void
      {
         MarkMgr.inst.removeEventListener("hammerResult",hammerResultHandler);
         MarkMgr.inst.removeEventListener("markMoney",updateMarkMoney);
         if(_failMC)
         {
            _failMC.removeEventListener("enterFrame",frameHandler2);
         }
         if(_successMC)
         {
            _successMC.removeEventListener("enterFrame",frameHandler);
         }
         if(_progessMC)
         {
            _progessMC.removeEventListener("enterFrame",frameHandler1);
         }
      }
      
      private function hammerResultHandler(param1:MarkEvent) : void
      {
         _result = param1.data.result;
         _cnt = param1.data.cnt;
         _wheelMC.play();
         _progessMC.gotoAndPlay(1);
         _progessMC.visible = true;
         _progessMC.addEventListener("enterFrame",frameHandler1);
         _flashMC.play();
         _flashMC.visible = true;
         _successMC.gotoAndStop(1);
         btnOne.disabled = true;
         btnTen.disabled = true;
      }
      
      private function frameHandler(param1:Event) : void
      {
         if(!_successMC)
         {
            return;
         }
         if(_successMC.currentFrame == _successMC.totalFrames)
         {
            _successMC.removeEventListener("enterFrame",frameHandler);
            _successMC.stop();
            _successMC.visible = false;
            _flashMC.stop();
            btnOne.disabled = _cnt > 0;
            btnTen.disabled = _cnt > 0;
            if(_cnt > 0)
            {
               MarkMgr.inst.reqHammerChip(_cnt);
            }
            updateInfo();
         }
      }
      
      private function frameHandler2(param1:Event) : void
      {
         if(!_failMC)
         {
            return;
         }
         if(_failMC.currentFrame == _failMC.totalFrames)
         {
            _failMC.removeEventListener("enterFrame",frameHandler2);
            _failMC.stop();
            _failMC.visible = false;
            _flashMC.stop();
            btnOne.disabled = _cnt > 0;
            btnTen.disabled = _cnt > 0;
            if(_cnt > 0)
            {
               MarkMgr.inst.reqHammerChip(_cnt);
            }
            updateInfo();
         }
      }
      
      private function frameHandler1(param1:Event) : void
      {
         if(!_progessMC)
         {
            return;
         }
         if(_progessMC.currentFrame == 60)
         {
            if(_result)
            {
               _progessMC.removeEventListener("enterFrame",frameHandler1);
               _progessMC.gotoAndStop(60);
               _progessMC.visible = false;
               _successMC.play();
               _successMC.visible = true;
               _successMC.addEventListener("enterFrame",frameHandler);
            }
         }
         else if(_progessMC.currentFrame == _progessMC.totalFrames)
         {
            btnOne.disabled = false;
            btnTen.disabled = false;
            _progessMC.removeEventListener("enterFrame",frameHandler1);
            _progessMC.stop();
            _progessMC.visible = false;
            _flashMC.stop();
            _failMC.play();
            _failMC.visible = true;
            _failMC.addEventListener("enterFrame",frameHandler2);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         _cnt = 0;
         .super.visible = param1;
         var _loc3_:* = false;
         _flashMC.visible = _loc3_;
         _loc3_ = _loc3_;
         _progessMC.visible = _loc3_;
         _successMC.visible = _loc3_;
         _wheelMC.stop();
         var _loc2_:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         if(!_loc2_)
         {
            _item.info = null;
            return;
         }
         updateInfo();
      }
      
      private function updateInfo(param1:MarkEvent = null) : void
      {
         evt = param1;
         var chip:MarkChipData = MarkMgr.inst.model.getChipById(MarkMgr.inst.model.chipItemID);
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(chip.templateId);
         _item.info = itemInfo;
         _item.tipGapV = 10;
         _item.tipGapH = 10;
         _item.tipData = chip;
         var stars:Array = [clipStar1,clipStar2,clipStar3,clipStar4,clipStar5];
         var i:int = 0;
         while(i < stars.length)
         {
            if(i < chip.bornLv + chip.hammerLv)
            {
               stars[i].visible = true;
               stars[i].index = i < chip.bornLv?0:1;
            }
            else
            {
               stars[i].visible = false;
            }
            i = i + 1;
         }
         var character:int = MarkMgr.inst.model.cfgChip[chip.templateId].Character;
         _qualityTxt.text = LanguageMgr.GetTranslation("mark.qualityName",chip.hLv,itemInfo.Name,QualityType.QUALITY_STRING[character]);
         _qualityTxt.textColor = QualityType.QUALITY_COLOR[character];
         var hammerData:MarkHammerTemplateData = MarkMgr.inst.getHammerData(chip.hLv,character);
         lblCost.text = hammerData.Expend.toString();
         var isTop:Boolean = chip.hLv >= MarkMgr.inst.getHammerTopLv(character);
         imgNextLv.visible = !isTop;
         imgTopLv.visible = isTop;
         lblMainPro.text = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + chip.mainPro.type),chip.mainPro.value + chip.mainPro.attachValue);
         lblNextPro.text = LanguageMgr.GetTranslation("mark.propertyNext",chip.mainPro.value + MarkMgr.inst.getAttributeAdd(chip.templateId,chip.mainPro.type));
         imgArrow.visible = !isTop;
         lblNextPro.visible = !isTop;
         var pro:MarkProData = null;
         var props:Array = [lblAttachPro1,lblAttachPro2,lblAttachPro3,lblAttachPro4];
         props.forEach(function(param1:*, param2:int, param3:Array):void
         {
            param1.visible = false;
         });
         var j:int = 0;
         while(j < chip.props.length)
         {
            pro = chip.props[j];
            if(!(j >= props.length || pro.type <= 0))
            {
               props[j].visible = true;
               props[j].text = LanguageMgr.GetTranslation("mark.property",LanguageMgr.GetTranslation("mark.pro" + pro.type),pro.value + pro.attachValue);
            }
            j = j + 1;
         }
         lblDemandCnt.text = MarkMgr.inst.model.markMoney.toString();
         imgAttach.visible = chip.hammerLv + chip.bornLv == 2?false:[2,5,8,11].indexOf(chip.hLv) != -1;
      }
      
      private function updateMarkMoney(param1:MarkEvent) : void
      {
         lblDemandCnt.text = MarkMgr.inst.model.markMoney.toString();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
            _item = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _result = false;
         _cnt = 0;
         _qualityTxt = null;
         if(_progessMC)
         {
            ObjectUtils.disposeObject(_progessMC);
         }
         _progessMC = null;
         if(_wheelMC)
         {
            ObjectUtils.disposeObject(_wheelMC);
         }
         _wheelMC = null;
         if(_flashMC)
         {
            ObjectUtils.disposeObject(_flashMC);
         }
         _flashMC = null;
         if(_successMC)
         {
            ObjectUtils.disposeObject(_successMC);
         }
         _successMC = null;
      }
   }
}
