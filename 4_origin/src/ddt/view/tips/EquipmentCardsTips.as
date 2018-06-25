package ddt.view.tips
{
   import cardSystem.CardManager;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.LaterEquipmentGrooveView;
   import cardSystem.data.CardInfo;
   import cardSystem.data.CardTemplateInfo;
   import cardSystem.data.GrooveInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.data.SetsPropertyInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.QualityType;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import road7th.data.DictionaryData;
   
   public class EquipmentCardsTips extends BaseTip implements ITip, Disposeable
   {
      
      public static const THISWIDTH:int = 350;
      
      public static const CARDTYPE:Array = [LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard"),LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")];
      
      public static const CARDTYPE_VICE_MAIN:Array = [LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.vice"),LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.main")];
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _cardName:FilterFrameText;
      
      private var _cardType:Bitmap;
      
      private var _cardTypeDetail:FilterFrameText;
      
      private var _cardLevel:Bitmap;
      
      private var _cardLevelDetail:FilterFrameText;
      
      private var _rule1:ScaleBitmapImage;
      
      private var _band:ScaleFrameImage;
      
      private var _propVec:Vector.<FilterFrameText>;
      
      private var _rule2:ScaleBitmapImage;
      
      private var _setsName:FilterFrameText;
      
      private var _setsPropVec:Vector.<FilterFrameText>;
      
      private var _validity:FilterFrameText;
      
      private var _cardInfo:CardInfo;
      
      private var _thisHeight:int;
      
      private var _cardGrooveInfo:GrooveInfo;
      
      private var _place:int;
      
      private var _Quality:FilterFrameText;
      
      private var _QualityDetail:FilterFrameText;
      
      private var _laterEquipmentView:LaterEquipmentGrooveView;
      
      private var _isGroove:Boolean;
      
      public function EquipmentCardsTips()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var j:int = 0;
         var n:int = 0;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _cardName = null;
         _cardType = null;
         _cardTypeDetail = null;
         _cardLevel = null;
         _rule1 = null;
         _band = null;
         for(j = 0; j < _propVec.length; )
         {
            _propVec[j] = null;
            j++;
         }
         _propVec = null;
         _rule2 = null;
         _setsName = null;
         for(n = 0; n < _setsPropVec.length; )
         {
            _setsPropVec[n] = null;
            n++;
         }
         _setsPropVec = null;
         _validity = null;
         _cardInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      override protected function init() : void
      {
         var j:int = 0;
         var n:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _rule1 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _rule2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _band = ComponentFactory.Instance.creatComponentByStylename("tipPanel.band");
         _cardName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.name");
         _cardType = ComponentFactory.Instance.creatBitmap("asset.core.tip.GoodsType");
         PositionUtils.setPos(_cardType,"CardsTipPanel.typePos");
         _cardTypeDetail = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.typeDetail");
         _cardLevel = ComponentFactory.Instance.creatBitmap("asset.core.tip.GoodsLevel");
         _cardLevelDetail = ComponentFactory.Instance.creatComponentByStylename("cardSystem.level.big");
         _propVec = new Vector.<FilterFrameText>(4);
         for(j = 0; j < 6; )
         {
            _propVec[j] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
            j++;
         }
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _setsPropVec = new Vector.<FilterFrameText>(4);
         for(n = 0; n < 4; )
         {
            _setsPropVec[n] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText1");
            n++;
         }
         _validity = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _Quality = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.QualityTitle");
         _QualityDetail = ComponentFactory.Instance.creatComponentByStylename("cardSystem.Quality");
         _laterEquipmentView = new LaterEquipmentGrooveView();
         _laterEquipmentView.x = _bg.width + 5;
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         var j:int = 0;
         var n:int = 0;
         super.addChildren();
         addChild(_cardName);
         addChild(_cardType);
         addChild(_cardTypeDetail);
         addChild(_rule1);
         addChild(_band);
         addChild(_Quality);
         addChild(_QualityDetail);
         for(j = 0; j < 6; )
         {
            addChild(_propVec[j]);
            j++;
         }
         addChild(_rule2);
         addChild(_setsName);
         for(n = 0; n < 4; )
         {
            addChild(_setsPropVec[n]);
            n++;
         }
         addChild(_validity);
         addChild(_laterEquipmentView);
         _laterEquipmentView.x = _bg.width + 5;
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data is CardInfo)
         {
            _cardInfo = data as CardInfo;
            this.visible = true;
            _tipData = _cardInfo;
            _place = _cardInfo.Place;
            if(_place == 2 || _place == 4)
            {
               _laterEquipmentView.x = -200;
            }
            else
            {
               _laterEquipmentView.x = _bg.width + 5;
            }
            if(_place < 5)
            {
               if(CardManager.Instance.model.GrooveInfoVector == null)
               {
                  this.visible = false;
               }
               else
               {
                  _cardGrooveInfo = CardManager.Instance.model.GrooveInfoVector[_place];
                  _isGroove = true;
                  _laterEquipmentView.visible = true;
                  laterEquipment(_cardInfo);
               }
            }
            else
            {
               _isGroove = false;
               _laterEquipmentView.visible = false;
            }
            upview();
         }
         else
         {
            this.visible = false;
            _tipData = null;
         }
      }
      
      private function upview() : void
      {
         _thisHeight = 0;
         showHeadPart();
         showMiddlePart();
         showButtomPart();
         upBackground();
      }
      
      private function laterEquipment(cardInfo:CardInfo) : void
      {
         if(!_laterEquipmentView)
         {
            _laterEquipmentView = new LaterEquipmentGrooveView();
         }
         _laterEquipmentView.tipData = cardInfo;
      }
      
      private function showHeadPart() : void
      {
         _cardName.text = _cardInfo.templateInfo.Name;
         _cardTypeDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.typeDetail",CARDTYPE[int(_cardInfo.templateInfo.Property6)],CARDTYPE_VICE_MAIN[_cardInfo.templateInfo.Property8]);
         _Quality.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Quality");
         PositionUtils.setPos(_Quality,"core.cardLevel.pos");
         _QualityDetail.x = _Quality.x + _Quality.textWidth + 10;
         _QualityDetail.y = _Quality.y;
         _band.setFrame(_cardInfo.templateInfo.BindType == 0?2:1);
         var level:int = _cardInfo.Level == 30?3:Number(_cardInfo.Level >= 20?2:Number(_cardInfo.Level >= 10?1:0));
         if(_cardInfo.Level == 0)
         {
            _cardName.textColor = 16777215;
         }
         else
         {
            _cardName.textColor = QualityType.QUALITY_COLOR[level + 1];
         }
         if(_cardInfo.CardType == 1)
         {
            _QualityDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.jin");
         }
         else if(_cardInfo.CardType == 2)
         {
            _QualityDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.yin");
         }
         else if(_cardInfo.CardType == 4)
         {
            _QualityDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.baijin");
         }
         else
         {
            _QualityDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.tong");
         }
         _band.x = 200;
         _band.y = 98;
         _rule1.x = _cardName.x;
         _rule1.y = _Quality.y + _Quality.textHeight + 10;
         _thisHeight = _rule1.y + _rule1.height;
      }
      
      private function showMiddlePart() : void
      {
         var j:int = 0;
         var propArr:Array = [];
         var cardTempleInfo:CardTemplateInfo = CardTemplateInfoManager.instance.getInfoByCardId(String(_cardInfo.TemplateID),String(_cardInfo.CardType));
         if(!_isGroove)
         {
            if(Number(cardTempleInfo.AttackRate) < 1 || int(cardTempleInfo.AddAttack) + _cardInfo.Attack != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack1") + (Number(cardTempleInfo.AttackRate) < 1?cardTempleInfo.AttackRate * 100 + "%":"") + (int(cardTempleInfo.AddAttack) != 0?int(cardTempleInfo.AddAttack) > 0?"+" + int(cardTempleInfo.AddAttack):int(cardTempleInfo.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
            }
            if(Number(cardTempleInfo.DefendRate) < 1 || int(cardTempleInfo.AddDefend) + _cardInfo.Defence != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence1") + (Number(cardTempleInfo.DefendRate) < 1?cardTempleInfo.DefendRate * 100 + "%":"") + (int(cardTempleInfo.AddDefend) != 0?int(cardTempleInfo.AddDefend) > 0?"+" + int(cardTempleInfo.AddDefend):int(cardTempleInfo.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
            }
            if(Number(cardTempleInfo.AgilityRate) < 1 || int(cardTempleInfo.AddAgility) + _cardInfo.Agility != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility1") + (Number(cardTempleInfo.AgilityRate) < 1?cardTempleInfo.AgilityRate * 100 + "%":"") + (int(cardTempleInfo.AddAgility) != 0?int(cardTempleInfo.AddAgility) > 0?"+" + int(cardTempleInfo.AddAgility):int(cardTempleInfo.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
            }
            if(Number(cardTempleInfo.LuckyRate) < 1 || int(cardTempleInfo.AddLucky) + _cardInfo.Luck != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck1") + (Number(cardTempleInfo.LuckyRate) < 1?cardTempleInfo.LuckyRate * 100 + "%":"") + (int(cardTempleInfo.AddLucky) != 0?int(cardTempleInfo.AddLucky) > 0?"+" + int(cardTempleInfo.AddLucky):int(cardTempleInfo.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
            }
            if(Number(cardTempleInfo.DamageRate) < 1 || int(cardTempleInfo.AddDamage) + _cardInfo.Damage != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Damage1") + (Number(cardTempleInfo.DamageRate) < 1?cardTempleInfo.DamageRate * 100 + "%":"") + (int(cardTempleInfo.AddDamage) != 0?int(cardTempleInfo.AddDamage) > 0?"+" + int(cardTempleInfo.AddDamage):int(cardTempleInfo.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
            }
            if(Number(cardTempleInfo.GuardRate) < 1 || int(cardTempleInfo.AddGuard) + _cardInfo.Guard != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard1") + (Number(cardTempleInfo.GuardRate) < 1?cardTempleInfo.GuardRate * 100 + "%":"") + (int(cardTempleInfo.AddGuard) != 0?int(cardTempleInfo.AddGuard) > 0?"+" + int(cardTempleInfo.AddGuard):int(cardTempleInfo.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
            }
         }
         else
         {
            if(int(cardTempleInfo.AddAttack) + _cardInfo.Attack != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack1") + (int(cardTempleInfo.AddAttack) != 0?int(cardTempleInfo.AddAttack) > 0?"+" + int(cardTempleInfo.AddAttack):int(cardTempleInfo.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
            }
            if(int(cardTempleInfo.AddDefend) + _cardInfo.Defence != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence1") + (int(cardTempleInfo.AddDefend) != 0?int(cardTempleInfo.AddDefend) > 0?"+" + int(cardTempleInfo.AddDefend):int(cardTempleInfo.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
            }
            if(int(cardTempleInfo.AddAgility) + _cardInfo.Agility != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility1") + (int(cardTempleInfo.AddAgility) != 0?int(cardTempleInfo.AddAgility) > 0?"+" + int(cardTempleInfo.AddAgility):int(cardTempleInfo.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
            }
            if(int(cardTempleInfo.AddLucky) + _cardInfo.Luck != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck1") + (int(cardTempleInfo.AddLucky) != 0?int(cardTempleInfo.AddLucky) > 0?"+" + int(cardTempleInfo.AddLucky):int(cardTempleInfo.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
            }
            if(int(cardTempleInfo.AddDamage) + _cardInfo.Damage != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Damage1") + (int(cardTempleInfo.AddDamage) != 0?int(cardTempleInfo.AddDamage) > 0?"+" + int(cardTempleInfo.AddDamage):int(cardTempleInfo.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
            }
            if(int(cardTempleInfo.AddGuard) + _cardInfo.Guard != 0)
            {
               propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard1") + (int(cardTempleInfo.AddGuard) != 0?int(cardTempleInfo.AddGuard) > 0?"+" + int(cardTempleInfo.AddGuard):int(cardTempleInfo.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
            }
         }
         j = 0;
         while(j < 6)
         {
            if(j < propArr.length)
            {
               _propVec[j].visible = true;
               _propVec[j].text = propArr[j];
               _propVec[j].textColor = QualityType.QUALITY_COLOR[5];
               _propVec[j].y = _rule1.y + _rule1.height + 8 + 24 * j;
               if(j == propArr.length - 1)
               {
                  _rule2.x = _propVec[j].x;
                  _rule2.y = _propVec[j].y + _propVec[j].textHeight + 12;
               }
            }
            else
            {
               _propVec[j].visible = false;
            }
            j++;
         }
         _thisHeight = _rule2.y + _rule2.height;
      }
      
      private function showButtomPart() : void
      {
         var grooveinfo:* = null;
         var i:int = 0;
         var j:int = 0;
         var valueArr:* = null;
         var value:* = null;
         var con:int = 0;
         var equipLevelVec:Vector.<int> = new Vector.<int>();
         var playerInfo:PlayerInfo = PlayerManager.Instance.findPlayer(_cardInfo.UserID);
         var equipCard:DictionaryData = playerInfo.cardEquipDic;
         var _loc21_:int = 0;
         var _loc20_:* = equipCard;
         for each(var cInfo in equipCard)
         {
            if(cInfo.templateInfo.Property7 == _cardInfo.templateInfo.Property7 && cInfo.Count > -1)
            {
               if(!_isGroove)
               {
                  equipLevelVec.push(cInfo.Level);
               }
               else
               {
                  grooveinfo = CardManager.Instance.model.GrooveInfoVector[cInfo.Place];
                  equipLevelVec.push(grooveinfo.Level);
               }
            }
         }
         equipLevelVec.sort(compareFun);
         var bagLevelVec:Vector.<int> = new Vector.<int>();
         var bagCard:DictionaryData = playerInfo.cardBagDic;
         var _loc23_:int = 0;
         var _loc22_:* = bagCard;
         for each(var bagCInfo in bagCard)
         {
            if(bagCInfo.templateInfo.Property7 == _cardInfo.templateInfo.Property7)
            {
               if(!_isGroove)
               {
                  bagLevelVec.push(bagCInfo.Level);
               }
               else
               {
                  bagLevelVec.push(_cardGrooveInfo.Level);
               }
            }
         }
         bagLevelVec.sort(compareFun);
         var m:int = 0;
         var setsVec:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var len:int = setsVec.length;
         var name:String = "";
         for(i = 0; i < len; )
         {
            if(setsVec[i].ID == _cardInfo.templateInfo.Property7)
            {
               m = setsVec[i].cardIdVec.length;
               name = setsVec[i].name;
               break;
            }
            i++;
         }
         _setsName.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.setsName",name,equipLevelVec.length,m);
         if(equipLevelVec.length > 0)
         {
            _setsName.textColor = 16777215;
         }
         else
         {
            _setsName.textColor = 10066329;
         }
         _setsName.y = _thisHeight + 5;
         _thisHeight = _setsName.y + _setsName.textHeight;
         var setsInfoVec:Vector.<SetsPropertyInfo> = CardManager.Instance.model.setsList[_cardInfo.templateInfo.Property7];
         var len2:int = setsInfoVec.length;
         for(j = 0; j < 4; )
         {
            if(j < len2)
            {
               _setsPropVec[j].visible = true;
               valueArr = setsInfoVec[j].value.split("|");
               value = "";
               con = setsInfoVec[j].condition;
               if(equipLevelVec.length >= con)
               {
                  if(valueArr.length == 4)
                  {
                     value = equipLevelVec[con - 1] == 40?valueArr[3]:equipLevelVec[con - 1] >= 30?valueArr[3]:equipLevelVec[con - 1] >= 20?valueArr[2]:equipLevelVec[con - 1] >= 10?valueArr[1]:valueArr[0];
                  }
                  else
                  {
                     value = valueArr[0];
                  }
                  _setsPropVec[j].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",con) + "\n    " + setsInfoVec[j].Description.replace("{0}",value);
                  _setsPropVec[j].textColor = QualityType.QUALITY_COLOR[2];
               }
               else
               {
                  if(valueArr.length == 4)
                  {
                     if(bagLevelVec.length >= con)
                     {
                        value = bagLevelVec[con - 1] == 40?valueArr[3]:bagLevelVec[con - 1] >= 30?valueArr[3]:bagLevelVec[con - 1] >= 20?valueArr[2]:bagLevelVec[con - 1] >= 10?valueArr[1]:valueArr[0];
                     }
                     else
                     {
                        value = valueArr[0];
                     }
                  }
                  else
                  {
                     value = valueArr[0];
                  }
                  _setsPropVec[j].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",con) + "\n    " + setsInfoVec[j].Description.replace("{0}",value);
                  _setsPropVec[j].textColor = 10066329;
               }
               _setsPropVec[j].y = _thisHeight + 4;
               _thisHeight = _setsPropVec[j].y + _setsPropVec[j].textHeight;
            }
            else
            {
               _setsPropVec[j].visible = false;
            }
            j++;
         }
         _validity.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
         _validity.textColor = 16776960;
         _validity.y = _thisHeight + 10;
         _thisHeight = _validity.y + _validity.textHeight;
      }
      
      private function compareFun(x:int, y:int) : Number
      {
         if(x < y)
         {
            return 1;
         }
         if(x > y)
         {
            return -1;
         }
         return 0;
      }
      
      private function upBackground() : void
      {
         _bg.height = _thisHeight + 13;
         _bg.width = 350;
         updateWH();
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
