package store
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class StoreCell extends BagCell
   {
       
      
      protected var _shiner:ShineObject;
      
      protected var _index:int;
      
      public var DoubleClickEnabled:Boolean = true;
      
      public var mouseSilenced:Boolean = false;
      
      public function StoreCell(param1:Sprite, param2:int)
      {
         super(0,null,false,param1);
         _index = param2;
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.ddtstore.cellShine"));
         addChild(_shiner);
         var _loc3_:Boolean = false;
         _shiner.mouseEnabled = _loc3_;
         _shiner.mouseChildren = _loc3_;
         if(_cellMouseOverBg)
         {
            ObjectUtils.disposeObject(_cellMouseOverBg);
         }
         _cellMouseOverBg = null;
         tipDirctions = "7,5,2,6,4,1";
         PicPos = new Point(-2,-2);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("ddtstore.StoneCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
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
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((param1.currentTarget as BagCell).info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,index,itemBagType,-1);
            if(!mouseSilenced)
            {
               SoundManager.instance.play("008");
            }
         }
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.play("008");
         }
         dragStart();
      }
      
      public function get itemBagType() : int
      {
         if(info && (info.CategoryID == 10 || info.CategoryID == 11 || info.CategoryID == 12))
         {
            return 1;
         }
         return 0;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function startShine() : void
      {
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
         }
         _shiner = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
