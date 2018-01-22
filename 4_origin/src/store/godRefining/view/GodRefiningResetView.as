package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class GodRefiningResetView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _cellBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _tipText:FilterFrameText;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _levelText:FilterFrameText;
      
      private var _damageTitleTextArr:Vector.<FilterFrameText>;
      
      private var _damageContentTextArr:Vector.<FilterFrameText>;
      
      private var _startResetBtnArr:Vector.<BaseButton>;
      
      private var _items:Vector.<StoreCell>;
      
      public function GodRefiningResetView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.resetViewBg");
         addChild(_bg);
         _cellBg = ComponentFactory.Instance.creatBitmap("asset.godRefining.resetViewCellBg");
         addChild(_cellBg);
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.godRefining.resetTitleBmp");
         addChild(_titleBmp);
         _tipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.tipText");
         PositionUtils.setPos(_tipText,"ddtstore.godRefiningResetView.tipTextPos");
         _tipText.text = LanguageMgr.GetTranslation("store.godRefining.tipTextMsg2");
         addChild(_tipText);
         _cBuyluckyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.BuyLuckyComposeBtn");
         PositionUtils.setPos(_cBuyluckyBtn,"ddtstore.godRefiningResetView.buyLuckyComposeBtnPos");
         _cBuyluckyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _cBuyluckyBtn.setup(11018,2,true);
         addChild(_cBuyluckyBtn);
         _levelText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefiningResetView.levelText");
         _levelText.text = LanguageMgr.GetTranslation("store.godRefiningResetView.levelTextMsg",5);
         addChild(_levelText);
         _damageTitleTextArr = new Vector.<FilterFrameText>();
         _damageContentTextArr = new Vector.<FilterFrameText>();
         _startResetBtnArr = new Vector.<BaseButton>();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _damageTitleTextArr[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefiningResetView.damageTitleText");
            _damageTitleTextArr[_loc1_].text = LanguageMgr.GetTranslation("store.godRefiningResetView.damageTitleTextMsg","普通武器");
            addChild(_damageTitleTextArr[_loc1_]);
            _damageContentTextArr[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefiningResetView.damageContentText");
            _damageContentTextArr[_loc1_].text = "+20%";
            addChild(_damageContentTextArr[_loc1_]);
            _startResetBtnArr[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.startResetBtn");
            addChild(_startResetBtnArr[_loc1_]);
            if(_loc1_ == 1)
            {
               _damageTitleTextArr[_loc1_].y = _damageTitleTextArr[_loc1_].y + 30;
               _damageContentTextArr[_loc1_].y = _damageContentTextArr[_loc1_].y + 30;
               _startResetBtnArr[_loc1_].y = _startResetBtnArr[_loc1_].y + 30;
            }
            _loc1_++;
         }
         _items = new Vector.<StoreCell>();
         _items[0] = new GodRefiningItemCell(0);
         PositionUtils.setPos(_items[0],"ddtstore.godRefining.resetItemCellPos");
         addChild(_items[0]);
         _items[1] = new GodRefiningStoneCell(["3"],1);
         PositionUtils.setPos(_items[1],"ddtstore.godRefining.resetClipCellPos");
         addChild(_items[1]);
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _startResetBtnArr.length)
         {
            _startResetBtnArr[_loc1_].addEventListener("click",__resetBtnHandler);
            _loc1_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].info = null;
            _loc1_++;
         }
      }
      
      private function getCurCellIndex(param1:ItemTemplateInfo) : int
      {
         if(EquipType.isArmShell(param1))
         {
            return 0;
         }
         if(EquipType.isArmShellResetStone(param1))
         {
            return 1;
         }
         return -1;
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in param1)
         {
            if(_loc2_ < _items.length)
            {
               _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            }
         }
      }
      
      public function quitStartDrag(param1:CEvent) : void
      {
         var _loc3_:BagCell = param1.data as BagCell;
         var _loc2_:int = getCurCellIndex(_loc3_.info);
         if(_loc2_ != -1)
         {
            startShine(_loc2_);
         }
      }
      
      public function quitStopDrag(param1:CEvent) : void
      {
         stopShine();
      }
      
      public function startShine(param1:int) : void
      {
         _items[param1].startShine();
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      public function equipDoubleClickMove(param1:CEvent) : void
      {
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0,1);
      }
      
      public function propDoubleClickMove(param1:CEvent) : void
      {
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,getCurCellIndex(_loc2_),1);
      }
      
      private function __resetBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = _startResetBtnArr.indexOf(param1.currentTarget as BaseButton);
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _startResetBtnArr.length)
         {
            _startResetBtnArr[_loc1_].removeEventListener("click",__resetBtnHandler);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _cellBg = null;
         _titleBmp = null;
         _tipText = null;
         _cBuyluckyBtn = null;
         _levelText = null;
         _damageTitleTextArr = null;
         _damageContentTextArr = null;
         _startResetBtnArr = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
