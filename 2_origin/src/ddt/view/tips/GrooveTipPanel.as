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
         var j:int = 0;
         var n:int = 0;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _GrooveLevel = null;
         _rule1 = null;
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
         var j:int = 0;
         var n:int = 0;
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
         for(j = 0; j < 4; )
         {
            _propVec[j] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
            j++;
         }
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         _setsPropVec = new Vector.<FilterFrameText>(4);
         for(n = 0; n < 4; )
         {
            _setsPropVec[n] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            n++;
         }
         _validity = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.basePropTitle");
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         var j:int = 0;
         var n:int = 0;
         super.addChildren();
         addChild(_GrooveLevel);
         addChild(_GrooveLevelDetail);
         addChild(_rule1);
         addChild(_EpDetail);
         addChild(_Explain);
         for(j = 0; j < 4; )
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
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            _cardInfo = data as CardInfo;
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
         var cardInfo:* = null;
         var _grooveInfo1:* = null;
         var current:int = 0;
         var difference:int = 0;
         var _grooveInfo:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
         _GrooveLevelDetail.text = _cardGrooveInfo.Level < 10?"0" + String(_cardGrooveInfo.Level):String(_cardGrooveInfo.Level);
         if(_cardGrooveInfo.Level >= 40)
         {
            _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP","0/0");
         }
         else
         {
            cardInfo = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
            _grooveInfo1 = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level + 1),String(_cardGrooveInfo.Type));
            current = _cardGrooveInfo.GP - int(cardInfo.Exp);
            difference = int(_grooveInfo1.Exp) - int(cardInfo.Exp);
            _EpDetail.text = LanguageMgr.GetTranslation("ddt.cardSystem.cardsTipPanel.EP",current + "/" + difference);
         }
         _rule1.x = _EpDetail.x;
         _rule1.y = _EpDetail.y + _EpDetail.textHeight + 10;
         _thisHeight = _rule1.y + _rule1.height;
      }
      
      private function showMiddlePart() : void
      {
         var i:int = 0;
         var propArr:Array = [];
         var _grooveInfo:CardGrooveInfo = GrooveInfoManager.instance.getInfoByLevel(String(_cardGrooveInfo.Level),String(_cardGrooveInfo.Type));
         if(int(_grooveInfo.Attack) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",_cardGrooveInfo.realAttack));
         }
         if(int(_grooveInfo.Defend) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",_cardGrooveInfo.realDefence));
         }
         if(int(_grooveInfo.Agility) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",_cardGrooveInfo.realAgility));
         }
         if(int(_grooveInfo.Lucky) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",_cardGrooveInfo.realLucky));
         }
         if(int(_grooveInfo.Damage) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Gamage",_cardGrooveInfo.realDamage));
         }
         if(int(_grooveInfo.Guard) >= 0)
         {
            propArr.push(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",_cardGrooveInfo.realGuard));
         }
         i = 0;
         while(i < 4)
         {
            if(i < propArr.length)
            {
               _propVec[i].visible = true;
               _propVec[i].text = propArr[i];
               _propVec[i].textColor = QualityType.QUALITY_COLOR[5];
               _propVec[i].y = _rule1.y + _rule1.height + 8 + 24 * i;
               if(i == propArr.length - 1)
               {
                  _rule2.x = _propVec[i].x;
                  _rule2.y = _propVec[i].y + _propVec[i].textHeight + 12;
               }
            }
            else
            {
               _propVec[i].visible = false;
            }
            _rule2.x = _propVec[i].x;
            _rule2.y = _propVec[i].y + _propVec[i].textHeight + 12;
            _thisHeight = _rule2.y + _rule2.height;
            i++;
         }
      }
      
      private function showButtomPart() : void
      {
         var n:int = 0;
         _setsName.visible = false;
         for(n = 0; n < _setsPropVec.length; )
         {
            _setsPropVec[n].visible = false;
            n++;
         }
         _validity.visible = false;
         _Explain.visible = true;
         _Explain.text = LanguageMgr.GetTranslation("ddt.cardsTipPanel.Groove.epdetai");
         _Explain.y = _thisHeight + 10;
         _thisHeight = _Explain.y + _Explain.textHeight;
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
