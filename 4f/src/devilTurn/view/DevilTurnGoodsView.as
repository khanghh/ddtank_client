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
      
      public function DevilTurnGoodsView(param1:Array, param2:Boolean, param3:Function){super();}
      
      override protected function initialize() : void{}
      
      private function getRealGoodsTemaplteID(param1:Object) : DevilTurnGoodsItem{return null;}
      
      private function getCellBg(param1:int) : Shape{return null;}
      
      private function onClickCose() : void{}
      
      override public function dispose() : void{}
   }
}
