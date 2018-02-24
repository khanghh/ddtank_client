package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   
   public class WorldBossConfirmFrame extends WorldBossBuyBuffConfirmFrame
   {
       
      
      protected var _responseCellBack:Function;
      
      protected var _selectedCheckButtonCellBack:Function;
      
      private var _selectedItem:DoubleSelectedItem;
      
      public function WorldBossConfirmFrame(){super();}
      
      public function showFrame(param1:String, param2:String, param3:Function = null, param4:Function = null) : void{}
      
      public function get selectedItem() : DoubleSelectedItem{return null;}
      
      override protected function __framePesponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
      
      override protected function __noAlertTip(param1:Event) : void{}
   }
}
