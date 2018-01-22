package happyLittleGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import happyLittleGame.bombshellGame.item.HappyMiniDayNewItem;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.HappyMiniGameActiveInfo;
   
   public class LittleGameDayNewsView extends Sprite implements Disposeable
   {
       
      
      private var _title:Bitmap;
      
      private var _bgBottom:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemBg:ScaleBitmapImage;
      
      private var _itemBgII:ScaleBitmapImage;
      
      private var _itemBg_1:ScaleBitmapImage;
      
      private var _itemBgII_1:ScaleBitmapImage;
      
      private var _itemBg_2:ScaleBitmapImage;
      
      private var _pagerightBtn:BaseButton;
      
      private var _pageleftBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _item_1:HappyMiniDayNewItem;
      
      private var _item_2:HappyMiniDayNewItem;
      
      private var _item_3:HappyMiniDayNewItem;
      
      private var _item_4:HappyMiniDayNewItem;
      
      private var _item_5:HappyMiniDayNewItem;
      
      private var _items:Vector.<HappyMiniDayNewItem>;
      
      private var _dayPageIndex:int;
      
      private var _infos:Vector.<HappyMiniGameActiveInfo>;
      
      public function LittleGameDayNewsView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatBitmap("asset.bombgame.title");
         _bgBottom = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayNews.frameBottom");
         _bg = ComponentFactory.Instance.creatComponentByStylename("bombgame.dayNews.Bg");
         _pagerightBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.rightPageBtn");
         _pageleftBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.leftPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("bombgame.PageCountBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.pageTxt");
         _pageTxt.text = "0/0";
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.item.bg");
         _itemBgII = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.item.bgII");
         _itemBg_1 = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.item.bgII");
         _itemBgII_1 = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.item.bg");
         _itemBg_2 = ComponentFactory.Instance.creatComponentByStylename("bombgame.daynews.item.bgII");
         PositionUtils.setPos(_itemBg_1,"bombgame.daynewsview.itemBg_1");
         PositionUtils.setPos(_itemBgII_1,"bombgame.daynewsview.itemBg_2");
         PositionUtils.setPos(_itemBg_2,"bombgame.daynewsview.itemBg_3");
         PositionUtils.setPos(_pagerightBtn,"bombgame.page.right.pos");
         PositionUtils.setPos(_pageleftBtn,"bombgame.page.left.pos");
         PositionUtils.setPos(_pageBg,"bombgame.page.bg.pos");
         PositionUtils.setPos(_pageTxt,"bombgame.page.txt.pos");
         addChild(_bgBottom);
         addChild(_title);
         addChild(_bg);
         addChild(_itemBg);
         addChild(_itemBgII);
         addChild(_itemBg_1);
         addChild(_itemBgII_1);
         addChild(_itemBg_2);
         addChild(_pagerightBtn);
         addChild(_pageleftBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         _infos = HappyLittleGameManager.instance.gameActiveInfos;
         initItem();
         if(_infos.length > 0)
         {
            showDayRankByPage(1);
         }
         initEvent();
      }
      
      private function initEvent() : void
      {
         _pagerightBtn.addEventListener("click",__rightClickHandler);
         _pageleftBtn.addEventListener("click",__leftBtnClickhandler);
         HappyLittleGameManager.instance.addEventListener("refreshdaynew",__dayactiveHandler);
      }
      
      private function removeEvent() : void
      {
         _pagerightBtn.removeEventListener("click",__rightClickHandler);
         _pageleftBtn.removeEventListener("click",__leftBtnClickhandler);
         HappyLittleGameManager.instance.removeEventListener("refreshdaynew",__dayactiveHandler);
      }
      
      private function __dayactiveHandler(param1:Event) : void
      {
         _infos = HappyLittleGameManager.instance.gameActiveInfos;
         if(_infos.length > 0)
         {
            showDayRankByPage(1);
         }
      }
      
      private function __rightClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = Math.ceil(_infos.length / 5);
         if(_dayPageIndex < _loc2_)
         {
            _dayPageIndex = Number(_dayPageIndex) + 1;
         }
         else
         {
            _dayPageIndex = 1;
         }
         showDayRankByPage(_dayPageIndex);
      }
      
      private function __leftBtnClickhandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_dayPageIndex > 1)
         {
            _dayPageIndex = Number(_dayPageIndex) - 1;
         }
         else
         {
            _loc2_ = Math.ceil(_infos.length / 5);
            _dayPageIndex = _loc2_;
         }
         showDayRankByPage(_dayPageIndex);
      }
      
      public function showDayRankByPage(param1:int) : void
      {
         var _loc2_:* = 0;
         clearAll();
         _dayPageIndex = param1;
         if(_infos.length == 0)
         {
            _pageTxt.text = "0/0";
            return;
         }
         var _loc6_:int = Math.ceil(_infos.length / 5);
         var _loc3_:int = (param1 - 1) * 5;
         var _loc5_:int = _loc3_ + 5;
         var _loc4_:int = 0;
         _pageTxt.text = param1 + "/" + _loc6_;
         if(param1 > _loc6_)
         {
            return;
            §§push(trace("翻页超出"));
         }
         else
         {
            if(param1 == _loc6_)
            {
               _loc5_ = _infos.length;
            }
            _loc2_ = _loc3_;
            while(_loc2_ < _loc5_)
            {
               if(_loc2_ < _infos.length)
               {
                  _items[_loc4_].Info = _infos[_loc2_];
                  _loc4_++;
               }
               _loc2_++;
            }
            return;
         }
      }
      
      private function initItem() : void
      {
         _items = new Vector.<HappyMiniDayNewItem>();
         _item_1 = new HappyMiniDayNewItem();
         _item_1.clear();
         PositionUtils.setPos(_item_1,"bombgame.daynewsview.dayitempoint_1");
         _item_2 = new HappyMiniDayNewItem();
         _item_2.clear();
         PositionUtils.setPos(_item_2,"bombgame.daynewsview.dayitempoint_2");
         _item_3 = new HappyMiniDayNewItem();
         _item_3.clear();
         PositionUtils.setPos(_item_3,"bombgame.daynewsview.dayitempoint_3");
         _item_4 = new HappyMiniDayNewItem();
         _item_4.clear();
         PositionUtils.setPos(_item_4,"bombgame.daynewsview.dayitempoint_4");
         _item_5 = new HappyMiniDayNewItem();
         _item_5.clear();
         PositionUtils.setPos(_item_5,"bombgame.daynewsview.dayitempoint_5");
         _items.push(_item_1);
         _items.push(_item_2);
         _items.push(_item_3);
         _items.push(_item_4);
         _items.push(_item_5);
         addChild(_item_1);
         addChild(_item_2);
         addChild(_item_3);
         addChild(_item_4);
         addChild(_item_5);
      }
      
      public function clearAll() : void
      {
         if(_item_1)
         {
            _item_1.clear();
         }
         if(_item_2)
         {
            _item_2.clear();
         }
         if(_item_3)
         {
            _item_3.clear();
         }
         if(_item_4)
         {
            _item_4.clear();
         }
         if(_item_5)
         {
            _item_5.clear();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         while(this.numChildren > 0)
         {
            _loc1_ = removeChildAt(0);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
   }
}
