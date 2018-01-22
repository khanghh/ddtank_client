package ddt.view.tips
{
   import cardSystem.CardManager;
   import cardSystem.GrooveInfoManager;
   import cardSystem.data.CardGrooveInfo;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.QualityType;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   
   public class GrooveTipPanel extends BaseTip implements ITip, Disposeable
   {
      
      public static const THISWIDTH:int = 200;
      
      public static const CARDTYPE:Array = [LanguageMgr.GetTranslation("BrowseLeftMenuView.equipCard"),LanguageMgr.GetTranslation("BrowseLeftMenuView.freakCard")];
      
      public static const CARDTYPE_VICE_MAIN:Array = [LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.vice"),LanguageMgr.GetTranslation("ddt.cardSystem.CardsTipPanel.main")];
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _GrooveLevel:Bitmap;
      
      private var _GrooveLevelDetail:FilterFrameText;
      
      private var _rule1:ScaleBitmapImage;
      
      private var _propVec:Vector.<FilterFrameText>;
      
      private var _rule2:ScaleBitmapImage;
      
      private var _setsName:FilterFrameText;
      
      private var _setsPropVec:Vector.<FilterFrameText>;
      
      private var _validity:FilterFrameText;
      
      private var _cardInfo:CardInfo;
      
      private var _cardGrooveInfo:GrooveInfo;
      
      private var _place:int;
      
      private var _thisHeight:int;
      
      private var _EpDetail:FilterFrameText;
      
      private var _Explain:FilterFrameText;
      
      public function GrooveTipPanel()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _GrooveLevel = null;
         _rule1 = null;
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
         _validity = null;
         _cardInfo = null;
         _cardGrooveInfo = null;
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
         _GrooveLevel = ComponentFactory.Instance.creatBitmap("asset.core.tip.GoodsLevel");
         PositionUtils.setPos(_GrooveLevel,"core.cardLevelBmpOne.pos");
         _GrooveLevelDetail = ComponentFactory.Instance.creatComponentByStylename("cardSystem.level.big");
         PositionUtils.setPos(_GrooveLevelDetail,"core.cardLevel.pos");
         _EpDetail = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.ExpPropTitle");
         PositionUtils.setPos(_EpDetail,"core.cardTipEp.pos");
         _Explain = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.ExplainTitle");
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
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.addChildren();
         addChild(_GrooveLevel);
         addChild(_GrooveLevelDetail);
         addChild(_rule1);
         addChild(_EpDetail);
         addChild(_Explain);
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
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
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
               }
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
      
      private function showHeadPart() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
         _GrooveLevelDetail.text = _cardGrooveInfo.Level < 10?"0" + String(_cardGrooveInfo.Level):String(_cardGrooveInfo.Level);
         if(_cardGrooveInfo.Level >= 40)
         {
            _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP","0/0");
         }
         else
         {
            _loc2_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
            _loc4_ = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level + 1),String(_cardGrooveInfo.Type));
            _loc3_ = _cardGrooveInfo.GP - int(_loc2_.Exp);
            _loc1_ = int(_loc4_.Exp) - int(_loc2_.Exp);
            _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP",_loc3_ + "/" + _loc1_);
         }
         _rule1.x = _EpDetail.x;
         _rule1.y = _EpDetail.y + _EpDetail.textHeight + 10;
         _thisHeight = _rule1.y + _rule1.height;
      }
      
      private function showMiddlePart() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         var _loc3_:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
         if(int(_loc3_.Attack) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",_cardGrooveInfo.realAttack));
         }
         if(int(_loc3_.Defend) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",_cardGrooveInfo.realDefence));
         }
         if(int(_loc3_.Agility) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",_cardGrooveInfo.realAgility));
         }
         if(int(_loc3_.Lucky) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",_cardGrooveInfo.realLucky));
         }
         if(int(_loc3_.Damage) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Gamage",_cardGrooveInfo.realDamage));
         }
         if(int(_loc3_.Guard) >= 0)
         {
            _loc1_.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",_cardGrooveInfo.realGuard));
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(_loc2_ < _loc1_.length)
            {
               _propVec[_loc2_].visible = true;
               _propVec[_loc2_].text = _loc1_[_loc2_];
               _propVec[_loc2_].textColor = QualityType.QUALITY_COLOR[5];
               _propVec[_loc2_].y = _rule1.y + _rule1.height + 8 + 24 * _loc2_;
               if(_loc2_ == _loc1_.length - 1)
               {
                  _rule2.x = _propVec[_loc2_].x;
                  _rule2.y = _propVec[_loc2_].y + _propVec[_loc2_].textHeight + 12;
               }
            }
            else
            {
               _propVec[_loc2_].visible = false;
            }
            _rule2.x = _propVec[_loc2_].x;
            _rule2.y = _propVec[_loc2_].y + _propVec[_loc2_].textHeight + 12;
            _thisHeight = _rule2.y + _rule2.height;
            _loc2_++;
         }
      }
      
      private function showButtomPart() : void
      {
         var _loc1_:int = 0;
         _setsName.visible = false;
         _loc1_ = 0;
         while(_loc1_ < _setsPropVec.length)
         {
            _setsPropVec[_loc1_].visible = false;
            _loc1_++;
         }
         _validity.visible = false;
         _Explain.visible = true;
         _Explain.text = LanguageMgr.GetTranslation("ddt.cardsTipPanel.Groove.epdetai");
         _Explain.y = _thisHeight + 10;
         _thisHeight = _Explain.y + _Explain.textHeight;
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
         _bg.width = 200;
         updateWH();
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
