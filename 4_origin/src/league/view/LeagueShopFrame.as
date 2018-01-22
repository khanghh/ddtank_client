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
         var _loc1_:* = null;
         super();
         _goodsInfoList = ShopManager.Instance.getValidGoodByType(93);
         var _loc2_:int = _goodsInfoList.length;
         _totlePage = Math.ceil(_loc2_ / 4);
         _currentPage = 1;
         if(BattleGroudControl.Instance.orderdata)
         {
            _loc1_ = BattleGroudControl.Instance.getBattleDataByPrestige(BattleGroudControl.Instance.orderdata.totalPrestige);
            LeagueControl.instance.militaryRank = _loc1_.Level;
         }
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new LeagueShopCell();
            _loc1_.x = 14 + _loc2_ % 2 * (_loc1_.width + 3);
            _loc1_.y = 263 + int(_loc2_ / 2) * (_loc1_.height + 2);
            addToContent(_loc1_);
            _shopCellList[_loc2_] = _loc1_;
            _loc2_++;
         }
         refreshView();
         refreshMoneyTxt();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _pageTxt.text = _currentPage + "/" + _totlePage;
         var _loc1_:int = (_currentPage - 1) * 4;
         var _loc3_:int = _goodsInfoList.length;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = _loc1_ + _loc4_;
            if(_loc2_ >= _loc3_)
            {
               _shopCellList[_loc4_].visible = false;
            }
            else
            {
               _shopCellList[_loc4_].visible = true;
               _shopCellList[_loc4_].refreshShow(_goodsInfoList[_loc2_]);
            }
            _loc4_++;
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
      
      private function __onUpdatePersonLimitShop(param1:CEvent) : void
      {
         if(param1 && int(param1.data) == 93)
         {
            refreshView();
         }
      }
      
      private function propertyChangeHandler(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["leagueMoney"])
         {
            refreshMoneyTxt();
         }
      }
      
      private function changePageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc3_:* = _loc2_;
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
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
