package mark
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.utils.Dictionary;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkProData;
   import mark.data.MarkSuitTemplateData;
   import morn.core.components.Label;
   
   public class MarkChipTip extends BaseTip implements ITip
   {
       
      
      private var _display = null;
      
      private var _qualityTxt:FilterFrameText = null;
      
      public function MarkChipTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _display = ComponentFactory.Instance.creatCustomObject("mark.tipView");
         _qualityTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipQualityTxt");
         PositionUtils.setPos(_qualityTxt,"mark.tipQualityTxtPos");
         _display.addChild(_qualityTxt);
         _display.descriptTxt.text = LanguageMgr.GetTranslation("mark.mornUI.label3");
         _display.label2.text = LanguageMgr.GetTranslation("mark.mornUI.label2");
         super.init();
      }
      
      override public function set tipData(param1:Object) : void
      {
         value = param1;
         if(value == null)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         var chip:MarkChipData = value as MarkChipData;
         var chipTemplate:MarkChipTemplateData = MarkMgr.inst.model.cfgChip[chip.templateId] as MarkChipTemplateData;
         var itemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(chipTemplate.Id);
         var stars:Array = [_display.clipStar1,_display.clipStar2,_display.clipStar3,_display.clipStar4,_display.clipStar5];
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
         _display.isBind.index = !!chip.isbind?0:1;
         _display.qualityTxt.text = QualityType.QUALITY_STRING[chipTemplate.Character];
         _display.qualityTxt.color = QualityType.QUALITY_COLOR[chipTemplate.Character];
         _qualityTxt.text = LanguageMgr.GetTranslation("mark.chipTipName",chip.hLv,itemInfo.Name);
         _qualityTxt.textColor = QualityType.QUALITY_COLOR[chipTemplate.Character];
         _display.lblMainPro.htmlText = LanguageMgr.GetTranslation("mark.tipBaseName",LanguageMgr.GetTranslation("mark.pro" + chip.mainPro.type));
         _display.lblMainProValue.htmlText = LanguageMgr.GetTranslation("mark.tipValue",LanguageMgr.GetTranslation("mark.tipBaseValue",chip.mainPro.value),chip.mainPro.attachValue > 0?LanguageMgr.GetTranslation("mark.tipHammerValue",chip.mainPro.attachValue):"");
         _display.lblMainProValue.x = _display.lblMainPro.x + _display.lblMainPro.width + 3;
         var offsetY:int = 172;
         var pro:MarkProData = null;
         var propLbls:Array = [_display.lblPro1,_display.lblPro2,_display.lblPro3,_display.lblPro4];
         var props:Array = [_display.lblProValue1,_display.lblProValue2,_display.lblProValue3,_display.lblProValue4];
         var proCons:Array = [_display.conPro0,_display.conPro1,_display.conPro2,_display.conPro3];
         proCons.forEach(function(param1:*, param2:int, param3:Array):void
         {
            param1.visible = false;
         });
         var j:int = 0;
         while(j < chip.props.length)
         {
            pro = chip.props[j];
            if(!(j >= props.length || pro.type <= 0))
            {
               propLbls[j].htmlText = LanguageMgr.GetTranslation(j + 1 < chip.bornLv?"mark.tipBaseName":"mark.tipAddName",LanguageMgr.GetTranslation("mark.pro" + pro.type));
               props[j].htmlText = LanguageMgr.GetTranslation("mark.tipValue",LanguageMgr.GetTranslation("mark.tipBaseValue",pro.value),pro.attachValue > 0?LanguageMgr.GetTranslation("mark.tipHammerValue",pro.attachValue):"");
               proCons[j].visible = true;
               props[j].x = propLbls[j].x + propLbls[j].width + 3;
               proCons[j].y = offsetY;
               offsetY = offsetY + (proCons[j].height + 5);
            }
            j = j + 1;
         }
         if(chip.props.length != 0)
         {
            offsetY = offsetY + 5;
            _display.line1.visible = true;
            _display.line1.y = offsetY;
            offsetY = offsetY + 5;
         }
         else
         {
            _display.line1.visible = false;
         }
         offsetY = offsetY + 3;
         var lbls:Array = [_display.lblSuit1,_display.lblSuit2];
         var values:Array = [_display.lblSuitEffect1,_display.lblSuitEffect2];
         var suitCons:Array = [_display.conSuit0,_display.conSuit1];
         suitCons.forEach(function(param1:*, param2:int, param3:Array):void
         {
            param1.visible = false;
         });
         var k:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = MarkMgr.inst.model.cfgSuit;
         for each(it in MarkMgr.inst.model.cfgSuit)
         {
            if(it.SetId == chipTemplate.SetID && k < lbls.length)
            {
               lbls[k].text = LanguageMgr.GetTranslation("mark.suitName",it.Demand);
               values[k].text = it.Explain;
               suitCons[k].visible = true;
               suitCons[k].y = offsetY;
               offsetY = offsetY + suitCons[k].height;
               k = Number(k) + 1;
            }
         }
         if(!MarkMgr.inst.isOther)
         {
            var filterArr:Array = ComponentFactory.Instance.creatFilters("grayFilter");
            if(chip.position > 1000 || chip.position < 0)
            {
               (values[0] as Label).filters = filterArr;
               (lbls[0] as Label).filters = filterArr;
               (lbls[1] as Label).filters = filterArr;
               (values[1] as Label).filters = filterArr;
            }
            else
            {
               var dic:Dictionary = MarkMgr.inst.model.getSuitData();
               var num:int = dic[MarkMgr.inst.model.cfgChip[chip.templateId].SetID].length;
               if(num >= 2 && num < 4)
               {
                  (values[0] as Label).filters = null;
                  (lbls[0] as Label).filters = null;
                  (values[1] as Label).filters = filterArr;
                  (lbls[1] as Label).filters = filterArr;
               }
               else if(num < 2)
               {
                  (values[0] as Label).filters = filterArr;
                  (lbls[0] as Label).filters = filterArr;
                  (lbls[1] as Label).filters = filterArr;
                  (values[1] as Label).filters = filterArr;
               }
               else
               {
                  (values[0] as Label).filters = null;
                  (lbls[0] as Label).filters = null;
                  (lbls[1] as Label).filters = null;
                  (values[1] as Label).filters = null;
               }
            }
         }
         _display.line2.y = offsetY;
         offsetY = offsetY + 8;
         _display.descriptTxt.y = offsetY;
         _display.imgBg.height = offsetY + 69;
      }
      
      override public function get width() : Number
      {
         return 205;
      }
      
      override public function get height() : Number
      {
         return _display.imgBg.height;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_display)
         {
            addChild(_display);
         }
      }
      
      override public function dispose() : void
      {
         if(_display)
         {
            ObjectUtils.disposeAllChildren(_display);
         }
         _display = null;
         _qualityTxt = null;
         super.dispose();
      }
   }
}
