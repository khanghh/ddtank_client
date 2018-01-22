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
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class GodRefiningComposeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _cellBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _tipText:FilterFrameText;
      
      private var _needNumText:FilterFrameText;
      
      private var _startComposeBtn:BaseButton;
      
      private var _items:Vector.<BagCell>;
      
      public function GodRefiningComposeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.composeViewBg");
         addChild(_bg);
         _cellBg = ComponentFactory.Instance.creatBitmap("asset.godRefining.composeViewCellBg");
         addChild(_cellBg);
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.godRefining.composeTitleBmp");
         addChild(_titleBmp);
         _tipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.tipText");
         PositionUtils.setPos(_tipText,"ddtstore.godRefiningComposeView.tipTextPos");
         _tipText.text = LanguageMgr.GetTranslation("store.godRefining.tipTextMsg2");
         addChild(_tipText);
         _needNumText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.needNumText");
         PositionUtils.setPos(_needNumText,"ddtstore.godRefiningComposeView.needNumTextPos");
         _needNumText.text = "(20/5)";
         addChild(_needNumText);
         _startComposeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.startComposeBtn");
         addChild(_startComposeBtn);
         _items = new Vector.<BagCell>();
         _items[0] = new GodRefiningChipCell(["3"],0);
         PositionUtils.setPos(_items[0],"ddtstore.godRefining.composeClipCellPos");
         addChild(_items[0]);
         _items[1] = new GodRefiningPreItemCell();
         PositionUtils.setPos(_items[1],"ddtstore.godRefining.composeItemCellPos");
         addChild(_items[1]);
      }
      
      private function initEvent() : void
      {
         _startComposeBtn.addEventListener("click",__startComposeBtnHandler);
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
         if(EquipType.isArmShellClip(param1))
         {
            return 0;
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
         var _loc2_:StoreCell = _items[param1] as StoreCell;
         if(_loc2_)
         {
            _loc2_.startShine();
         }
      }
      
      public function stopShine() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as StoreCell;
            if(_loc1_)
            {
               _loc1_.stopShine();
            }
            _loc2_++;
         }
      }
      
      public function equipDoubleClickMove(param1:CEvent) : void
      {
      }
      
      public function propDoubleClickMove(param1:CEvent) : void
      {
         var _loc3_:InventoryItemInfo = param1.data as InventoryItemInfo;
         var _loc2_:int = getCurCellIndex(_loc3_);
         if(_loc2_ != -1)
         {
            SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_,1);
         }
      }
      
      private function __startComposeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvent() : void
      {
         _startComposeBtn.removeEventListener("click",__startComposeBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _cellBg = null;
         _titleBmp = null;
         _tipText = null;
         _needNumText = null;
         _startComposeBtn = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
