package texpSystem.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import texpSystem.data.TexpInfo;
   
   public class TexpCell extends BagCell
   {
       
      
      private var _texpInfo:TexpInfo;
      
      private var _shiner:ShineObject;
      
      private var _texpCountSelectFrame:TexpCountSelectFrame;
      
      public function TexpCell()
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.texpSystem.itemBg1");
         _loc1_.addChild(_loc2_);
         super(0,null,true,_loc1_);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.texpSystem.cellShine"));
         addChild(_shiner);
         var _loc4_:Boolean = false;
         _shiner.mouseEnabled = _loc4_;
         _shiner.mouseChildren = _loc4_;
         var _loc3_:Rectangle = ComponentFactory.Instance.creatCustomObject("texpSystem.texpCell.content");
         setContentSize(_loc3_.width,_loc3_.height);
         PicPos = new Point(_loc3_.x,_loc3_.y);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      private function getNeedCount(param1:int) : int
      {
         var _loc2_:int = (_texpInfo.upExp - _texpInfo.currExp) / param1;
         if((_texpInfo.upExp - _texpInfo.currExp) % param1 > 0)
         {
            _loc2_ = int(_loc2_) + 1;
         }
         return _loc2_;
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_ && param1.action != "split")
         {
            if(_texpInfo.type == 5 || _texpInfo.type == 6)
            {
               if(_loc2_.CategoryID != 53)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
                  param1.action = "none";
                  return;
               }
            }
            else if(_loc2_.CategoryID != 20)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
               param1.action = "none";
               return;
            }
            if(this.info)
            {
               SocketManager.Instance.out.sendClearStoreBag();
            }
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0,_loc2_.Count,true);
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      private function __ontexpCountResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:InventoryItemInfo = _texpCountSelectFrame.texpInfo;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _texpCountSelectFrame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0,_texpCountSelectFrame.count,true);
               _texpCountSelectFrame.dispose();
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("texpSystem.txtCount");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
      }
      
      public function startShine() : void
      {
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
      }
      
      private function __clickHandler(param1:InteractiveEvent) : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.playButtonSound();
         }
         dragStart();
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:* = null;
         if(_info && !locked)
         {
            SoundManager.instance.playButtonSound();
            _loc2_ = _info as InventoryItemInfo;
            SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,1,0,_loc2_.Count,true);
            SocketManager.Instance.out.sendClearStoreBag();
            info = null;
         }
      }
      
      override public function dispose() : void
      {
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         if(_texpCountSelectFrame)
         {
            ObjectUtils.disposeObject(_texpCountSelectFrame);
            _texpCountSelectFrame = null;
         }
         super.dispose();
      }
      
      public function get texpInfo() : TexpInfo
      {
         return _texpInfo;
      }
      
      public function set texpInfo(param1:TexpInfo) : void
      {
         _texpInfo = param1;
      }
   }
}
