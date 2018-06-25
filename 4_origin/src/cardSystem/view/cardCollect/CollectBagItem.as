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
      
      public function set seleted(value:Boolean) : void
      {
         _seleted = value;
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
         var i:int = 0;
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.BG");
         _light = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.light");
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.setsName");
         _container = ComponentFactory.Instance.creatComponentByStylename("CollectBagItem.container");
         addChild(_itemBG);
         addChild(_light);
         addChild(_setsName);
         addChild(_container);
         _cardsVector = new Vector.<CardBagCell>(5);
         for(i = 0; i < 5; )
         {
            _cardsVector[i] = new CardBagCell(ComponentFactory.Instance.creatBitmap("asset.cardBag.cardBGOne"));
            _cardsVector[i].setContentSize(68,92);
            _cardsVector[i].starVisible = false;
            _cardsVector[i].mouseChildren = false;
            _cardsVector[i].mouseEnabled = false;
            _container.addChild(_cardsVector[i]);
            i++;
         }
      }
      
      public function set setsInfo(value:SetsInfo) : void
      {
         _setsInfo = value;
         upView();
      }
      
      public function get setsInfo() : SetsInfo
      {
         return _setsInfo;
      }
      
      private function upView() : void
      {
         var i:int = 0;
         var j:int = 0;
         seleted = false;
         var len:int = 0;
         if(_setsInfo)
         {
            _setsName.text = _setsInfo.name;
            len = _setsInfo.cardIdVec.length;
            for(i = 0; i < 5; )
            {
               if(i < len)
               {
                  _cardsVector[i].visible = true;
                  _cardsVector[i].cardID = _setsInfo.cardIdVec[i];
                  _cardsVector[i].filters = null;
               }
               else
               {
                  _cardsVector[i].visible = false;
               }
               i++;
            }
         }
         else
         {
            len = 5;
            _setsName.text = LanguageMgr.GetTranslation("ddt.cardSyste.bagItem.unkwon");
            for(j = 0; j < 5; )
            {
               _cardsVector[j].visible = true;
               _cardsVector[j].cardInfo = null;
               _cardsVector[j].showCardName(LanguageMgr.GetTranslation("ddt.cardSyste.bagItem.unkwon"));
               _cardsVector[j].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _cardsVector[j].mouseChildren = false;
               _cardsVector[j].mouseEnabled = false;
               j++;
            }
         }
         _itemBG.width = 78 * len + 5;
         _light.width = 78 * len + 15 + len * 2;
      }
      
      public function setSetsDate(date:Vector.<CardInfo>) : void
      {
         var i:int = 0;
         var j:int = 0;
         var setsLen:int = _setsInfo.cardIdVec.length;
         var dateLen:int = date.length;
         for(i = 0; i < setsLen; )
         {
            if(dateLen > 0)
            {
               for(j = 0; j < dateLen; )
               {
                  if(_cardsVector[i].cardID == date[j].TemplateID)
                  {
                     _cardsVector[i].cardInfo = date[j];
                     _cardsVector[i].collectCard = true;
                     break;
                  }
                  if(j == dateLen - 1)
                  {
                     _cardsVector[i].cardInfo = null;
                     _cardsVector[i].showCardName(ItemManager.Instance.getTemplateById(_cardsVector[i].cardID).Name);
                  }
                  j++;
               }
            }
            else
            {
               _cardsVector[i].cardInfo = null;
               _cardsVector[i].showCardName(ItemManager.Instance.getTemplateById(_cardsVector[i].cardID).Name);
            }
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         _setsInfo = null;
         _itemInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _container = null;
         _setsName = null;
         for(i = 0; i < _cardsVector.length; )
         {
            _cardsVector[i] = null;
            i++;
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
