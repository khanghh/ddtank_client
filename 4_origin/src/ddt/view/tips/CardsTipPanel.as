package ddt.view.tips
{
   import cardSystem.CardManager;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.GrooveInfoManager;
   import cardSystem.data.CardGrooveInfo;
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
   
   public class CardsTipPanel extends BaseTip implements ITip, Disposeable
   {
      
      public static const THISWIDTH:int = 300;
      
      public static const CARDTYPE:Array = [LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard"),LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")];
      
      public static const CARDTYPE_VICE_MAIN:Array = [LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.vice"),LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.main")];
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _cardName:FilterFrameText;
      
      private var _cardType:Bitmap;
      
      private var _cardTypeDetail:FilterFrameText;
      
      private var _cardLevel:Bitmap;
      
      private var _cardLevelDetail:FilterFrameText;
      
      private var _EpDetail:FilterFrameText;
      
      private var _Explain:FilterFrameText;
      
      private var _Quality:FilterFrameText;
      
      private var _QualityDetail:FilterFrameText;
      
      private var _rule1:ScaleBitmapImage;
      
      private var _band:ScaleFrameImage;
      
      private var _propVec:Vector.<FilterFrameText>;
      
      private var _rule2:ScaleBitmapImage;
      
      private var _setsName:FilterFrameText;
      
      private var _setsPropVec:Vector.<FilterFrameText>;
      
      private var _validity:FilterFrameText;
      
      private var _cardInfo:CardInfo;
      
      private var _place:int;
      
      private var _isGroove:Boolean;
      
      private var _cardGrooveInfo:GrooveInfo;
      
      private var _thisHeight:int;
      
      public function CardsTipPanel()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _cardName = null;
         _cardType = null;
         _cardTypeDetail = null;
         _cardLevel = null;
         _rule1 = null;
         _band = null;
         _loc2_ = 0;
         while(_loc2_ < _propVec.length)
         {
            _propVec[_loc2_] = null;
            _loc2_++;
         }
         _propVec = null;
         _rule2 = null;
         _setsName = null;
         _loc1_ = 0;
         while(_loc1_ < _setsPropVec.length)
         {
            _setsPropVec[_loc1_] = null;
            _loc1_++;
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
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
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _propVec[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
            _loc2_++;
         }
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _setsPropVec = new Vector.<FilterFrameText>(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _setsPropVec[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            _loc1_++;
         }
         _validity = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _EpDetail = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.ExpPropTitle");
         PositionUtils.setPos(_EpDetail,"core.cardTipEp.pos");
         _Explain = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.ExplainTitle");
         _Quality = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.QualityTitle");
         _QualityDetail = ComponentFactory.Instance.creatComponentByStylename("cardSystem.Quality");
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.addChildren();
         addChild(_cardName);
         addChild(_cardType);
         addChild(_cardTypeDetail);
         addChild(_cardLevel);
         addChild(_cardLevelDetail);
         addChild(_rule1);
         addChild(_band);
         addChild(_Quality);
         addChild(_QualityDetail);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            addChild(_propVec[_loc2_]);
            _loc2_++;
         }
         addChild(_rule2);
         addChild(_setsName);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            addChild(_setsPropVec[_loc1_]);
            _loc1_++;
         }
         addChild(_validity);
         addChild(_EpDetail);
         addChild(_Explain);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1 is CardInfo)
         {
            _cardInfo = param1 as CardInfo;
            this.visible = true;
            _tipData = _cardInfo;
            _place = _cardInfo.Place;
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
               }
            }
            else
            {
               _isGroove = false;
            }
            upview();
         }
         else if(param1 == null)
         {
            this.visible = false;
         }
         else
         {
            _place = param1 as int;
            if(CardManager.Instance.model.GrooveInfoVector == null)
            {
               _cardGrooveInfo == null;
            }
            else
            {
               _cardGrooveInfo = CardManager.Instance.model.GrooveInfoVector[_place];
            }
            if(_cardGrooveInfo == null)
            {
               this.visible = false;
               if(CardManager.Instance.model.tempCardGroove)
               {
                  this.visible = true;
                  _tipData = CardManager.Instance.model.tempCardGroove;
                  _cardGrooveInfo = CardManager.Instance.model.tempCardGroove;
                  upview();
                  CardManager.Instance.model.tempCardGroove = null;
                  _cardGrooveInfo = null;
               }
            }
            else
            {
               this.visible = true;
               _tipData = _cardGrooveInfo;
               upview();
            }
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
      
      private function showHeadPart() : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_tipData == _cardGrooveInfo)
         {
            _loc6_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
            PositionUtils.setPos(_cardLevelDetail,"core.grooveLevel.pos");
            PositionUtils.setPos(_cardLevel,"core.cardLevelBmpOne.pos");
            _cardLevel.visible = true;
            _cardLevelDetail.visible = true;
            _cardLevelDetail.text = _cardGrooveInfo.Level < 10?"0" + String(_cardGrooveInfo.Level):String(_cardGrooveInfo.Level);
            _cardName.visible = false;
            _cardTypeDetail.visible = false;
            _cardType.visible = false;
            _band.visible = false;
            _EpDetail.visible = true;
            _Quality.visible = false;
            _QualityDetail.visible = false;
            if(_cardGrooveInfo.Level >= 40)
            {
               _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP","0/0");
            }
            else
            {
               _loc3_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
               _loc5_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level + 1),String(_cardGrooveInfo.Type));
               _loc4_ = _cardGrooveInfo.GP - int(_loc3_.Exp);
               _loc1_ = int(_loc5_.Exp) - int(_loc3_.Exp);
               _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP",_loc4_ + "/" + _loc1_);
            }
            _rule1.x = _EpDetail.x;
            _rule1.y = _EpDetail.y + _EpDetail.textHeight + 10;
            _thisHeight = _rule1.y + _rule1.height;
         }
         else
         {
            _cardName.visible = true;
            _cardTypeDetail.visible = true;
            _cardType.visible = true;
            _band.visible = true;
            _EpDetail.visible = false;
            _Quality.visible = true;
            _QualityDetail.visible = true;
            _cardLevel.visible = false;
            _cardLevelDetail.visible = false;
            _cardName.text = _cardInfo.templateInfo.Name;
            _cardTypeDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.typeDetail",CARDTYPE[int(_cardInfo.templateInfo.Property6)],CARDTYPE_VICE_MAIN[_cardInfo.templateInfo.Property8]);
            _Quality.text = LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Quality");
            PositionUtils.setPos(_Quality,"core.cardLevel.pos");
            _QualityDetail.x = _Quality.x + _Quality.textWidth;
            _QualityDetail.y = _Quality.y;
            _band.setFrame(_cardInfo.templateInfo.BindType == 0?2:1);
            _loc2_ = _cardInfo.Level == 30?3:Number(_cardInfo.Level >= 20?2:Number(_cardInfo.Level >= 10?1:0));
            if(_cardInfo.Level == 0)
            {
               _cardName.textColor = 16777215;
            }
            else
            {
               _cardName.textColor = QualityType.QUALITY_COLOR[_loc2_ + 1];
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
            _rule1.x = _cardName.x;
            _rule1.y = _Quality.y + _Quality.textHeight + 10;
            _thisHeight = _rule1.y + _rule1.height;
         }
      }
      
      private function showMiddlePart() : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         if(_tipData == _cardGrooveInfo)
         {
            _loc5_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
            if(int(_loc5_.Attack) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",_cardGrooveInfo.realAttack));
            }
            if(int(_loc5_.Defend) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",_cardGrooveInfo.realDefence));
            }
            if(int(_loc5_.Agility) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",_cardGrooveInfo.realAgility));
            }
            if(int(_loc5_.Lucky) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",_cardGrooveInfo.realLucky));
            }
            if(int(_loc5_.Damage) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Gamage",_cardGrooveInfo.realDamage));
            }
            if(int(_loc5_.Guard) >= 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",_cardGrooveInfo.realGuard));
            }
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               if(_loc4_ < _loc1_.length)
               {
                  _propVec[_loc4_].visible = true;
                  _propVec[_loc4_].text = _loc1_[_loc4_];
                  _propVec[_loc4_].textColor = QualityType.QUALITY_COLOR[5];
                  _propVec[_loc4_].y = _rule1.y + _rule1.height + 8 + 24 * _loc4_;
                  if(_loc4_ == _loc1_.length - 1)
                  {
                     _rule2.x = _propVec[_loc4_].x;
                     _rule2.y = _propVec[_loc4_].y + _propVec[_loc4_].textHeight + 12;
                  }
               }
               else
               {
                  _propVec[_loc4_].visible = false;
               }
               _rule2.x = _propVec[_loc4_].x;
               _rule2.y = _propVec[_loc4_].y + _propVec[_loc4_].textHeight + 12;
               _thisHeight = _rule2.y + _rule2.height;
               _loc4_++;
            }
         }
         else
         {
            _loc2_ = CardTemplateInfoManager.instance.getInfoByCardId(String(_cardInfo.TemplateID),String(_cardInfo.CardType));
            if(!_isGroove)
            {
               if(_cardInfo.templateInfo.Attack != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",Number(_loc2_.AttackRate)) + (int(_loc2_.AddAttack) != 0?int(_loc2_.AddAttack) > 0?"+" + int(_loc2_.AddAttack):int(_loc2_.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
               }
               if(_cardInfo.templateInfo.Defence != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",Number(_loc2_.DefendRate)) + (int(_loc2_.AddDefend) != 0?int(_loc2_.AddDefend) > 0?"+" + int(_loc2_.AddDefend):int(_loc2_.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
               }
               if(_cardInfo.templateInfo.Agility != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",Number(_loc2_.AgilityRate)) + (int(_loc2_.AddAgility) != 0?int(_loc2_.AddAgility) > 0?"+" + int(_loc2_.AddAgility):int(_loc2_.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
               }
               if(_cardInfo.templateInfo.Luck != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",Number(_loc2_.LuckyRate)) + (int(_loc2_.AddLucky) != 0?int(_loc2_.AddLucky) > 0?"+" + int(_loc2_.AddLucky):int(_loc2_.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
               }
               if(parseInt(_cardInfo.templateInfo.Property4) != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Gamage",Number(_loc2_.DamageRate)) + (int(_loc2_.AddDamage) != 0?int(_loc2_.AddDamage) > 0?"+" + int(_loc2_.AddDamage):int(_loc2_.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
               }
               if(parseInt(_cardInfo.templateInfo.Property5) != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",Number(_loc2_.GuardRate)) + (int(_loc2_.AddGuard) != 0?int(_loc2_.AddGuard) > 0?"+" + int(_loc2_.AddGuard):int(_loc2_.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
               }
            }
            else
            {
               if(_cardInfo.templateInfo.Attack != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",Math.floor(_cardGrooveInfo.realAttack * _loc2_.AttackRate * 10) / 10) + (int(_loc2_.AddAttack) != 0?int(_loc2_.AddAttack) > 0?"+" + int(_loc2_.AddAttack):int(_loc2_.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
               }
               if(_cardInfo.templateInfo.Defence != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",Math.floor(_cardGrooveInfo.realDefence * _loc2_.DefendRate * 10) / 10) + (int(_loc2_.AddDefend) != 0?int(_loc2_.AddDefend) > 0?"+" + int(_loc2_.AddDefend):int(_loc2_.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
               }
               if(_cardInfo.templateInfo.Agility != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",Math.floor(_cardGrooveInfo.realAgility * _loc2_.AgilityRate * 10) / 10) + (int(_loc2_.AddAgility) != 0?int(_loc2_.AddAgility) > 0?"+" + int(_loc2_.AddAgility):int(_loc2_.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
               }
               if(_cardInfo.templateInfo.Luck != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",Math.floor(_cardGrooveInfo.realLucky * _loc2_.LuckyRate * 10) / 10) + (int(_loc2_.AddLucky) != 0?int(_loc2_.AddLucky) > 0?"+" + int(_loc2_.AddLucky):int(_loc2_.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
               }
               if(parseInt(_cardInfo.templateInfo.Property4) != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Gamage",Math.floor(_cardGrooveInfo.realDamage * _loc2_.DamageRate * 10) / 10) + (int(_loc2_.AddDamage) != 0?int(_loc2_.AddDamage) > 0?"+" + int(_loc2_.AddDamage):int(_loc2_.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
               }
               if(parseInt(_cardInfo.templateInfo.Property5) != 0)
               {
                  _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",Math.floor(_cardGrooveInfo.realGuard * _loc2_.GuardRate * 10) / 10) + (int(_loc2_.AddGuard) != 0?int(_loc2_.AddGuard) > 0?"+" + int(_loc2_.AddGuard):int(_loc2_.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
               }
            }
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               if(_loc3_ < _loc1_.length)
               {
                  _propVec[_loc3_].visible = true;
                  _propVec[_loc3_].text = _loc1_[_loc3_];
                  _propVec[_loc3_].textColor = QualityType.QUALITY_COLOR[5];
                  _propVec[_loc3_].y = _rule1.y + _rule1.height + 8 + 24 * _loc3_;
                  if(_loc3_ == _loc1_.length - 1)
                  {
                     _rule2.x = _propVec[_loc3_].x;
                     _rule2.y = _propVec[_loc3_].y + _propVec[_loc3_].textHeight + 12;
                  }
               }
               else
               {
                  _propVec[_loc3_].visible = false;
               }
               _loc3_++;
            }
            _thisHeight = _rule2.y + _rule2.height;
         }
      }
      
      private function showButtomPart() : void
      {
         var _loc3_:int = 0;
         var _loc16_:* = undefined;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc2_:* = null;
         var _loc19_:* = undefined;
         var _loc20_:* = null;
         var _loc6_:int = 0;
         var _loc13_:* = undefined;
         var _loc7_:int = 0;
         var _loc14_:* = null;
         var _loc10_:int = 0;
         var _loc9_:* = undefined;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:* = null;
         var _loc15_:* = null;
         var _loc1_:int = 0;
         if(_tipData == _cardGrooveInfo)
         {
            _setsName.visible = false;
            _loc3_ = 0;
            while(_loc3_ < _setsPropVec.length)
            {
               _setsPropVec[_loc3_].visible = false;
               _loc3_++;
            }
            _validity.visible = false;
            _Explain.visible = true;
            _Explain.text = LanguageMgr.GetTranslation("ddt.cardsTipPanel.Groove.epdetai");
            _Explain.y = _thisHeight + 10;
            _thisHeight = _Explain.y + _Explain.textHeight;
         }
         else
         {
            _loc16_ = new Vector.<int>();
            _loc17_ = PlayerManager.Instance.findPlayer(_cardInfo.UserID);
            _loc18_ = _loc17_.cardEquipDic;
            _setsName.visible = true;
            _validity.visible = true;
            _Explain.visible = false;
            var _loc22_:int = 0;
            var _loc21_:* = _loc18_;
            for each(var _loc11_ in _loc18_)
            {
               if(_loc11_.templateInfo.Property7 == _cardInfo.templateInfo.Property7 && _loc11_.Count > -1)
               {
                  if(!_isGroove)
                  {
                     _loc16_.push(_loc11_.Level);
                  }
                  else
                  {
                     _loc2_ = CardManager.Instance.model.GrooveInfoVector[_loc11_.Place];
                     _loc16_.push(_loc2_.Level);
                  }
               }
            }
            _loc16_.sort(compareFun);
            _loc19_ = new Vector.<int>();
            _loc20_ = _loc17_.cardBagDic;
            var _loc24_:int = 0;
            var _loc23_:* = _loc20_;
            for each(var _loc5_ in _loc20_)
            {
               if(_loc5_.templateInfo.Property7 == _cardInfo.templateInfo.Property7)
               {
                  if(!_isGroove)
                  {
                     _loc19_.push(_loc5_.Level);
                  }
                  else
                  {
                     _loc19_.push(_cardGrooveInfo.Level);
                  }
               }
            }
            _loc19_.sort(compareFun);
            _loc6_ = 0;
            _loc13_ = CardManager.Instance.model.setsSortRuleVector;
            _loc7_ = _loc13_.length;
            _loc14_ = "";
            _loc10_ = 0;
            while(_loc10_ < _loc7_)
            {
               if(_loc13_[_loc10_].ID == _cardInfo.templateInfo.Property7)
               {
                  _loc6_ = _loc13_[_loc10_].cardIdVec.length;
                  _loc14_ = _loc13_[_loc10_].name;
                  break;
               }
               _loc10_++;
            }
            _setsName.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.setsName",_loc14_,_loc16_.length,_loc6_);
            if(_loc16_.length > 0)
            {
               _setsName.textColor = 16777215;
            }
            else
            {
               _setsName.textColor = 10066329;
            }
            _setsName.y = _thisHeight + 5;
            _thisHeight = _setsName.y + _setsName.textHeight;
            _loc9_ = CardManager.Instance.model.setsList[_cardInfo.templateInfo.Property7];
            _loc4_ = _loc9_.length;
            _loc8_ = 0;
            while(_loc8_ < 4)
            {
               if(_loc8_ < _loc4_)
               {
                  _setsPropVec[_loc8_].visible = true;
                  _loc12_ = _loc9_[_loc8_].value.split("|");
                  _loc15_ = "";
                  _loc1_ = _loc9_[_loc8_].condition;
                  if(_loc16_.length >= _loc1_)
                  {
                     if(_loc12_.length == 4)
                     {
                        _loc15_ = _loc16_[_loc1_ - 1] == 40?_loc12_[3]:_loc16_[_loc1_ - 1] >= 30?_loc12_[3]:_loc16_[_loc1_ - 1] >= 20?_loc12_[2]:_loc16_[_loc1_ - 1] >= 10?_loc12_[1]:_loc12_[0];
                     }
                     else
                     {
                        _loc15_ = _loc12_[0];
                     }
                     _setsPropVec[_loc8_].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",_loc1_) + "\n    " + _loc9_[_loc8_].Description.replace("{0}",_loc15_);
                     _setsPropVec[_loc8_].textColor = QualityType.QUALITY_COLOR[2];
                  }
                  else
                  {
                     if(_loc12_.length == 4)
                     {
                        if(_loc19_.length >= _loc1_)
                        {
                           _loc15_ = _loc19_[_loc1_ - 1] == 40?_loc12_[3]:_loc19_[_loc1_ - 1] >= 30?_loc12_[3]:_loc19_[_loc1_ - 1] >= 20?_loc12_[2]:_loc19_[_loc1_ - 1] >= 10?_loc12_[1]:_loc12_[0];
                        }
                        else
                        {
                           _loc15_ = _loc12_[0];
                        }
                     }
                     else
                     {
                        _loc15_ = _loc12_[0];
                     }
                     _setsPropVec[_loc8_].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",_loc1_) + "\n    " + _loc9_[_loc8_].Description.replace("{0}",_loc15_);
                     _setsPropVec[_loc8_].textColor = 10066329;
                  }
                  _setsPropVec[_loc8_].y = _thisHeight + 4;
                  _thisHeight = _setsPropVec[_loc8_].y + _setsPropVec[_loc8_].textHeight;
               }
               else
               {
                  _setsPropVec[_loc8_].visible = false;
               }
               _loc8_++;
            }
            _validity.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
            _validity.textColor = 16776960;
            _validity.y = _thisHeight + 10;
            _thisHeight = _validity.y + _validity.textHeight;
         }
      }
      
      private function compareFun(param1:int, param2:int) : Number
      {
         if(param1 < param2)
         {
            return 1;
         }
         if(param1 > param2)
         {
            return -1;
         }
         return 0;
      }
      
      private function upBackground() : void
      {
         _bg.height = _thisHeight + 13;
         _bg.width = 300;
         updateWH();
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
