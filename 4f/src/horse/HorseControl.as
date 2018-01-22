package horse
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horse.amulet.HorseAmuletMainView;
   import horse.data.HorsePicCherishVo;
   import horse.horsePicCherish.HorsePicCherishFrame;
   import horse.horsePicCherish.HorsePicCherishTip;
   import horse.view.HorseFrame;
   import horse.view.HorseGetSkillView;
   import horse.view.HorseSkillCellTip;
   
   public class HorseControl extends EventDispatcher
   {
      
      private static var _instance:HorseControl;
       
      
      private var _horseFrame:HorseFrame;
      
      private var _horseAmuletFrame:HorseAmuletMainView;
      
      public function HorseControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : HorseControl{return null;}
      
      public function setup() : void{}
      
      protected function __onHideView(param1:Event) : void{}
      
      protected function __onOpenView(param1:Event) : void{}
      
      private function frameDisposeHandler(param1:ComponentEvent) : void{}
      
      public function closeFrame() : void{}
      
      public function upFloatCartoonPlayComplete() : void{}
      
      protected function __onShowSkillView(param1:Event) : void{}
      
      private function openGetNewSkillView() : void{}
      
      private function updateHorse() : void{}
      
      public function getHorsePicCherishState(param1:int, param2:int) : Array{return null;}
      
      public function getHorsePicCherishAddProperty(param1:int) : Array{return null;}
      
      public function openHorseMainView() : void{}
      
      private function __onDispose(param1:ComponentEvent) : void{}
   }
}
