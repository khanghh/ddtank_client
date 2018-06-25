package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemPointTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _propertyNameTxt:FilterFrameText;
      
      private var _propertyValueTxt:FilterFrameText;
      
      private var _possibleNameTxt:FilterFrameText;
      
      private var _possibleValueTxt:FilterFrameText;
      
      private var _propertyValueList:Array;
      
      private var _possibleValeList:Array;
      
      private var _propertyValueTextFormatList:Vector.<TextFormat>;
      
      private var _propertyValueGlowFilterList:Vector.<GlowFilter>;
      
      private var _possibleValueTxtColorList:Array;
      
      private var _honorExpSprite:Sprite;
      
      private var _honorTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _lvAddPropertyTxtSprite:Sprite;
      
      private var _lvAddPropertyTxtList:Vector.<FilterFrameText>;
      
      private var _bg2:Bitmap;
      
      private var _statusNameTxt:FilterFrameText;
      
      private var _statusValueTxt:FilterFrameText;
      
      private var _currentPropertyTxt:FilterFrameText;
      
      private var _statusValueList:Array;
      
      public function TotemPointTipView()
      {
         _possibleValueTxtColorList = [16752450,9634815,35314,9035310,16727331];
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         initData();
         initView();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         _propertyValueTextFormatList = new Vector.<TextFormat>();
         _propertyValueGlowFilterList = new Vector.<GlowFilter>();
         for(i = 1; i <= 7; )
         {
            _propertyValueTextFormatList.push(ComponentFactory.Instance.model.getSet("totem.totemWindow.propertyName" + i + ".tf"));
            _propertyValueGlowFilterList.push(ComponentFactory.Instance.model.getSet("totem.totemWindow.propertyName" + i + ".gf"));
            i++;
         }
         _propertyValueList = LanguageMgr.GetTranslation("ddt.totem.sevenProperty").split(",");
         _possibleValeList = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.possibleValueTxt").split(",");
         _statusValueList = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.statusValueTxt").split(",");
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmpTxt:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.leftView.tipBg");
         _propertyNameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.propertyNameTxt");
         _propertyNameTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.propertyNameTxt");
         _propertyValueTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.propertyValueTxt");
         _possibleNameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.possibleNameTxt");
         _possibleNameTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.possibleNameTxt");
         _possibleValueTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.possibleValueTxt");
         _honorExpSprite = ComponentFactory.Instance.creatCustomObject("totem.totemPointTip.honorExpSprite");
         _honorTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.honor");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.exp");
         _honorExpSprite.addChild(_honorTxt);
         _honorExpSprite.addChild(_expTxt);
         _lvAddPropertyTxtSprite = ComponentFactory.Instance.creatCustomObject("totem.totemPointTip.lvAddPropertySprite");
         _lvAddPropertyTxtList = new Vector.<FilterFrameText>();
         for(i = 0; i < 10; )
         {
            tmpTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.lvAddProperty");
            tmpTxt.x = i % 2 * 112;
            tmpTxt.y = int(i / 2) * 18;
            _lvAddPropertyTxtSprite.addChild(tmpTxt);
            _lvAddPropertyTxtList.push(tmpTxt);
            i++;
         }
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.totem.leftView.tipBg2");
         _statusNameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.statusNameTxt");
         _statusNameTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.statusNameTxt");
         _statusValueTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.statusValueTxt");
         _currentPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.currentPropertyTxt");
         _currentPropertyTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.currentPropertyTxt");
         addChild(_bg);
         addChild(_bg2);
         addChild(_propertyNameTxt);
         addChild(_propertyValueTxt);
         addChild(_possibleNameTxt);
         addChild(_possibleValueTxt);
         addChild(_statusNameTxt);
         addChild(_statusValueTxt);
         addChild(_honorExpSprite);
         addChild(_lvAddPropertyTxtSprite);
         addChild(_currentPropertyTxt);
      }
      
      public function show(totemData:TotemDataVo, isCurCanClickTotem:Boolean, isLighted:Boolean) : void
      {
         var possible:int = 0;
         var totemSignCount:int = 0;
         var i:int = 0;
         var tmp:* = null;
         var lv:int = 0;
         var index2:int = 0;
         var propertyStr:* = null;
         var value2:int = 0;
         if(isCurCanClickTotem)
         {
            showStatus1();
         }
         else
         {
            showStatus2();
         }
         var index:int = totemData.Location - 1;
         var value:int = getValueByIndex(index,totemData);
         _propertyValueTxt.text = _propertyValueList[index] + "+" + value;
         _propertyValueTxt.setTextFormat(_propertyValueTextFormatList[index]);
         _propertyValueTxt.filters = [_propertyValueGlowFilterList[index]];
         if(isCurCanClickTotem)
         {
            possible = totemData.Random;
            if(possible >= 100)
            {
               index = 0;
            }
            else if(possible >= 80 && possible < 100)
            {
               index = 1;
            }
            else if(possible >= 40 && possible < 80)
            {
               index = 2;
            }
            else if(possible >= 20 && possible < 40)
            {
               index = 3;
            }
            else
            {
               index = 4;
            }
            _honorTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.honorTxt",totemData.ConsumeHonor);
            _expTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.expTxt",totemData.ConsumeExp);
            if(PlayerManager.Instance.Self.myHonor < totemData.ConsumeHonor)
            {
               _honorTxt.setTextFormat(new TextFormat(null,null,16711680));
            }
            totemSignCount = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
            if(PlayerManager.Instance.Self.Money + totemSignCount < totemData.ConsumeExp)
            {
               _expTxt.setTextFormat(new TextFormat(null,null,16711680));
            }
         }
         else if(isLighted)
         {
            _statusValueTxt.text = _statusValueList[0];
            _statusValueTxt.setTextFormat(new TextFormat(null,null,15728384));
         }
         else
         {
            _statusValueTxt.text = _statusValueList[1];
            _statusValueTxt.setTextFormat(new TextFormat(null,null,9408399));
         }
         var page:int = totemData.Page;
         var location:int = totemData.Location;
         var dataArray:Array = TotemManager.instance.getSamePageLocationList(page,location);
         var len:int = dataArray.length;
         var layer:int = totemData.Layers - 1;
         var layer2:int = totemData.Layers;
         for(i = 0; i < len; )
         {
            tmp = dataArray[i] as TotemDataVo;
            lv = (page - 1) * 10 + tmp.Layers;
            index2 = tmp.Location - 1;
            propertyStr = _propertyValueList[index2];
            value2 = getValueByIndex(index2,tmp);
            _lvAddPropertyTxtList[i].text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.lvAddPropertyTxt",lv,propertyStr,value2);
            _lvAddPropertyTxtList[i].setTextFormat(_propertyValueTextFormatList[index]);
            if(isLighted && tmp.Layers <= layer2 || !isLighted && tmp.Layers <= layer)
            {
               _lvAddPropertyTxtList[i].setTextFormat(new TextFormat(null,null,null,false));
               _lvAddPropertyTxtList[i].filters = [_propertyValueGlowFilterList[index]];
            }
            else
            {
               _lvAddPropertyTxtList[i].setTextFormat(new TextFormat(null,null,11842740,false));
            }
            i++;
         }
         if(isCurCanClickTotem)
         {
            PositionUtils.setPos(_lvAddPropertyTxtSprite,"totem.totemPointTip.lvAddPropertySpritePos1");
         }
         else
         {
            PositionUtils.setPos(_lvAddPropertyTxtSprite,"totem.totemPointTip.lvAddPropertySpritePos2");
         }
      }
      
      private function showStatus1() : void
      {
         _bg.visible = true;
         _bg2.visible = false;
         _propertyNameTxt.visible = true;
         _propertyValueTxt.visible = true;
         _possibleNameTxt.visible = true;
         _possibleValueTxt.visible = true;
         _statusNameTxt.visible = false;
         _statusValueTxt.visible = false;
         _honorExpSprite.visible = true;
         _lvAddPropertyTxtSprite.visible = true;
         _currentPropertyTxt.visible = false;
      }
      
      private function showStatus2() : void
      {
         _bg.visible = false;
         _bg2.visible = true;
         _propertyNameTxt.visible = true;
         _propertyValueTxt.visible = true;
         _possibleNameTxt.visible = false;
         _possibleValueTxt.visible = false;
         _statusNameTxt.visible = true;
         _statusValueTxt.visible = true;
         _honorExpSprite.visible = false;
         _lvAddPropertyTxtSprite.visible = true;
         _currentPropertyTxt.visible = true;
      }
      
      public function getValueByIndex(index:int, totemData:TotemDataVo) : int
      {
         var value:int = 0;
         switch(int(index))
         {
            case 0:
               value = totemData.AddAttack;
               break;
            case 1:
               value = totemData.AddDefence;
               break;
            case 2:
               value = totemData.AddAgility;
               break;
            case 3:
               value = totemData.AddLuck;
               break;
            case 4:
               value = totemData.AddBlood;
               break;
            case 5:
               value = totemData.AddDamage;
               break;
            case 6:
               value = totemData.AddGuard;
         }
         return value;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _propertyNameTxt = null;
         _propertyValueTxt = null;
         _possibleNameTxt = null;
         _possibleValueTxt = null;
         _propertyValueList = null;
         _possibleValeList = null;
         _propertyValueTextFormatList = null;
         _propertyValueGlowFilterList = null;
         ObjectUtils.disposeObject(_honorTxt);
         _honorTxt = null;
         ObjectUtils.disposeObject(_expTxt);
         _expTxt = null;
         _honorExpSprite = null;
         var _loc3_:int = 0;
         var _loc2_:* = _lvAddPropertyTxtList;
         for each(var tmp in _lvAddPropertyTxtList)
         {
            ObjectUtils.disposeObject(tmp);
         }
         _lvAddPropertyTxtList = null;
         _lvAddPropertyTxtSprite = null;
         _bg2 = null;
         _statusNameTxt = null;
         _statusValueTxt = null;
         _currentPropertyTxt = null;
         _statusValueList = null;
         _possibleValueTxtColorList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
