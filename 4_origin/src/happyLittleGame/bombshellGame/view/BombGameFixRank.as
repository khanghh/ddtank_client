package happyLittleGame.bombshellGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import happyLittleGame.bombshellGame.item.BombRankItem;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import uiModeManager.bombUI.model.bomb.BombRankInfo;
   
   public class BombGameFixRank extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _items:Vector.<BombRankItem>;
      
      private var _pagerightBtn:BaseButton;
      
      private var _pageleftBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _currentarr:Vector.<BombRankInfo>;
      
      private var _dayPageIndex:int = 0;
      
      public function BombGameFixRank()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.bombgame.outpost_Bg");
         _pagerightBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.rightPageBtn");
         _pageleftBtn = ComponentFactory.Instance.creatComponentByStylename("bombgame.leftPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("bombgame.PageCountBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("bombgame.pageTxt");
         _items = new Vector.<BombRankItem>();
         addChild(_bg);
         addChild(_pagerightBtn);
         addChild(_pageleftBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
         initItem();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _pagerightBtn.addEventListener("click",__pageRClickHandler);
         _pageleftBtn.addEventListener("click",__pageLClickHandler);
      }
      
      private function removeEvent() : void
      {
         _pagerightBtn.removeEventListener("click",__pageRClickHandler);
         _pageleftBtn.removeEventListener("click",__pageLClickHandler);
      }
      
      private function __pageRClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = Math.ceil(_currentarr.length / 10);
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
      
      private function __pageLClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_dayPageIndex > 1)
         {
            _dayPageIndex = Number(_dayPageIndex) - 1;
         }
         else
         {
            _loc2_ = Math.ceil(_currentarr.length / 10);
            _dayPageIndex = _loc2_;
         }
         showDayRankByPage(_dayPageIndex);
      }
      
      private function initItem() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new BombRankItem();
            _items.push(_loc1_);
            PositionUtils.setPos(_loc1_,"bombgame.daynewsview.rankitem_" + (_loc2_ + 1));
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function set Infos(param1:Vector.<BombRankInfo>) : void
      {
         if(_currentarr != param1)
         {
            _currentarr = null;
         }
         _currentarr = param1;
         showDayRankByPage(1);
      }
      
      public function refreshData(param1:int) : void
      {
         if(param1 == 2)
         {
            Infos = HappyLittleGameManager.instance.bombManager.model.rankDayFixInfos;
         }
         else
         {
            Infos = HappyLittleGameManager.instance.bombManager.model.rankTotalFixInfos;
         }
      }
      
      public function showDayRankByPage(param1:int) : void
      {
         var _loc2_:* = 0;
         clearItemInfo();
         _dayPageIndex = param1;
         if(_currentarr.length == 0)
         {
            _pageTxt.text = "0/0";
            return;
         }
         var _loc6_:int = Math.ceil(_currentarr.length / 10);
         var _loc3_:int = (param1 - 1) * 10;
         var _loc5_:int = _loc3_ + 10;
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
               _loc5_ = _currentarr.length;
            }
            _loc2_ = _loc3_;
            while(_loc2_ < _loc5_)
            {
               if(_loc2_ < _currentarr.length)
               {
                  _items[_loc4_].Info = _currentarr[_loc2_];
                  _loc4_++;
               }
               _loc2_++;
            }
            return;
         }
      }
      
      public function clearItemInfo() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _items[_loc2_].clear();
            _loc2_++;
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
         _items = null;
      }
   }
}
