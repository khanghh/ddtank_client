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
         while(_loc2_ < 6)
         {
            _propVec[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
            _loc2_++;
         }
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _setsPropVec = new Vector.<FilterFrameText>(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _setsPropVec[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText1");
            _loc1_++;
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.addChildren();
         addChild(_cardName);
         addChild(_cardType);
         addChild(_cardTypeDetail);
         addChild(_rule1);
         addChild(_band);
         addChild(_Quality);
         addChild(_QualityDetail);
         _loc2_ = 0;
         while(_loc2_ < 6)
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
         addChild(_laterEquipmentView);
         _laterEquipmentView.x = _bg.width + 5;
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
      
      private function laterEquipment(param1:CardInfo) : void
      {
         if(!_laterEquipmentView)
         {
            _laterEquipmentView = new LaterEquipmentGrooveView();
         }
         _laterEquipmentView.tipData = param1;
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
         var _loc1_:int = _cardInfo.Level == 30?3:Number(_cardInfo.Level >= 20?2:Number(_cardInfo.Level >= 10?1:0));
         if(_cardInfo.Level == 0)
         {
            _cardName.textColor = 16777215;
         }
         else
         {
            _cardName.textColor = QualityType.QUALITY_COLOR[_loc1_ + 1];
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
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:CardTemplateInfo = CardTemplateInfoManager.instance.getInfoByCardId(String(_cardInfo.TemplateID),String(_cardInfo.CardType));
         if(!_isGroove)
         {
            if(Number(_loc2_.AttackRate) < 1 || int(_loc2_.AddAttack) + _cardInfo.Attack != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack1") + (Number(_loc2_.AttackRate) < 1?_loc2_.AttackRate * 100 + "%":"") + (int(_loc2_.AddAttack) != 0?int(_loc2_.AddAttack) > 0?"+" + int(_loc2_.AddAttack):int(_loc2_.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
            }
            if(Number(_loc2_.DefendRate) < 1 || int(_loc2_.AddDefend) + _cardInfo.Defence != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence1") + (Number(_loc2_.DefendRate) < 1?_loc2_.DefendRate * 100 + "%":"") + (int(_loc2_.AddDefend) != 0?int(_loc2_.AddDefend) > 0?"+" + int(_loc2_.AddDefend):int(_loc2_.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
            }
            if(Number(_loc2_.AgilityRate) < 1 || int(_loc2_.AddAgility) + _cardInfo.Agility != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility1") + (Number(_loc2_.AgilityRate) < 1?_loc2_.AgilityRate * 100 + "%":"") + (int(_loc2_.AddAgility) != 0?int(_loc2_.AddAgility) > 0?"+" + int(_loc2_.AddAgility):int(_loc2_.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
            }
            if(Number(_loc2_.LuckyRate) < 1 || int(_loc2_.AddLucky) + _cardInfo.Luck != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck1") + (Number(_loc2_.LuckyRate) < 1?_loc2_.LuckyRate * 100 + "%":"") + (int(_loc2_.AddLucky) != 0?int(_loc2_.AddLucky) > 0?"+" + int(_loc2_.AddLucky):int(_loc2_.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
            }
            if(Number(_loc2_.DamageRate) < 1 || int(_loc2_.AddDamage) + _cardInfo.Damage != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Damage1") + (Number(_loc2_.DamageRate) < 1?_loc2_.DamageRate * 100 + "%":"") + (int(_loc2_.AddDamage) != 0?int(_loc2_.AddDamage) > 0?"+" + int(_loc2_.AddDamage):int(_loc2_.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
            }
            if(Number(_loc2_.GuardRate) < 1 || int(_loc2_.AddGuard) + _cardInfo.Guard != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard1") + (Number(_loc2_.GuardRate) < 1?_loc2_.GuardRate * 100 + "%":"") + (int(_loc2_.AddGuard) != 0?int(_loc2_.AddGuard) > 0?"+" + int(_loc2_.AddGuard):int(_loc2_.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
            }
         }
         else
         {
            if(int(_loc2_.AddAttack) + _cardInfo.Attack != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack1") + (int(_loc2_.AddAttack) != 0?int(_loc2_.AddAttack) > 0?"+" + int(_loc2_.AddAttack):int(_loc2_.AddAttack):"") + (_cardInfo.Attack != 0?"(" + (_cardInfo.Attack > 0?"+" + _cardInfo.Attack:_cardInfo.Attack) + ")":""));
            }
            if(int(_loc2_.AddDefend) + _cardInfo.Defence != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence1") + (int(_loc2_.AddDefend) != 0?int(_loc2_.AddDefend) > 0?"+" + int(_loc2_.AddDefend):int(_loc2_.AddDefend):"") + (_cardInfo.Defence != 0?"(" + (_cardInfo.Defence > 0?"+" + _cardInfo.Defence:_cardInfo.Defence) + ")":""));
            }
            if(int(_loc2_.AddAgility) + _cardInfo.Agility != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility1") + (int(_loc2_.AddAgility) != 0?int(_loc2_.AddAgility) > 0?"+" + int(_loc2_.AddAgility):int(_loc2_.AddAgility):"") + (_cardInfo.Agility != 0?"(" + (_cardInfo.Agility > 0?"+" + _cardInfo.Agility:_cardInfo.Agility) + ")":""));
            }
            if(int(_loc2_.AddLucky) + _cardInfo.Luck != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck1") + (int(_loc2_.AddLucky) != 0?int(_loc2_.AddLucky) > 0?"+" + int(_loc2_.AddLucky):int(_loc2_.AddLucky):"") + (_cardInfo.Luck != 0?"(" + (_cardInfo.Luck > 0?"+" + _cardInfo.Luck:_cardInfo.Luck) + ")":""));
            }
            if(int(_loc2_.AddDamage) + _cardInfo.Damage != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Damage1") + (int(_loc2_.AddDamage) != 0?int(_loc2_.AddDamage) > 0?"+" + int(_loc2_.AddDamage):int(_loc2_.AddDamage):"") + (_cardInfo.Damage != 0?"(" + (_cardInfo.Damage > 0?"+" + _cardInfo.Damage:_cardInfo.Damage) + ")":""));
            }
            if(int(_loc2_.AddGuard) + _cardInfo.Guard != 0)
            {
               _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard1") + (int(_loc2_.AddGuard) != 0?int(_loc2_.AddGuard) > 0?"+" + int(_loc2_.AddGuard):int(_loc2_.AddGuard):"") + (_cardInfo.Guard != 0?"(" + (_cardInfo.Guard > 0?"+" + _cardInfo.Guard:_cardInfo.Guard) + ")":""));
            }
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
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
      
      private function showButtomPart() : void
      {
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc1_:int = 0;
         var _loc15_:Vector.<int> = new Vector.<int>();
         var _loc16_:PlayerInfo = PlayerManager.Instance.findPlayer(_cardInfo.UserID);
         var _loc17_:DictionaryData = _loc16_.cardEquipDic;
         var _loc21_:int = 0;
         var _loc20_:* = _loc17_;
         for each(var _loc10_ in _loc17_)
         {
            if(_loc10_.templateInfo.Property7 == _cardInfo.templateInfo.Property7 && _loc10_.Count > -1)
            {
               if(!_isGroove)
               {
                  _loc15_.push(_loc10_.Level);
               }
               else
               {
                  _loc2_ = CardManager.Instance.model.GrooveInfoVector[_loc10_.Place];
                  _loc15_.push(_loc2_.Level);
               }
            }
         }
         _loc15_.sort(compareFun);
         var _loc18_:Vector.<int> = new Vector.<int>();
         var _loc19_:DictionaryData = _loc16_.cardBagDic;
         var _loc23_:int = 0;
         var _loc22_:* = _loc19_;
         for each(var _loc4_ in _loc19_)
         {
            if(_loc4_.templateInfo.Property7 == _cardInfo.templateInfo.Property7)
            {
               if(!_isGroove)
               {
                  _loc18_.push(_loc4_.Level);
               }
               else
               {
                  _loc18_.push(_cardGrooveInfo.Level);
               }
            }
         }
         _loc18_.sort(compareFun);
         var _loc5_:int = 0;
         var _loc12_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var _loc6_:int = _loc12_.length;
         var _loc13_:String = "";
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            if(_loc12_[_loc9_].ID == _cardInfo.templateInfo.Property7)
            {
               _loc5_ = _loc12_[_loc9_].cardIdVec.length;
               _loc13_ = _loc12_[_loc9_].name;
               break;
            }
            _loc9_++;
         }
         _setsName.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.setsName",_loc13_,_loc15_.length,_loc5_);
         if(_loc15_.length > 0)
         {
            _setsName.textColor = 16777215;
         }
         else
         {
            _setsName.textColor = 10066329;
         }
         _setsName.y = _thisHeight + 5;
         _thisHeight = _setsName.y + _setsName.textHeight;
         var _loc8_:Vector.<SetsPropertyInfo> = CardManager.Instance.model.setsList[_cardInfo.templateInfo.Property7];
         var _loc3_:int = _loc8_.length;
         _loc7_ = 0;
         while(_loc7_ < 4)
         {
            if(_loc7_ < _loc3_)
            {
               _setsPropVec[_loc7_].visible = true;
               _loc11_ = _loc8_[_loc7_].value.split("|");
               _loc14_ = "";
               _loc1_ = _loc8_[_loc7_].condition;
               if(_loc15_.length >= _loc1_)
               {
                  if(_loc11_.length == 4)
                  {
                     _loc14_ = _loc15_[_loc1_ - 1] == 40?_loc11_[3]:_loc15_[_loc1_ - 1] >= 30?_loc11_[3]:_loc15_[_loc1_ - 1] >= 20?_loc11_[2]:_loc15_[_loc1_ - 1] >= 10?_loc11_[1]:_loc11_[0];
                  }
                  else
                  {
                     _loc14_ = _loc11_[0];
                  }
                  _setsPropVec[_loc7_].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",_loc1_) + "\n    " + _loc8_[_loc7_].Description.replace("{0}",_loc14_);
                  _setsPropVec[_loc7_].textColor = QualityType.QUALITY_COLOR[2];
               }
               else
               {
                  if(_loc11_.length == 4)
                  {
                     if(_loc18_.length >= _loc1_)
                     {
                        _loc14_ = _loc18_[_loc1_ - 1] == 40?_loc11_[3]:_loc18_[_loc1_ - 1] >= 30?_loc11_[3]:_loc18_[_loc1_ - 1] >= 20?_loc11_[2]:_loc18_[_loc1_ - 1] >= 10?_loc11_[1]:_loc11_[0];
                     }
                     else
                     {
                        _loc14_ = _loc11_[0];
                     }
                  }
                  else
                  {
                     _loc14_ = _loc11_[0];
                  }
                  _setsPropVec[_loc7_].text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.equip",_loc1_) + "\n    " + _loc8_[_loc7_].Description.replace("{0}",_loc14_);
                  _setsPropVec[_loc7_].textColor = 10066329;
               }
               _setsPropVec[_loc7_].y = _thisHeight + 4;
               _thisHeight = _setsPropVec[_loc7_].y + _setsPropVec[_loc7_].textHeight;
            }
            else
            {
               _setsPropVec[_loc7_].visible = false;
            }
            _loc7_++;
         }
         _validity.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
         _validity.textColor = 16776960;
         _validity.y = _thisHeight + 10;
         _thisHeight = _validity.y + _validity.textHeight;
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
