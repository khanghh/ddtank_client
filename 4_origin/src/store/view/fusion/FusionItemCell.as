package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.StrengthDataManager;
   import store.view.StoneCellFrame;
   
   public class FusionItemCell extends StoreCell
   {
      
      public static const SHINE_XY:int = 8;
      
      public static const SHINE_SIZE:int = 76;
       
      
      private var bg:Sprite;
      
      private var canMouseEvt:Boolean;
      
      private var _cellBg:StoneCellFrame;
      
      private var _autoSplit:Boolean;
      
      public function FusionItemCell($index:int)
      {
         bg = new Sprite();
         canMouseEvt = true;
         _cellBg = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.Material");
         _cellBg.label = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.MaterialCellText");
         bg.addChild(_cellBg);
         super(bg,$index);
         PicPos = new Point(10,10);
      }
      
      public function set bgVisible(boo:Boolean) : void
      {
         bg.alpha = int(boo);
      }
      
      override public function startShine() : void
      {
         _shiner.x = 8;
         _shiner.y = 8;
         var _loc1_:int = 76;
         _shiner.height = _loc1_;
         _shiner.width = _loc1_;
         super.startShine();
      }
      
      public function set mouseEvt(boo:Boolean) : void
      {
         canMouseEvt = boo;
      }
      
      override protected function __doubleClickHandler(evt:InteractiveEvent) : void
      {
         if(!canMouseEvt)
         {
            return;
         }
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((evt.currentTarget as BagCell).info != null)
         {
            if((evt.currentTarget as BagCell).info != null)
            {
               if(StrengthDataManager.instance.autoFusion)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
               }
               else
               {
                  SocketManager.Instance.out.sendMoveGoods(12,index,itemBagType,-1);
               }
               if(!mouseSilenced)
               {
                  SoundManager.instance.play("008");
               }
            }
         }
      }
      
      override protected function __clickHandler(evt:InteractiveEvent) : void
      {
         if(!canMouseEvt)
         {
            return;
         }
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.play("008");
         }
         dragStart();
      }
      
      override public function dragStart() : void
      {
         super.dragStart();
         StoreIIFusionBG.lastIndexFusion = index;
      }
      
      override public function dragStop(effect:DragEffect) : void
      {
         super.dragStop(effect);
         StoreIIFusionBG.lastIndexFusion = -1;
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         if(sp)
         {
            sp.width = _contentWidth - 18;
            sp.height = _contentHeight - 18;
            if(_picPos != null)
            {
               sp.x = _picPos.x;
            }
            else
            {
               sp.x = Math.abs(sp.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               sp.y = _picPos.y;
            }
            else
            {
               sp.y = Math.abs(sp.height - _contentHeight) / 2;
            }
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("ddtstore.StoreIIFusionBG.FunsionstoneCountTextII");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         var _aler:* = null;
         if(!canMouseEvt)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var sourceInfo:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(sourceInfo.BagType == 12 && this.info != null)
         {
            return;
         }
         if(sourceInfo && effect.action != "split")
         {
            effect.action = "none";
            if(sourceInfo.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.overdue"));
               return;
            }
            if(sourceInfo.Property1 == "8")
            {
               return;
            }
            if(sourceInfo.FusionType == 0 || sourceInfo.FusionRate == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.fusion"));
               return;
            }
            if(StrengthDataManager.instance.autoFusion)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
               effect.action = "none";
               DragManager.acceptDrag(this);
               return;
            }
            if(sourceInfo.Count > 1)
            {
               _autoSplit = (this.parent as StoreIIFusionBG).isAutoSplit;
               if(_autoSplit && StoreIIFusionBG.lastIndexFusion == -1)
               {
                  StoreIIFusionBG.autoSplitSend(sourceInfo.BagType,sourceInfo.Place,12,StoreIIFusionBG.getRemainIndexByEmpty(sourceInfo.Count,this.parent as StoreIIFusionBG),sourceInfo.Count,true,this.parent as StoreIIFusionBG);
               }
               else
               {
                  _aler = ComponentFactory.Instance.creat("ddtstore.FusionSelectNumAlertFrame");
                  _aler.goodsinfo = sourceInfo;
                  _aler.index = index;
                  _aler.show(sourceInfo.Count);
                  _aler.addEventListener("sell",_alerSell);
                  _aler.addEventListener("notsell",_alerNotSell);
               }
            }
            else
            {
               SocketManager.Instance.out.sendMoveGoods(sourceInfo.BagType,sourceInfo.Place,12,index,sourceInfo.Count,true);
            }
            effect.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      private function _alerSell(e:FusionSelectEvent) : void
      {
         var _aler:FusionSelectNumAlertFrame = e.currentTarget as FusionSelectNumAlertFrame;
         SocketManager.Instance.out.sendMoveGoods(e.info.BagType,e.info.Place,12,e.index,e.sellCount,true);
         _aler.removeEventListener("sell",_alerSell);
         _aler.removeEventListener("notsell",_alerNotSell);
         _aler.dispose();
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function _alerNotSell(e:FusionSelectEvent) : void
      {
         var _aler:FusionSelectNumAlertFrame = e.currentTarget as FusionSelectNumAlertFrame;
         _aler.removeEventListener("sell",_alerSell);
         _aler.removeEventListener("notsell",_alerNotSell);
         _aler.dispose();
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_cellBg)
         {
            ObjectUtils.disposeObject(_cellBg);
         }
         _cellBg = null;
      }
   }
}
