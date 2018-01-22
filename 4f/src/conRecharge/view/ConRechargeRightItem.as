package conRecharge.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import flash.display.Sprite;
   
   public class ConRechargeRightItem extends Sprite implements Disposeable
   {
       
      
      private var _vbox:VBox;
      
      public function ConRechargeRightItem(){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}

import bagAndInfo.cell.BagCell;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.BaseButton;
import com.pickgliss.ui.controls.container.HBox;
import com.pickgliss.ui.core.Component;
import com.pickgliss.utils.ObjectUtils;
import conRecharge.ConRechargeManager;
import ddt.data.goods.InventoryItemInfo;
import ddt.data.goods.ItemTemplateInfo;
import ddt.manager.ItemManager;
import ddt.manager.SocketManager;
import ddt.utils.PositionUtils;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import wonderfulActivity.WonderfulActivityManager;
import wonderfulActivity.data.GiftBagInfo;
import wonderfulActivity.data.SendGiftInfo;

class DayItem extends Component
{
    
   
   private var _bg:Bitmap;
   
   private var _btn:BaseButton;
   
   private var _hbox:HBox;
   
   private var _info:GiftBagInfo;
   
   private var _statusArr:Array;
   
   private var _num:Sprite;
   
   function DayItem(param1:GiftBagInfo){super();}
   
   private function clickHandler(param1:MouseEvent) : void{}
   
   override public function dispose() : void{}
}
