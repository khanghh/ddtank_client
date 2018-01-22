package horse.amulet
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import horse.HorseAmuletManager;
   
   public class HorseAmuletCell extends BagCell
   {
       
      
      private var _isLock:Boolean;
      
      private var _lockIcon:Bitmap;
      
      public function HorseAmuletCell(param1:int, param2:ItemTemplateInfo = null, param3:DisplayObject = null){super(null,null,null,null,null);}
      
      public function Lock() : Boolean{return false;}
      
      public function smash() : void{}
      
      private function __onConfirmResponse(param1:FrameEvent) : void{}
      
      override public function dragStart() : void{}
      
      override public function dragDrop(param1:DragEffect) : void{}
      
      override public function dragStop(param1:DragEffect) : void{}
      
      override public function set info(param1:ItemTemplateInfo) : void{}
      
      override public function dispose() : void{}
   }
}
