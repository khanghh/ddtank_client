package cardSystem.view.cardCollect
{
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.elements.CardBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class CollectBagItem extends Sprite implements Disposeable
   {
      
      public static const itemCellWidth:int = 78;
       
      
      private var _container:HBox;
      
      private var _setsInfo:SetsInfo;
      
      private var _setsName:GradientText;
      
      private var _cardsVector:Vector.<CardBagCell>;
      
      private var _seleted:Boolean;
      
      private var _itemBG:MovieImage;
      
      private var _light:Scale9CornerImage;
      
      private var _itemInfo:DictionaryData;
      
      public function CollectBagItem()
      {
         super();
         initView();
      }
      
      public function set seleted(param1:Boolean) : void
      {
         _seleted = param1;
         if(_seleted)
         {
            _light.visible = true;
         }
         else
         {
            _light.visible = false;
         }
      }
      
      public function get seleted() : Boolean
      {
         return _seleted;
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.BG");
         _light = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.light");
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.setsName");
         _container = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.container");
         addChild(_itemBG);
         addChild(_light);
         addChild(_setsName);
         addChild(_container);
         _cardsVector = new Vector.<CardBagCell>(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _cardsVector[_loc1_] = new CardBagCell(ComponentFactory.Instance.creatBitmap("asset.cardBag.cardBGOne"));
            _cardsVector[_loc1_].setContentSize(68,92);
            _cardsVector[_loc1_].starVisible = false;
            _cardsVector[_loc1_].mouseChildren = false;
            _cardsVector[_loc1_].mouseEnabled = false;
            _container.addChild(_cardsVector[_loc1_]);
            _loc1_++;
         }
      }
      
      public function set setsInfo(param1:SetsInfo) : void
      {
         _setsInfo = param1;
         upView();
      }
      
      public function get setsInfo() : SetsInfo
      {
         return _setsInfo;
      }
      
      private function upView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         seleted = false;
         var _loc1_:int = 0;
         if(_setsInfo)
         {
            _setsName.text = _setsInfo.name;
            _loc1_ = _setsInfo.cardIdVec.length;
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               if(_loc3_ < _loc1_)
               {
                  _cardsVector[_loc3_].visible = true;
                  _cardsVector[_loc3_].cardID = _setsInfo.cardIdVec[_loc3_];
                  _cardsVector[_loc3_].filters = null;
               }
               else
               {
                  _cardsVector[_loc3_].visible = false;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc1_ = 5;
            _setsName.text = LanguageMgr.GetTranslation("ddt.cardSyste.bagItem.unkwon");
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               _cardsVector[_loc2_].visible = true;
               _cardsVector[_loc2_].cardInfo = null;
               _cardsVector[_loc2_].showCardName(LanguageMgr.GetTranslation("ddt.cardSyste.bagItem.unkwon"));
               _cardsVector[_loc2_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _cardsVector[_loc2_].mouseChildren = false;
               _cardsVector[_loc2_].mouseEnabled = false;
               _loc2_++;
            }
         }
         _itemBG.width = 78 * _loc1_ + 5;
         _light.width = 78 * _loc1_ + 15 + _loc1_ * 2;
      }
      
      public function setSetsDate(param1:Vector.<CardInfo>) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = _setsInfo.cardIdVec.length;
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(_loc4_ > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(_cardsVector[_loc5_].cardID == param1[_loc3_].TemplateID)
                  {
                     _cardsVector[_loc5_].cardInfo = param1[_loc3_];
                     _cardsVector[_loc5_].collectCard = true;
                     break;
                  }
                  if(_loc3_ == _loc4_ - 1)
                  {
                     _cardsVector[_loc5_].cardInfo = null;
                     _cardsVector[_loc5_].showCardName(ItemManager.Instance.getTemplateById(_cardsVector[_loc5_].cardID).Name);
                  }
                  _loc3_++;
               }
            }
            else
            {
               _cardsVector[_loc5_].cardInfo = null;
               _cardsVector[_loc5_].showCardName(ItemManager.Instance.getTemplateById(_cardsVector[_loc5_].cardID).Name);
            }
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _setsInfo = null;
         _itemInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _container = null;
         _setsName = null;
         _loc1_ = 0;
         while(_loc1_ < _cardsVector.length)
         {
            _cardsVector[_loc1_] = null;
            _loc1_++;
         }
         _cardsVector = null;
         _itemBG = null;
         _light = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
