package wasteRecycle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import wasteRecycle.WasteRecycleController;
   import wasteRecycle.data.WasteRecycleGoodsInfo;
   
   public class WasteRecycleSelectFrame extends BaseAlerFrame
   {
       
      
      private var _nameText:FilterFrameText;
      
      private var _numberSelect:NumberSelecter;
      
      private var _scoreText:FilterFrameText;
      
      private var _cell:WasteRecycleCell;
      
      public function WasteRecycleSelectFrame(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onResponse(param1:int) : void{}
      
      public function show(param1:WasteRecycleCell) : void{}
      
      private function __onSelectedChange(param1:Event) : void{}
      
      private function updateTips() : void{}
      
      override public function dispose() : void{}
   }
}
