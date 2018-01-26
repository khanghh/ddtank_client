package signBuff.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import signBuff.SignBuffManager;
   
   public class PowerItem extends Sprite implements Disposeable
   {
       
      
      private var _powerTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _getBtn:BaseButton;
      
      private var _hasGet:Bitmap;
      
      private var _index:int;
      
      private var _arr:Array;
      
      public function PowerItem(param1:Array, param2:int){super();}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function changeNum(param1:int) : String{return null;}
      
      public function dispose() : void{}
   }
}
