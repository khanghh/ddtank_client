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
         var _loc1_:int = 0;
         _propertyValueTextFormatList = new Vector.<TextFormat>();
         _propertyValueGlowFilterList = new Vector.<GlowFilter>();
         _loc1_ = 1;
         while(_loc1_ <= 7)
         {
            _propertyValueTextFormatList.push(ComponentFactory.Instance.model.getSet("totem.totemWindow.propertyName" + _loc1_ + ".tf"));
            _propertyValueGlowFilterList.push(ComponentFactory.Instance.model.getSet("totem.totemWindow.propertyName" + _loc1_ + ".gf"));
            _loc1_++;
         }
         _propertyValueList = LanguageMgr.GetTranslation("ddt.totem.sevenProperty").split(",");
         _possibleValeList = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.possibleValueTxt").split(",");
         _statusValueList = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.statusValueTxt").split(",");
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("totem.totemPointTip.lvAddProperty");
            _loc1_.x = _loc2_ % 2 * 112;
            _loc1_.y = int(_loc2_ / 2) * 18;
            _lvAddPropertyTxtSprite.addChild(_loc1_);
            _lvAddPropertyTxtList.push(_loc1_);
            _loc2_++;
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
      
      public function show(param1:TotemDataVo, param2:Boolean, param3:Boolean) : void
      {
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc18_:* = null;
         var _loc10_:int = 0;
         var _loc19_:int = 0;
         var _loc16_:* = null;
         var _loc12_:int = 0;
         if(param2)
         {
            showStatus1();
         }
         else
         {
            showStatus2();
         }
         var _loc5_:int = param1.Location - 1;
         var _loc17_:int = getValueByIndex(_loc5_,param1);
         _propertyValueTxt.text = _propertyValueList[_loc5_] + "+" + _loc17_;
         _propertyValueTxt.setTextFormat(_propertyValueTextFormatList[_loc5_]);
         _propertyValueTxt.filters = [_propertyValueGlowFilterList[_loc5_]];
         if(param2)
         {
            _loc14_ = param1.Random;
            if(_loc14_ >= 100)
            {
               _loc5_ = 0;
            }
            else if(_loc14_ >= 80 && _loc14_ < 100)
            {
               _loc5_ = 1;
            }
            else if(_loc14_ >= 40 && _loc14_ < 80)
            {
               _loc5_ = 2;
            }
            else if(_loc14_ >= 20 && _loc14_ < 40)
            {
               _loc5_ = 3;
            }
            else
            {
               _loc5_ = 4;
            }
            _honorTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.honorTxt",param1.ConsumeHonor);
            _expTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.expTxt",param1.ConsumeExp);
            if(PlayerManager.Instance.Self.myHonor < param1.ConsumeHonor)
            {
               _honorTxt.setTextFormat(new TextFormat(null,null,16711680));
            }
            _loc7_ = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
            if(PlayerManager.Instance.Self.Money + _loc7_ < param1.ConsumeExp)
            {
               _expTxt.setTextFormat(new TextFormat(null,null,16711680));
            }
         }
         else if(param3)
         {
            _statusValueTxt.text = _statusValueList[0];
            _statusValueTxt.setTextFormat(new TextFormat(null,null,15728384));
         }
         else
         {
            _statusValueTxt.text = _statusValueList[1];
            _statusValueTxt.setTextFormat(new TextFormat(null,null,9408399));
         }
         var _loc15_:int = param1.Page;
         var _loc8_:int = param1.Location;
         var _loc6_:Array = TotemManager.instance.getSamePageLocationList(_loc15_,_loc8_);
         var _loc11_:int = _loc6_.length;
         var _loc9_:int = param1.Layers - 1;
         var _loc4_:int = param1.Layers;
         _loc13_ = 0;
         while(_loc13_ < _loc11_)
         {
            _loc18_ = _loc6_[_loc13_] as TotemDataVo;
            _loc10_ = (_loc15_ - 1) * 10 + _loc18_.Layers;
            _loc19_ = _loc18_.Location - 1;
            _loc16_ = _propertyValueList[_loc19_];
            _loc12_ = getValueByIndex(_loc19_,_loc18_);
            _lvAddPropertyTxtList[_loc13_].text = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.lvAddPropertyTxt",_loc10_,_loc16_,_loc12_);
            _lvAddPropertyTxtList[_loc13_].setTextFormat(_propertyValueTextFormatList[_loc5_]);
            if(param3 && _loc18_.Layers <= _loc4_ || !param3 && _loc18_.Layers <= _loc9_)
            {
               _lvAddPropertyTxtList[_loc13_].setTextFormat(new TextFormat(null,null,null,false));
               _lvAddPropertyTxtList[_loc13_].filters = [_propertyValueGlowFilterList[_loc5_]];
            }
            else
            {
               _lvAddPropertyTxtList[_loc13_].setTextFormat(new TextFormat(null,null,11842740,false));
            }
            _loc13_++;
         }
         if(param2)
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
      
      public function getValueByIndex(param1:int, param2:TotemDataVo) : int
      {
         var _loc3_:int = 0;
         switch(int(param1))
         {
            case 0:
               _loc3_ = param2.AddAttack;
               break;
            case 1:
               _loc3_ = param2.AddDefence;
               break;
            case 2:
               _loc3_ = param2.AddAgility;
               break;
            case 3:
               _loc3_ = param2.AddLuck;
               break;
            case 4:
               _loc3_ = param2.AddBlood;
               break;
            case 5:
               _loc3_ = param2.AddDamage;
               break;
            case 6:
               _loc3_ = param2.AddGuard;
         }
         return _loc3_;
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
         for each(var _loc1_ in _lvAddPropertyTxtList)
         {
            ObjectUtils.disposeObject(_loc1_);
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
