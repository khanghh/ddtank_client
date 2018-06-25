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
         var a:int = 0;
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
         for(a = 0; a < 2; )
         {
            _damageTitleTextArr[a] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefiningResetView.damageTitleText");
            _damageTitleTextArr[a].text = LanguageMgr.GetTranslation("store.godRefiningResetView.damageTitleTextMsg","普通武器");
            addChild(_damageTitleTextArr[a]);
            _damageContentTextArr[a] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefiningResetView.damageContentText");
            _damageContentTextArr[a].text = "+20%";
            addChild(_damageContentTextArr[a]);
            _startResetBtnArr[a] = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.startResetBtn");
            addChild(_startResetBtnArr[a]);
            if(a == 1)
            {
               _damageTitleTextArr[a].y = _damageTitleTextArr[a].y + 30;
               _damageContentTextArr[a].y = _damageContentTextArr[a].y + 30;
               _startResetBtnArr[a].y = _startResetBtnArr[a].y + 30;
            }
            a++;
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
         var i:int = 0;
         for(i = 0; i < _startResetBtnArr.length; )
         {
            _startResetBtnArr[i].addEventListener("click",__resetBtnHandler);
            i++;
         }
      }
      
      public function updateView() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].info = null;
            i++;
         }
      }
      
      private function getCurCellIndex(itemInfo:ItemTemplateInfo) : int
      {
         if(EquipType.isArmShell(itemInfo))
         {
            return 0;
         }
         if(EquipType.isArmShellResetStone(itemInfo))
         {
            return 1;
         }
         return -1;
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(itemPlace in items)
         {
            if(itemPlace < _items.length)
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
         }
      }
      
      public function quitStartDrag(evt:CEvent) : void
      {
         var cell:BagCell = evt.data as BagCell;
         var index:int = getCurCellIndex(cell.info);
         if(index != -1)
         {
            startShine(index);
         }
      }
      
      public function quitStopDrag(evt:CEvent) : void
      {
         stopShine();
      }
      
      public function startShine(cellId:int) : void
      {
         _items[cellId].startShine();
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      public function equipDoubleClickMove(event:CEvent) : void
      {
         var info:InventoryItemInfo = event.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,0,1);
      }
      
      public function propDoubleClickMove(event:CEvent) : void
      {
         var info:InventoryItemInfo = event.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,getCurCellIndex(info),1);
      }
      
      private function __resetBtnHandler(event:MouseEvent) : void
      {
         var index:int = _startResetBtnArr.indexOf(event.currentTarget as BaseButton);
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _startResetBtnArr.length; )
         {
            _startResetBtnArr[i].removeEventListener("click",__resetBtnHandler);
            i++;
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
