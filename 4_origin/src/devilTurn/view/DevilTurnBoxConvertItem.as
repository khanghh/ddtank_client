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
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,60,60);
         cellBg.graphics.endFill();
         _giftCell = new BagCell(0,null,false,cellBg);
         PositionUtils.setPos(_giftCell,"devilTurn.boxConvert.cellPos");
         addChild(_giftCell);
         beadList.renderHandler = new Handler(onBeadListRender);
         convertBtn.clickHandler = new Handler(onClickConvertBtn);
      }
      
      private function onBeadListRender(item:Box, index:int) : void
      {
         var data:* = null;
         var icon:Clip = item.getChildByName("icon") as Clip;
         var count:Label = item.getChildByName("count") as Label;
         if(index < beadList.array.length)
         {
            icon.visible = true;
            data = beadList.array[index] as Object;
            icon.index = data.beadType;
            count.text = "x" + data.beadCount;
         }
         else
         {
            icon.visible = false;
            count.text = "";
         }
      }
      
      public function set info(value:DevilTurnBoxItem) : void
      {
         _info = value;
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
         var i:int = 0;
         var data:* = null;
         var result:Array = [];
         var list:Array = _info.Exchange.split(",");
         for(i = 0; i < list.length; )
         {
            if(int(list[i]) > 0)
            {
               data = {
                  "beadType":i,
                  "beadCount":list[i]
               };
               result.push(data);
            }
            i++;
         }
         return result;
      }
      
      private function onClickConvertBtn() : void
      {
         var needBeadCount:int = 0;
         var myBeadCount:int = 0;
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
         var list:Array = beadConverList;
         var _loc6_:int = 0;
         var _loc5_:* = list;
         for each(var data in list)
         {
            needBeadCount = data.beadCount;
            myBeadCount = _model["beadCount" + (data.beadType + 1)];
            if(myBeadCount < needBeadCount)
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
