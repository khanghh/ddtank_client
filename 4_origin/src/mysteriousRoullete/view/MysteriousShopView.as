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
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc5_:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(96);
         _loc6_ = 0;
         while(_loc6_ <= _loc5_.length - 1)
         {
            _loc2_ = new MysteriousShopItem(0);
            _loc2_.shopItemInfo = _loc5_[_loc6_];
            _freeItemList.addChild(_loc2_);
            _freeItemArr.push(_loc2_);
            _loc6_++;
         }
         var _loc3_:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(97);
         _loc4_ = 0;
         while(_loc4_ <= _loc3_.length - 1)
         {
            _loc1_ = new MysteriousShopItem(1);
            _loc1_.shopItemInfo = _loc3_[_loc4_];
            _discountItemList.addChild(_loc1_);
            _discountItemArr.push(_loc1_);
            _loc4_++;
         }
         setTimes();
      }
      
      public function setTimes() : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = MysteriousManager.instance.freeGetTimes;
         var _loc1_:int = MysteriousManager.instance.discountBuyTimes;
         _freeCount.text = _loc2_.toString();
         _discountCount.text = _loc1_.toString();
         var _loc3_:Boolean = _loc2_ == 0?true:false;
         var _loc4_:Boolean = _loc1_ == 0?true:false;
         _loc6_ = 0;
         while(_loc6_ <= _freeItemArr.length - 1)
         {
            (_freeItemArr[_loc6_] as MysteriousShopItem).turnGray(_loc3_);
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ <= _discountItemArr.length - 1)
         {
            (_discountItemArr[_loc5_] as MysteriousShopItem).turnGray(_loc4_);
            _loc5_++;
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
