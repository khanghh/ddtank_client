package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class TexpCountSelectFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _text:FilterFrameText;
      
      private var _numberSelecter:NumberSelecter;
      
      private var _needText:FilterFrameText;
      
      private var _texpInfo:InventoryItemInfo;
      
      public function TexpCountSelectFrame(){super();}
      
      private function intView() : void{}
      
      public function show(param1:int, param2:int, param3:int = 1) : void{}
      
      private function __seleterChange(param1:Event) : void{}
      
      public function get texpInfo() : InventoryItemInfo{return null;}
      
      public function set texpInfo(param1:InventoryItemInfo) : void{}
      
      public function get count() : int{return 0;}
      
      override public function dispose() : void{}
      
      private function removeView() : void{}
   }
}
