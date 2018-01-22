package cardSystem.elements
{
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.CardTemplateInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PreviewCard extends Sprite implements Disposeable
   {
       
      
      private var _cardId:int;
      
      private var _cell:CardCell;
      
      private var _bg:Bitmap;
      
      private var _Goldbg:Bitmap;
      
      private var _Silverbg:Bitmap;
      
      private var _Coppebg:Bitmap;
      
      private var _prop:FilterFrameText;
      
      private var _cardInfo:CardInfo;
      
      private var _cardName:FilterFrameText;
      
      public function PreviewCard()
      {
         super();
         initView();
      }
      
      public function get cardId() : int
      {
         return _cardId;
      }
      
      public function set cardId(param1:int) : void
      {
         _cardId = param1;
         _cardName.text = ItemManager.Instance.getTemplateById(cardId).Name;
         _cardName.y = 41 - _cardName.textHeight / 2;
      }
      
      private function initView() : void
      {
         mouseChildren = false;
         mouseEnabled = false;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,57,70);
         _loc1_.graphics.endFill();
         _cell = new CardCell(_loc1_);
         _cell.setContentSize(52,70);
         _cell.starVisible = false;
         _cell.Visibles = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.cardCollect.storyCard.BG");
         _Goldbg = ComponentFactory.Instance.creatBitmap("asset.cardCollect.GrodCard.BG");
         _Silverbg = ComponentFactory.Instance.creatBitmap("asset.cardCollect.SilverCard.BG");
         _Coppebg = ComponentFactory.Instance.creatBitmap("asset.cardCollect.CopperCard.BG");
         _prop = ComponentFactory.Instance.creatComponentByStylename("PreviewCard.Propset");
         _cardName = ComponentFactory.Instance.creatComponentByStylename("PreviewCard.name");
         PositionUtils.setPos(_cell,"PreviewCard.cellPos");
         addChild(_bg);
         addChild(_Goldbg);
         addChild(_Silverbg);
         addChild(_Coppebg);
         addChild(_cardName);
         addChild(_cell);
         addChild(_prop);
         var _loc2_:* = false;
         _Coppebg.visible = _loc2_;
         _loc2_ = _loc2_;
         _Silverbg.visible = _loc2_;
         _loc2_ = _loc2_;
         _Goldbg.visible = _loc2_;
         _bg.visible = _loc2_;
      }
      
      public function set cardInfo(param1:CardInfo) : void
      {
         var _loc3_:* = null;
         var _loc2_:String = "";
         if(param1)
         {
            _cardInfo = param1;
            _cell.cardInfo = param1;
            _cell.visible = true;
            _cell.Visibles = false;
            _loc3_ = CardTemplateInfoManager.instance.getInfoByCardId(String(param1.TemplateID),String(param1.CardType));
            if(param1.templateInfo.Attack != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Attack",Number(_loc3_.AttackRate)) + "<br/>");
            }
            if(param1.templateInfo.Defence != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Defence",Number(_loc3_.DefendRate)) + "<br/>");
            }
            if(param1.templateInfo.Agility != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Agility",Number(_loc3_.AgilityRate)) + "<br/>");
            }
            if(param1.templateInfo.Luck != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Luck",Number(_loc3_.LuckyRate)) + "<br/>");
            }
            if(parseInt(param1.templateInfo.Property4) != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Damage",Number(_loc3_.DamageRate)) + "<br/>");
            }
            if(parseInt(param1.templateInfo.Property5) != 0)
            {
               _loc2_ = _loc2_.concat(LanguageMgr.GetTranslation("ddt.cardSystem.PropResetFrame.Guard",Number(_loc3_.GuardRate)) + "<br/>");
            }
            if(param1.CardType == 1)
            {
               _Goldbg.visible = true;
               _Silverbg.visible = false;
               _Coppebg.visible = false;
               _bg.visible = false;
            }
            else if(param1.CardType == 2)
            {
               _Goldbg.visible = false;
               _Silverbg.visible = true;
               _Coppebg.visible = false;
               _bg.visible = false;
            }
            else if(param1.CardType == 3)
            {
               _Goldbg.visible = false;
               _Silverbg.visible = false;
               _Coppebg.visible = true;
               _bg.visible = false;
            }
            else
            {
               _Goldbg.visible = false;
               _Silverbg.visible = false;
               _Coppebg.visible = false;
               _bg.visible = true;
            }
         }
         else
         {
            _cell.cardInfo = null;
            _cell.visible = false;
            _Goldbg.visible = false;
            _Silverbg.visible = false;
            _Coppebg.visible = false;
            _bg.visible = true;
            _loc2_ = LanguageMgr.GetTranslation("ddt.cardSystem.cardProp.unknown");
         }
         _prop.htmlText = _loc2_;
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      public function dispose() : void
      {
         _cardInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _cell = null;
         _bg = null;
         _prop = null;
         _cardName = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
