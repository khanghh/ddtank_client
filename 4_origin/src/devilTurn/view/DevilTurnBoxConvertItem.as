package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.model.DevilTurnBoxItem;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.view.mornui.DevilTurnBoxConvertItemUI;
   import flash.display.Shape;
   import morn.core.components.Box;
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.handlers.Handler;
   
   public class DevilTurnBoxConvertItem extends DevilTurnBoxConvertItemUI
   {
       
      
      private var _model:DevilTurnModel;
      
      private var _giftCell:BagCell;
      
      private var _info:DevilTurnBoxItem;
      
      public function DevilTurnBoxConvertItem()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         _model = DevilTurnManager.instance.model;
         super.preinitialize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,60,60);
         _loc1_.graphics.endFill();
         _giftCell = new BagCell(0,null,false,_loc1_);
         PositionUtils.setPos(_giftCell,"devilTurn.boxConvert.cellPos");
         addChild(_giftCell);
         beadList.renderHandler = new Handler(onBeadListRender);
         convertBtn.clickHandler = new Handler(onClickConvertBtn);
      }
      
      private function onBeadListRender(param1:Box, param2:int) : void
      {
         var _loc5_:* = null;
         var _loc3_:Clip = param1.getChildByName("icon") as Clip;
         var _loc4_:Label = param1.getChildByName("count") as Label;
         if(param2 < beadList.array.length)
         {
            _loc3_.visible = true;
            _loc5_ = beadList.array[param2] as Object;
            _loc3_.index = _loc5_.beadType;
            _loc4_.text = "x" + _loc5_.beadCount;
         }
         else
         {
            _loc3_.visible = false;
            _loc4_.text = "";
         }
      }
      
      public function set info(param1:DevilTurnBoxItem) : void
      {
         _info = param1;
         if(_info)
         {
            _giftCell.info = ItemManager.Instance.getTemplateById(_info.ID);
            beadList.array = beadConverList;
         }
         else
         {
            _giftCell.info = null;
         }
      }
      
      private function get beadConverList() : Array
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Array = [];
         var _loc3_:Array = _info.Exchange.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(int(_loc3_[_loc4_]) > 0)
            {
               _loc2_ = {
                  "beadType":_loc4_,
                  "beadCount":_loc3_[_loc4_]
               };
               _loc1_.push(_loc2_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function onClickConvertBtn() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         var _loc3_:Array = beadConverList;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc4_ = _loc2_.beadCount;
            _loc1_ = _model["beadCount" + (_loc2_.beadType + 1)];
            if(_loc1_ < _loc4_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.notBoxConvert"));
               return;
            }
         }
         SocketManager.Instance.out.sendDevilTurnBeadConversion(_info.ID);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_giftCell);
         _giftCell = null;
         _model = null;
         _info = null;
         super.dispose();
      }
   }
}
