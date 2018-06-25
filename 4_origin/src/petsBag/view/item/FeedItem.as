package petsBag.view.item
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.BagInfo;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import farm.viewx.FarmFieldBlock;
   import flash.events.MouseEvent;
   import petsBag.cmd.CmdShowPetFoodNumberSelectFrame;
   import petsBag.view.PetFoodNumberSelectFrame;
   
   public class FeedItem extends BaseCell
   {
       
      
      protected var _tbxCount:FilterFrameText;
      
      private var _shiner:ShineObject;
      
      public function FeedItem()
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.petsBag.petFeedPnlBg");
         initView();
         super(_bg,null,false);
      }
      
      private function initView() : void
      {
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.petBagSystem.cellShine"));
         addChild(_shiner);
         var _loc1_:Boolean = false;
         _shiner.mouseEnabled = _loc1_;
         _shiner.mouseChildren = _loc1_;
      }
      
      public function startShine() : void
      {
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
      }
      
      public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.MaxCount > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
      }
      
      private function __updateStoreBag(evt:BagEvent) : void
      {
         var temInfo:BagInfo = PlayerManager.Instance.Self.StoreBag;
         if(temInfo.items[0] == null || temInfo.items[0].CategoryID != 34)
         {
            this.info = null;
            return;
         }
         this.info = temInfo.items[0];
      }
      
      override protected function onMouseClick(evt:MouseEvent) : void
      {
         if(_info && allowDrag)
         {
            SoundManager.instance.play("008");
            dragStart();
         }
      }
      
      override protected function removeEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         super.removeEvent();
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _info as InventoryItemInfo;
      }
      
      override public function set info(value:ItemTemplateInfo) : void
      {
         .super.info = value;
         updateCount();
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(!this.mouseEnabled)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var sourceInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(sourceInfo && sourceInfo.CategoryID == 34)
         {
            new CmdShowPetFoodNumberSelectFrame().excute(sourceInfo);
            effect.action = "none";
            DragManager.acceptDrag(this);
         }
         else
         {
            effect.action = "none";
            DragManager.acceptDrag(this);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.current"));
         }
      }
      
      private function needMaxFood(hunger:int, addHunger:int) : int
      {
         var maxFood:int = 0;
         var limitHunger:int = PetconfigAnalyzer.PetCofnig.MaxHunger - hunger;
         maxFood = Math.ceil(limitHunger / addHunger);
         return maxFood;
      }
      
      protected function __onFoodAmountResponse(event:FrameEvent) : void
      {
         var foodInfo:* = null;
         SoundManager.instance.play("008");
         var frame:PetFoodNumberSelectFrame = PetFoodNumberSelectFrame(event.currentTarget);
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               frame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               foodInfo = frame.foodInfo;
               if(info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(foodInfo.BagType,foodInfo.Place,12,0,frame.amount,true);
               frame.dispose();
         }
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         var $info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(effect.action == "move" && effect.target == null)
         {
            if($info && $info.BagType == 11)
            {
               effect.action = "none";
               super.dragStop(effect);
            }
            else if($info && $info.BagType == 12)
            {
               locked = false;
            }
            else
            {
               locked = false;
            }
         }
         else if(effect.action == "split" && effect.target == null)
         {
            locked = false;
         }
         else if(effect.target is FarmFieldBlock)
         {
            locked = false;
         }
         else
         {
            super.dragStop(effect);
         }
      }
      
      override public function dispose() : void
      {
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
            _tbxCount = null;
         }
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
