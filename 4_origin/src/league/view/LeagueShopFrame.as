package league.view
{
   import battleGroud.BattleGroudControl;
   import battleGroud.data.BatlleData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import league.LeagueControl;
   
   public class LeagueShopFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _moneyCountTxt:FilterFrameText;
      
      private var _pageTxt:FilterFrameText;
      
      private var _foreBtn:SimpleBitmapButton;
      
      private var _nextBtn:SimpleBitmapButton;
      
      private var _shopCellList:Vector.<LeagueShopCell>;
      
      private var _currentPage:int;
      
      private var _totlePage:int;
      
      private var _goodsInfoList:Vector.<ShopItemInfo>;
      
      public function LeagueShopFrame()
      {
         var tmpData:* = null;
         super();
         _goodsInfoList = ShopManager.Instance.getValidGoodByType(93);
         var tmpLen:int = _goodsInfoList.length;
         _totlePage = Math.ceil(tmpLen / 4);
         _currentPage = 1;
         if(BattleGroudControl.Instance.orderdata)
         {
            tmpData = BattleGroudControl.Instance.getBattleDataByPrestige(BattleGroudControl.Instance.orderdata.totalPrestige);
            LeagueControl.instance.militaryRank = tmpData.Level;
         }
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmpCell:* = null;
         titleText = LanguageMgr.GetTranslation("tank.menu.MatchesTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.leagueShopFrame.bg");
         _moneyCountTxt = ComponentFactory.Instance.creatComponentByStylename("leagueShopFrame.moneyCountTxt");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("leagueShopFrame.pageTxt");
         _foreBtn = ComponentFactory.Instance.creatComponentByStylename("leagueShopFrame.foreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("leagueShopFrame.nextBtn");
         addToContent(_bg);
         addToContent(_moneyCountTxt);
         addToContent(_pageTxt);
         addToContent(_foreBtn);
         addToContent(_nextBtn);
         _shopCellList = new Vector.<LeagueShopCell>(4);
         for(i = 0; i < 4; )
         {
            tmpCell = new LeagueShopCell();
            tmpCell.x = 14 + i % 2 * (tmpCell.width + 3);
            tmpCell.y = 263 + int(i / 2) * (tmpCell.height + 2);
            addToContent(tmpCell);
            _shopCellList[i] = tmpCell;
            i++;
         }
         refreshView();
         refreshMoneyTxt();
      }
      
      private function refreshView() : void
      {
         var i:int = 0;
         var tmpTag:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var startIndex:int = (_currentPage - 1) * 4;
         var tmpCount:int = _goodsInfoList.length;
         for(i = 0; i < 4; )
         {
            tmpTag = startIndex + i;
            if(tmpTag >= tmpCount)
            {
               _shopCellList[i].visible = false;
            }
            else
            {
               _shopCellList[i].visible = true;
               _shopCellList[i].refreshShow(_goodsInfoList[tmpTag]);
            }
            i++;
         }
      }
      
      private function refreshMoneyTxt() : void
      {
         _moneyCountTxt.text = PlayerManager.Instance.Self.leagueMoney.toString();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _foreBtn.addEventListener("click",changePageHandler,false,0,true);
         _nextBtn.addEventListener("click",changePageHandler,false,0,true);
         PlayerManager.Instance.Self.addEventListener("propertychange",propertyChangeHandler);
         ShopManager.Instance.addEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
      }
      
      private function __onUpdatePersonLimitShop(event:CEvent) : void
      {
         if(event && int(event.data) == 93)
         {
            refreshView();
         }
      }
      
      private function propertyChangeHandler(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["leagueMoney"])
         {
            refreshMoneyTxt();
         }
      }
      
      private function changePageHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var tmp:SimpleBitmapButton = event.currentTarget as SimpleBitmapButton;
         var _loc3_:* = tmp;
         if(_foreBtn !== _loc3_)
         {
            if(_nextBtn === _loc3_)
            {
               if(_currentPage >= _totlePage)
               {
                  _currentPage = 1;
               }
               else
               {
                  _currentPage = Number(_currentPage) + 1;
               }
            }
         }
         else if(_currentPage <= 1)
         {
            _currentPage = _totlePage;
         }
         else
         {
            _currentPage = Number(_currentPage) - 1;
         }
         refreshView();
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _foreBtn.removeEventListener("click",changePageHandler);
         _nextBtn.removeEventListener("click",changePageHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",propertyChangeHandler);
         ShopManager.Instance.removeEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _moneyCountTxt = null;
         _pageTxt = null;
         _foreBtn = null;
         _nextBtn = null;
         _shopCellList = null;
         _goodsInfoList = null;
         LeagueControl.instance.militaryRank = -1;
      }
   }
}
