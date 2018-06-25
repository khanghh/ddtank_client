package mysteriousRoullete.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ShopManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mysteriousRoullete.MysteriousManager;
   
   public class MysteriousShopView extends Sprite implements Disposeable
   {
      
      private static const NUMBER:int = 2;
      
      private static const LENGTH:int = 8;
       
      
      private var _shopTitle:Bitmap;
      
      private var _freeBG:Bitmap;
      
      private var _discountBG:Bitmap;
      
      private var _freeCount:FilterFrameText;
      
      private var _discountCount:FilterFrameText;
      
      private var _freePanel:ScrollPanel;
      
      private var _discontPanel:ScrollPanel;
      
      private var _freeItemList:SimpleTileList;
      
      private var _freeItemArr:Array;
      
      private var _discountItemList:SimpleTileList;
      
      private var _discountItemArr:Array;
      
      public function MysteriousShopView()
      {
         super();
         _freeItemArr = [];
         _discountItemArr = [];
         initView();
         initData();
      }
      
      public function initView() : void
      {
         _shopTitle = ComponentFactory.Instance.creat("mysteriousRoulette.shopTitle");
         addChild(_shopTitle);
         _freeBG = ComponentFactory.Instance.creat("mysteriousRoulette.freeBG");
         addChild(_freeBG);
         _discountBG = ComponentFactory.Instance.creat("mysteriousRoulette.discountBG");
         addChild(_discountBG);
         _freeCount = ComponentFactory.Instance.creat("mysteriousRoulette.freeCount");
         _freeCount.text = "0";
         addChild(_freeCount);
         _discountCount = ComponentFactory.Instance.creat("mysteriousRoulette.discountCount");
         _discountCount.text = "0";
         addChild(_discountCount);
         _freePanel = ComponentFactory.Instance.creat("mysteriousRoulette.freePanel");
         addChild(_freePanel);
         _freeItemList = ComponentFactory.Instance.creatCustomObject("mysteriousRoulette.freeItemList",[2]);
         _freePanel.setView(_freeItemList);
         _discontPanel = ComponentFactory.Instance.creat("mysteriousRoulette.discountPanel");
         addChild(_discontPanel);
         _discountItemList = ComponentFactory.Instance.creatCustomObject("mysteriousRoulette.discountItemList",[2]);
         _discontPanel.setView(_discountItemList);
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var item2:* = null;
         var freeItemArr:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(96);
         for(i = 0; i <= freeItemArr.length - 1; )
         {
            item = new MysteriousShopItem(0);
            item.shopItemInfo = freeItemArr[i];
            _freeItemList.addChild(item);
            _freeItemArr.push(item);
            i++;
         }
         var discountItemArr:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(97);
         for(j = 0; j <= discountItemArr.length - 1; )
         {
            item2 = new MysteriousShopItem(1);
            item2.shopItemInfo = discountItemArr[j];
            _discountItemList.addChild(item2);
            _discountItemArr.push(item2);
            j++;
         }
         setTimes();
      }
      
      public function setTimes() : void
      {
         var i:int = 0;
         var j:int = 0;
         var freeTimes:int = MysteriousManager.instance.freeGetTimes;
         var discountTimes:int = MysteriousManager.instance.discountBuyTimes;
         _freeCount.text = freeTimes.toString();
         _discountCount.text = discountTimes.toString();
         var grayFlag1:Boolean = freeTimes == 0?true:false;
         var grayFlag2:Boolean = discountTimes == 0?true:false;
         for(i = 0; i <= _freeItemArr.length - 1; )
         {
            (_freeItemArr[i] as MysteriousShopItem).turnGray(grayFlag1);
            i++;
         }
         for(j = 0; j <= _discountItemArr.length - 1; )
         {
            (_discountItemArr[j] as MysteriousShopItem).turnGray(grayFlag2);
            j++;
         }
      }
      
      public function dispose() : void
      {
         if(_shopTitle)
         {
            ObjectUtils.disposeObject(_shopTitle);
         }
         _shopTitle = null;
         if(_freeBG)
         {
            ObjectUtils.disposeObject(_freeBG);
         }
         _freeBG = null;
         if(_discountBG)
         {
            ObjectUtils.disposeObject(_discountBG);
         }
         _discountBG = null;
         if(_freeCount)
         {
            ObjectUtils.disposeObject(_freeCount);
         }
         _freeCount = null;
         if(_discountCount)
         {
            ObjectUtils.disposeObject(_discountCount);
         }
         _discountCount = null;
         if(_freePanel)
         {
            ObjectUtils.disposeObject(_freePanel);
         }
         _freePanel = null;
         if(_discontPanel)
         {
            ObjectUtils.disposeObject(_discontPanel);
         }
         _discontPanel = null;
         if(_freeItemList)
         {
            ObjectUtils.disposeObject(_freeItemList);
         }
         _freeItemList = null;
         if(_discountItemList)
         {
            ObjectUtils.disposeObject(_discountItemList);
         }
         _discountItemList = null;
      }
   }
}
