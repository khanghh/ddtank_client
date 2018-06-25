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
      
      private function __pageRClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var len:int = Math.ceil(_currentarr.length / 10);
         if(_dayPageIndex < len)
         {
            _dayPageIndex = Number(_dayPageIndex) + 1;
         }
         else
         {
            _dayPageIndex = 1;
         }
         showDayRankByPage(_dayPageIndex);
      }
      
      private function __pageLClickHandler(evt:MouseEvent) : void
      {
         var len:int = 0;
         SoundManager.instance.play("008");
         if(_dayPageIndex > 1)
         {
            _dayPageIndex = Number(_dayPageIndex) - 1;
         }
         else
         {
            len = Math.ceil(_currentarr.length / 10);
            _dayPageIndex = len;
         }
         showDayRankByPage(_dayPageIndex);
      }
      
      private function initItem() : void
      {
         var item:* = null;
         var i:int = 0;
         for(i = 0; i < 10; )
         {
            item = new BombRankItem();
            _items.push(item);
            PositionUtils.setPos(item,"bombgame.daynewsview.rankitem_" + (i + 1));
            addChild(item);
            i++;
         }
      }
      
      public function set Infos(infos:Vector.<BombRankInfo>) : void
      {
         if(_currentarr != infos)
         {
            _currentarr = null;
         }
         _currentarr = infos;
         showDayRankByPage(1);
      }
      
      public function refreshData(rankType:int) : void
      {
         if(rankType == 2)
         {
            Infos = HappyLittleGameManager.instance.bombManager.model.rankDayFixInfos;
         }
         else
         {
            Infos = HappyLittleGameManager.instance.bombManager.model.rankTotalFixInfos;
         }
      }
      
      public function showDayRankByPage(page:int) : void
      {
         var index:* = 0;
         clearItemInfo();
         _dayPageIndex = page;
         if(_currentarr.length == 0)
         {
            _pageTxt.text = "0/0";
            return;
         }
         var len:int = Math.ceil(_currentarr.length / 10);
         var startIndex:int = (page - 1) * 10;
         var endIndex:int = startIndex + 10;
         var infoIndex:int = 0;
         _pageTxt.text = page + "/" + len;
         if(page > len)
         {
            trace("翻页超出");
            return;
         }
         if(page == len)
         {
            endIndex = _currentarr.length;
         }
         for(index = startIndex; index < endIndex; )
         {
            if(index < _currentarr.length)
            {
               _items[infoIndex].Info = _currentarr[index];
               infoIndex++;
            }
            index++;
         }
      }
      
      public function clearItemInfo() : void
      {
         var i:int = 0;
         var len:int = _items.length;
         for(i = 0; i < len; )
         {
            _items[i].clear();
            i++;
         }
      }
      
      public function dispose() : void
      {
         var obj:* = null;
         removeEvent();
         while(this.numChildren > 0)
         {
            obj = removeChildAt(0);
            ObjectUtils.disposeObject(obj);
            obj = null;
         }
         _items = null;
      }
   }
}
