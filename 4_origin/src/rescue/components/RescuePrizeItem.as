package rescue.components
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import rescue.RescueControl;
   import rescue.data.RescueRewardInfo;
   
   public class RescuePrizeItem extends Sprite implements Disposeable
   {
       
      
      private var _sp:Sprite;
      
      private var _bg:Bitmap;
      
      private var _prizeImg:Bitmap;
      
      private var _bagCell:BagCell;
      
      private var _alreadyGet:Bitmap;
      
      private var _index:int;
      
      private var _downFlag:Boolean;
      
      public function RescuePrizeItem(index:int)
      {
         _index = index;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _sp = new Sprite();
         addChild(_sp);
         _bg = ComponentFactory.Instance.creat("rescue.prizeBg");
         _sp.addChild(_bg);
         _bagCell = CellFactory.instance.createBagCell(0) as BagCell;
         _bagCell.scaleX = 1.1;
         _bagCell.scaleY = 1.1;
         _bagCell.x = 15;
         _bagCell.y = 10;
         _sp.addChild(_bagCell);
         _prizeImg = ComponentFactory.Instance.creat("rescue.starPrize" + _index);
         PositionUtils.setPos(_prizeImg,"rescue.starPrizePos");
         _sp.addChild(_prizeImg);
         _alreadyGet = ComponentFactory.Instance.creat("rescue.alreadyGet");
         addChild(_alreadyGet);
         _alreadyGet.visible = false;
      }
      
      private function addEvents() : void
      {
         _sp.buttonMode = true;
         _sp.addEventListener("mouseDown",__mouseDown);
         _sp.addEventListener("mouseUp",__mouseUp);
         _sp.addEventListener("mouseOver",__mouseOver);
         _sp.addEventListener("mouseOut",__mouseOut);
      }
      
      protected function __mouseOut(event:MouseEvent) : void
      {
         if(_downFlag)
         {
            _sp.x = _sp.x - 1;
            _sp.y = _sp.y - 1;
            _downFlag = false;
         }
         _sp.filters = null;
      }
      
      protected function __mouseOver(event:MouseEvent) : void
      {
         _sp.filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      protected function __mouseUp(event:MouseEvent) : void
      {
         if(_downFlag)
         {
            _sp.x = _sp.x - 1;
            _sp.y = _sp.y - 1;
            _downFlag = false;
         }
      }
      
      protected function __mouseDown(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _sp.x = _sp.x + 1;
         _sp.y = _sp.y + 1;
         _downFlag = true;
         SocketManager.Instance.out.getRescuePrize(RescueControl.instance.curSceneId,_index + 1);
      }
      
      public function setData(reward:RescueRewardInfo) : void
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = reward.TemplateID;
         info = ItemManager.fill(info);
         info.IsBinds = reward.IsBind;
         info.ValidDate = reward.ValidDate;
         info.StrengthenLevel = reward.StrengthenLevel;
         info.AttackCompose = reward.AttackCompose;
         info.DefendCompose = reward.DefendCompose;
         info.AgilityCompose = reward.AgilityCompose;
         info.LuckCompose = reward.LuckCompose;
         _bagCell.info = info;
         _bagCell.setCountNotVisible();
         _bagCell.setBgVisible(false);
      }
      
      public function setStatus(value:int) : void
      {
         switch(int(value))
         {
            case 0:
               _sp.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _alreadyGet.visible = false;
               removeEvents();
               break;
            case 1:
               _sp.filters = null;
               _alreadyGet.visible = false;
               addEvents();
               break;
            case 2:
               _sp.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _alreadyGet.visible = true;
               removeEvents();
         }
      }
      
      private function removeEvents() : void
      {
         _sp.buttonMode = false;
         _sp.removeEventListener("mouseDown",__mouseDown);
         _sp.removeEventListener("mouseUp",__mouseUp);
         _sp.removeEventListener("mouseOver",__mouseOver);
         _sp.removeEventListener("mouseOut",__mouseOut);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_sp);
         _sp = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_prizeImg);
         _prizeImg = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         ObjectUtils.disposeObject(_alreadyGet);
         _alreadyGet = null;
      }
   }
}
