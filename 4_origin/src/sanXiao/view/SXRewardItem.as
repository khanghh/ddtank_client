package sanXiao.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sanXiao.SanXiaoManager;
   import sanXiao.model.SXRewardItemData;
   
   public class SXRewardItem extends Sprite implements Disposeable
   {
       
      
      private var _data:SXRewardItemData;
      
      private var _scoreNeededText:FilterFrameText;
      
      private var _priseItem:BagCell;
      
      private var _btnGainPrise:SimpleBitmapButton;
      
      private var _gainedBmp:Bitmap;
      
      public function SXRewardItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _scoreNeededText = ComponentFactory.Instance.creat("sanxiao.storeItemPrice.Txt");
         PositionUtils.setPos(_scoreNeededText,"sanxiao.detailItemScore.pt");
         addChild(_scoreNeededText);
         _priseItem = new BagCell(0);
         PositionUtils.setPos(_priseItem,"sanxiao.detailItemBagCell.pt");
         addChild(_priseItem);
         _btnGainPrise = ComponentFactory.Instance.creat("sanxiao.gainPrise.btn");
         _btnGainPrise.addEventListener("click",onGainPriseClick);
         addChild(_btnGainPrise);
         _gainedBmp = ComponentFactory.Instance.creatBitmap("ast.sanxiao.gainedBmp");
         _gainedBmp.x = _btnGainPrise.x + (_btnGainPrise.width - _gainedBmp.width) * 0.5;
         _gainedBmp.y = _btnGainPrise.y + (_btnGainPrise.height - _gainedBmp.height) * 0.5;
      }
      
      protected function onGainPriseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_data == null)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         GameInSocketOut.sendSXGainPrise(_data.id);
      }
      
      public function update(param1:Object) : void
      {
         _data = param1 as SXRewardItemData;
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,ItemManager.Instance.getTemplateById(_data.TempleteID));
         _loc2_.ValidDate = _data.Valid;
         _loc2_.Count = _data.count;
         _loc2_.Property5 = "1";
         _loc2_.IsBinds = _data.isBind;
         _priseItem.info = _loc2_;
         _priseItem.setCount(_loc2_.Count);
         _scoreNeededText.text = _data.point.toString();
         _btnGainPrise.enable = SanXiaoManager.getInstance().score >= _data.point && !_data.gained;
         if(_data.gained)
         {
            addChild(_gainedBmp);
            _btnGainPrise.parent && removeChild(_btnGainPrise);
         }
         else
         {
            _gainedBmp.parent && removeChild(_gainedBmp);
            addChild(_btnGainPrise);
         }
      }
      
      override public function get height() : Number
      {
         return 45;
      }
      
      public function dispose() : void
      {
         if(_btnGainPrise)
         {
            _btnGainPrise.removeEventListener("click",onGainPriseClick);
         }
         ObjectUtils.disposeAllChildren(this);
         _scoreNeededText = null;
         _priseItem = null;
         _btnGainPrise = null;
         _gainedBmp = null;
      }
   }
}
