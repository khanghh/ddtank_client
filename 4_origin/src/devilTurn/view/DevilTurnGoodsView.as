package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.model.DevilTurnGoodsItem;
   import devilTurn.view.mornui.DevilTurnGoodsViewUI;
   import flash.display.Shape;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import morn.core.handlers.Handler;
   
   public class DevilTurnGoodsView extends DevilTurnGoodsViewUI
   {
       
      
      private var _goodsList:Array;
      
      private var _box:GridBox;
      
      private var _closeCall:Function;
      
      private var _isAutoDispose:Boolean;
      
      private var _timer:uint;
      
      public function DevilTurnGoodsView(list:Array, isAutoDispose:Boolean, call:Function)
      {
         _goodsList = list;
         _isAutoDispose = isAutoDispose;
         _closeCall = call;
         if(_isAutoDispose)
         {
            _timer = setTimeout(dispose,2000);
         }
         super();
      }
      
      override protected function initialize() : void
      {
         var bagCell:* = null;
         var item:* = null;
         var i:int = 0;
         super.initialize();
         closeBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label5");
         closeBtn.clickHandler = new Handler(onClickCose);
         if(_goodsList.length == 1)
         {
            item = getRealGoodsTemaplteID(_goodsList[0]);
            bagCell = new BagCell(0,ItemManager.Instance.getTemplateById(item.TemplateID),false,getCellBg(66));
            bagCell.setCount(item.Value);
            addChild(bagCell);
            PositionUtils.setPos(bagCell,"devilTurn.goodsCellPos");
            return;
         }
         _box = new GridBox();
         PositionUtils.setPos(_box,"devilTurn.goodsBoxPos");
         _box.columnNumber = 5;
         _box.spacing = 5;
         _box.cellHeght = 50;
         for(i = 0; i < _goodsList.length; )
         {
            item = getRealGoodsTemaplteID(_goodsList[i]);
            bagCell = new BagCell(i,ItemManager.Instance.getTemplateById(item.TemplateID),false,getCellBg(50));
            bagCell.setCount(item.Value);
            _box.addChild(bagCell);
            i++;
         }
         addChild(_box);
      }
      
      private function getRealGoodsTemaplteID(data:Object) : DevilTurnGoodsItem
      {
         var item:DevilTurnGoodsItem = DevilTurnManager.instance.model.getGoodsItemByID(data.id);
         var newItem:DevilTurnGoodsItem = new DevilTurnGoodsItem();
         newItem.Value = 1;
         newItem.TemplateID = item.TemplateID;
         if(item.Type == 3)
         {
            newItem.TemplateID = EquipType.DEVIL_TURN_BEADLIST[data.type - 1];
         }
         if(item.Type == 2)
         {
            newItem.Value = item.Value;
         }
         return newItem;
      }
      
      private function getCellBg(size:int) : Shape
      {
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,size,size);
         cellBg.graphics.endFill();
         return cellBg;
      }
      
      private function onClickCose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         if(_timer)
         {
            clearTimeout(_timer);
         }
         if(_closeCall)
         {
            _closeCall.call();
         }
         _closeCall = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         super.dispose();
      }
   }
}
