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
      
      public function DevilTurnGoodsView(param1:Array, param2:Boolean, param3:Function)
      {
         _goodsList = param1;
         _isAutoDispose = param2;
         _closeCall = param3;
         if(_isAutoDispose)
         {
            _timer = setTimeout(dispose,2000);
         }
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         super.initialize();
         closeBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label5");
         closeBtn.clickHandler = new Handler(onClickCose);
         if(_goodsList.length == 1)
         {
            _loc2_ = getRealGoodsTemaplteID(_goodsList[0]);
            _loc1_ = new BagCell(0,ItemManager.Instance.getTemplateById(_loc2_.TemplateID),false,getCellBg(66));
            _loc1_.setCount(_loc2_.Value);
            addChild(_loc1_);
            PositionUtils.setPos(_loc1_,"devilTurn.goodsCellPos");
            return;
         }
         _box = new GridBox();
         PositionUtils.setPos(_box,"devilTurn.goodsBoxPos");
         _box.columnNumber = 5;
         _box.spacing = 5;
         _box.cellHeght = 50;
         _loc3_ = 0;
         while(_loc3_ < _goodsList.length)
         {
            _loc2_ = getRealGoodsTemaplteID(_goodsList[_loc3_]);
            _loc1_ = new BagCell(_loc3_,ItemManager.Instance.getTemplateById(_loc2_.TemplateID),false,getCellBg(50));
            _loc1_.setCount(_loc2_.Value);
            _box.addChild(_loc1_);
            _loc3_++;
         }
         addChild(_box);
      }
      
      private function getRealGoodsTemaplteID(param1:Object) : DevilTurnGoodsItem
      {
         var _loc3_:DevilTurnGoodsItem = DevilTurnManager.instance.model.getGoodsItemByID(param1.id);
         var _loc2_:DevilTurnGoodsItem = new DevilTurnGoodsItem();
         _loc2_.Value = 1;
         _loc2_.TemplateID = _loc3_.TemplateID;
         if(_loc3_.Type == 3)
         {
            _loc2_.TemplateID = EquipType.DEVIL_TURN_BEADLIST[param1.type - 1];
         }
         if(_loc3_.Type == 2)
         {
            _loc2_.Value = _loc3_.Value;
         }
         return _loc2_;
      }
      
      private function getCellBg(param1:int) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,param1,param1);
         _loc2_.graphics.endFill();
         return _loc2_;
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
